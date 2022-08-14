import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:restowrent_v_two/hive_database/hive_model/hold_item/hive_hold_item.dart';
import 'package:restowrent_v_two/model/settled_order_response/settled_order.dart';
import 'package:restowrent_v_two/socket/socket_controller.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../../app_constans/api_link.dart';
import '../../../commoen/dio_error.dart';
import '../../../hive_database/box_repository.dart';
import '../../../hive_database/controller/hive_hold_bill_controller.dart';
import '../../../model/foods_respons/food_response.dart';
import '../../../model/kitchen_order_response/kitchen_order.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../model/kitchen_order_response/kitchen_order_array.dart';
import '../../../model/my_response.dart';
import '../../../model/settled_order_response/settled_order_array.dart';
import '../../../repository/foods_repo.dart';
import '../../../routes/route_helper.dart';
import '../../../services/service.dart';
import '../../../widget/app_alerts.dart';
import '../../../widget/snack_bar.dart';

class OrderViewController extends GetxController {
  final FoodsRepo _foodsRepo = Get.find<FoodsRepo>();
  final IO.Socket _socket = Get.find<SocketController>().socket;
  final HiveHoldBillController _hiveHoldBillController = Get.find<HiveHoldBillController>();
  final HttpService _httpService = Get.find<HttpService>();
  bool isLoading = false;
  bool isloading2 = false;

  //tochane tapped coloer of ordr status tab
  int tappedIndex = -1;
  String tappedTabName = 'KOT';

  ///bill settled///

  //this value will get when settle button is click in   settleKotBillingCash() is calling
  int indexFromKotOrder = -1;

  //this value will get when update button is click in   updateSettleBillingCash() is calling
  int indexSettledOrder = -1;

  //to dasable button after click settle button
  var isClickedSettle = false.obs;
  final RoundedLoadingButtonController btnControllerSettle = RoundedLoadingButtonController();
  final RoundedLoadingButtonController btnControllerCancellKOtOrder = RoundedLoadingButtonController();

  var grandTotal = 0.0.obs;
  var balanceChange = 0.0.obs;

  late Rx<TextEditingController> settleNetTotalCtrl;
  late Rx<TextEditingController> settleDiscountCashCtrl;
  late Rx<TextEditingController> settleDiscountPersentCtrl;
  late Rx<TextEditingController> settleChargesCtrl;
  late Rx<TextEditingController> settleGrandTotelCtrl;
  late Rx<TextEditingController> settleCashRecivedCtrl;

  double netTotal = 0;
  double discountCash = 0;
  double discountPresent = 0;
  double charges = 0;
  double cashReceived = 0;
  double grandTotalNew = 0;

  ///bill settle///

  List<KitchenOrder>? _kotBillingItems = [];
  List<SettledOrder>? _settledBillingItems = [];
  final List<HiveHoldItem> _holdBillingItems = [];

  List<KitchenOrder>? get kotBillingItems => _kotBillingItems;

  List<SettledOrder>? get settledBillingItems => _settledBillingItems;

  List<HiveHoldItem>? get holdBillingItems => _holdBillingItems;

  @override
  void onInit() async {
    _socket.connect();
    settleNetTotalCtrl = TextEditingController().obs;
    settleDiscountCashCtrl = TextEditingController().obs;
    settleDiscountPersentCtrl = TextEditingController().obs;
    settleChargesCtrl = TextEditingController().obs;
    settleGrandTotelCtrl = TextEditingController().obs;
    settleCashRecivedCtrl = TextEditingController().obs;
    getAllHoldOrder();
    setUpKitchenOrderFromDbListner(); //first load kotBill data from db
    setUpKitchenOrderSingleListener(); //for new kot order
    super.onInit();
  }

  @override
  void onClose() {
    _socket.close();
    _socket.dispose();
    super.onClose();
  }

  //for single order adding live
  setUpKitchenOrderSingleListener() {
    try {
      KitchenOrder order =
          KitchenOrder(fdOrderType: '', totelPrice: 0, fdOrderStatus: '', Kot_id: 0, errorCode: '', totalSize: 0, error: true, orderColor: 111);
      _socket.on('kitchen_orders_receive', (data) {
        print('kotorder single rcv');
        order = KitchenOrder.fromJson(data);
        //no error
        if (!order.error) {
          //check if item is already in list
          bool isExist = true;
          for (var element in _kotBillingItems!) {
            if (element.Kot_id != order.Kot_id) {
              isExist = false;
            } else {
              isExist = true;
            }
          }
          //add if not exist
          isExist == false ? _kotBillingItems!.add(order) : _kotBillingItems = _kotBillingItems;
          update();
        } else {
          return;
        }
      });
    } catch (e) {
      rethrow;
    }
  }

  //for first load data to bill from data base
  setUpKitchenOrderFromDbListner() {
    try {
      KitchenOrderArray order = KitchenOrderArray(error: true, errorCode: '', totalSize: 0);
      _socket.on('database-data-receive', (data) {
        print('kot socket database refresh');
        order = KitchenOrderArray.fromJson(data);
        List<KitchenOrder>? kitcheOrders = order.kitchenOrder;
        //no error
        if (!order.error) {
          //check if item is already in list
          _kotBillingItems!.clear();
          _kotBillingItems!
              .addAll(kitcheOrders!.where((newItem) => _kotBillingItems!.every((oldItem) => newItem.Kot_id != oldItem.Kot_id)));
          update();
        } else {
          return;
        }
      });
    } catch (e) {
      rethrow;
    }
  }

  //this emit will recive and emit from server to refresh data
  refreshDatabaseKot() {
    _socket.emit('refresh-database-order');
  }

  ////settle bill////

  //get all settled order
  getAllSettledOrder() async {
    try {
      showLoading();
      update();

      MyResponse response = await _foodsRepo.getAllSettledOrder();

      hideLoading();
      update();

      if (response.statusCode == 1) {
        SettledOrderArray parsedResponse = response.data;
        if (parsedResponse.data == null) {
          _settledBillingItems = [];
        } else {
          _settledBillingItems = parsedResponse.data;
          print('${_settledBillingItems}');
        }
      } else {
        print('${response.message}');
        AppSnackBar.errorSnackBar(response.status, response.message);
        return;
      }
    } catch (e) {
      rethrow;
    }
    update();
  }

  //checking int is in text field
  bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  calculateNetTotal() {
    try {
      netTotal = !isNumeric(settleNetTotalCtrl.value.text) ? 0 : double.parse(settleNetTotalCtrl.value.text);
      discountCash = !isNumeric(settleDiscountCashCtrl.value.text) ? 0 : double.parse(settleDiscountCashCtrl.value.text);
      discountPresent = !isNumeric(settleDiscountPersentCtrl.value.text) ? 0 : double.parse(settleDiscountPersentCtrl.value.text);
      charges = !isNumeric(settleChargesCtrl.value.text) ? 0 : double.parse(settleChargesCtrl.value.text);
      cashReceived = !isNumeric(settleCashRecivedCtrl.value.text) ? 0 : double.parse(settleCashRecivedCtrl.value.text);
      //finding discount value from %
      double discountCashFromPercent = (netTotal / 100) * discountPresent;

      grandTotal.value = netTotal - discountCash - discountCashFromPercent - charges;
      grandTotalNew = double.parse(grandTotal.value.toStringAsFixed(3));
      balanceChange.value =
          double.parse((settleCashRecivedCtrl.value.text == '' ? 0 : cashReceived - grandTotalNew).toStringAsFixed(3));
      settleGrandTotelCtrl.value.text = '$grandTotalNew';
    } catch (e) {
      rethrow;
    }
  }

  //settile billing kot cash alert showing this methd is coll on click settle btn
  settleKotBillingCash(context, ctrl, index) {
    indexFromKotOrder = index;
    try {
      settleNetTotalCtrl.value.text = (_kotBillingItems?[index].totelPrice ?? 0).toString();
      settleDiscountCashCtrl.value.text = '0';
      settleDiscountPersentCtrl.value.text = '0';
      settleChargesCtrl.value.text = '0';
      settleGrandTotelCtrl.value.text = '0';
      settleCashRecivedCtrl.value.text = '';
      //calculate totel an othr calculation
      calculateNetTotal();
      //this is settle screen alert ui
      //from is same  billing , so billing screen like (take away) and this alert popup ui is same
      billingCashScreenAlert(context: context, ctrl: ctrl, from: 'billing');
    } catch (e) {
      rethrow;
    }
  }

  //insert settiled bill from kot
  insertSettledBill(context) async {
    try {
      Map<String, dynamic> settledBill = {
        'fdShopId': 10,
        'fdOrder': indexFromKotOrder != -1 ? (_kotBillingItems?[indexFromKotOrder].fdOrder ?? []) : [],
        'fdOrderKot': _kotBillingItems?[indexFromKotOrder].Kot_id ?? -1,
        'fdOrderStatus': 'complete',
        'fdOrderType': _kotBillingItems?[indexFromKotOrder].fdOrderType ?? 'Take away',
        'netAmount': netTotal,
        'discountPersent': discountPresent,
        'discountCash': discountCash,
        'charges': charges,
        'grandTotal': grandTotalNew,
        'paymentType': 'cash',
        'cashReceived': cashReceived,
        'change': balanceChange.value
      };

      final response = await _httpService.insertWithBody(ADD_SETTLED_ORDER, settledBill);

      FoodResponse parsedResponse = FoodResponse.fromJson(response.data);
      if (parsedResponse.error) {
        print('paesed eero');
        btnControllerSettle.error();
        AppSnackBar.errorSnackBar('Error', parsedResponse.errorCode);
      } else {
        btnControllerSettle.success();
        AppSnackBar.successSnackBar('Success', parsedResponse.errorCode);
      }
    } on DioError catch (e) {
      print('dio eero');
      btnControllerSettle.error();
      AppSnackBar.errorSnackBar('Error', MyDioError.dioError(e));
    } catch (e) {
      btnControllerSettle.error();
      print('catch eero');
    } finally {
      print('finally');
      await Future.delayed(const Duration(seconds: 1), () {
        btnControllerSettle.reset();
      });
      await Future.delayed(const Duration(milliseconds: 300), () {
        //for refresh kot bill , so after settle itwill delete from kot bill
        refreshDatabaseKot();
        Navigator.pop(context);
      });
    }
  }

  //to delete/cacell settled order
  deleteSettledOrder(int settled_id) async {
    try {
      Map<String, dynamic> data = {
        'settled_id': settled_id,
      };
      final response = await _httpService.delete(DELETE_SETTLED_ORDER, data);
      FoodResponse parsedResponse = FoodResponse.fromJson(response.data);
      if (parsedResponse.error) {
        AppSnackBar.errorSnackBar('Error', parsedResponse.errorCode);
      } else {
        AppSnackBar.successSnackBar('Success', parsedResponse.errorCode);
      }
    } on DioError catch (e) {
      AppSnackBar.errorSnackBar('Error', MyDioError.dioError(e));
    } catch (e) {
      AppSnackBar.errorSnackBar('Error', 'Something wet to wrong');
    } finally {
      Future.delayed(const Duration(seconds: 1), () {});
      update();
    }
  }

  //update settled bill from settled bill list
  updateSettleBillingCash(context, ctrl, index) {
    indexSettledOrder = index;
    try {
      settleNetTotalCtrl.value.text = (_settledBillingItems?[index].netAmount ?? 0).toString();
      settleDiscountCashCtrl.value.text = (_settledBillingItems?[index].discountCash ?? 0).toString();
      settleDiscountPersentCtrl.value.text = (_settledBillingItems?[index].discountPersent ?? 0).toString();
      settleChargesCtrl.value.text = (_settledBillingItems?[index].charges ?? 0).toString();
      settleGrandTotelCtrl.value.text = (_settledBillingItems?[index].grandTotal ?? 0).toString();
      settleCashRecivedCtrl.value.text = (_settledBillingItems?[index].cashReceived ?? 0).toString();
      //calculate totel an othr calculation
      calculateNetTotal();
      //this is settle screen alert ui
      billingCashScreenAlert(context: context, ctrl: ctrl, from: 'updateSettle');
    } catch (e) {
      rethrow;
    }
  }

  //insert settiled bill from kot
  updateSettledBill(context) async {
    try {
      Map<String, dynamic> updatedSettledBill = {
        'settled_id': _settledBillingItems?[indexSettledOrder].settled_id ?? -1,
        'netAmount': netTotal,
        'discountPersent': discountPresent,
        'discountCash': discountCash,
        'charges': charges,
        'grandTotal': grandTotalNew,
        'paymentType': 'cash',
        'cashReceived': cashReceived,
        'change': balanceChange.value
      };

      final response = await _httpService.updateData(UPDATE_SETTLED_ORDER, updatedSettledBill);

      FoodResponse parsedResponse = FoodResponse.fromJson(response.data);
      if (parsedResponse.error) {
        print('paesed eero');
        btnControllerSettle.error();
        AppSnackBar.errorSnackBar('Error', parsedResponse.errorCode);
      } else {
        btnControllerSettle.success();
        AppSnackBar.successSnackBar('Success', parsedResponse.errorCode);
      }
    } on DioError catch (e) {
      print('dio eero');
      btnControllerSettle.error();
      AppSnackBar.errorSnackBar('Error', MyDioError.dioError(e));
    } catch (e) {
      btnControllerSettle.error();
      print('catch eero');
    } finally {
      print('finally');
      Future.delayed(const Duration(seconds: 1), () {
        btnControllerSettle.reset();
        //for refresh settled bill ,
        getAllSettledOrder();
        Navigator.pop(context);
      });
    }
  }

  ////settle bill////

  //get all hold order
  getAllHoldOrder() async {
    try {
      _holdBillingItems.clear();
      _holdBillingItems.addAll(_hiveHoldBillController.getHoldBill());
      update();
    } catch (e) {
      rethrow;
    }
    update();
  }

  //unhold holditem sedig data to illig scree
  unHoldHoldItem({required holdBillingItems, required int holdItemIndex, required String orderType}) async {
    switch (orderType) {
      case "Takeaway":
        {
          Get.offNamed(RouteHelper.getTakeAwayBillingScreen(), arguments: {'holdItem': holdBillingItems});
        }
        break;

      case "Home delivery":
        {
          Get.offNamed(RouteHelper.getHomeDeliveryScreen(), arguments: {'holdItem': holdBillingItems});
        }
        break;

      case "Online":
        {
          Get.offNamed(RouteHelper.getOnlineBookingBillingScreen(), arguments: {'holdItem': holdBillingItems});
        }
        break;

      case "Dining":
        {
          Get.offNamed(RouteHelper.getDiningBillingScreen(), arguments: {'holdItem': holdBillingItems});
        }
        break;

      default:
        {
          Get.offNamed(RouteHelper.getTakeAwayBillingScreen(), arguments: {'holdItem': holdBillingItems});
        }
        break;
    }

    //delete the hold item from hold item list
   await _hiveHoldBillController.deleteHoldBill(index: holdItemIndex);
  }

  //edit kot order or update kot order
  updateKotOrder({required kotBillingOrder, required String orderType}) {
    switch (orderType) {
      case "Takeaway":
        {
          Get.offNamed(RouteHelper.getTakeAwayBillingScreen(),
              arguments: {'kotItem': kotBillingOrder});
        }
        break;

      case "Home delivery":
        {
          Get.offNamed(RouteHelper.getHomeDeliveryScreen(),
              arguments: {'kotItem': kotBillingOrder});
        }
        break;

      case "Online":
        {
          Get.offNamed(RouteHelper.getOnlineBookingBillingScreen(),
              arguments: {'kotItem': kotBillingOrder});
        }
        break;

      case "Dining":
        {
          Get.offNamed(RouteHelper.getDiningBillingScreen(),
              arguments: {'kotItem': kotBillingOrder});
        }
        break;

      default:
        {
          Get.offNamed(RouteHelper.getTakeAwayBillingScreen(),
              arguments: {'kotItem': kotBillingOrder});
        }
        break;
    }
  }

//to delete/cacell kot order
  deleteKotOrder(int KotId) async {
    try {
      Map<String, dynamic> data = {
        'Kot_id': KotId,
      };
      final response = await _httpService.delete(DELETE_KOT_ORDER, data);
      FoodResponse parsedResponse = FoodResponse.fromJson(response.data);
      if (parsedResponse.error) {
        btnControllerCancellKOtOrder.error();
        AppSnackBar.errorSnackBar('Error', parsedResponse.errorCode);
      } else {
        btnControllerCancellKOtOrder.success();

        AppSnackBar.successSnackBar('Success', parsedResponse.errorCode);
      }
    } on DioError catch (e) {
      btnControllerCancellKOtOrder.error();
      AppSnackBar.errorSnackBar('Error', MyDioError.dioError(e));
    } catch (e) {
      btnControllerCancellKOtOrder.error();
      AppSnackBar.errorSnackBar('Error', 'Something wet to wrong');
    } finally {
      Future.delayed(const Duration(seconds: 1), () {
        btnControllerCancellKOtOrder.reset();
      });
      update();
    }
  }

  updateTappedTabName(String name) {
    print(name);
    tappedTabName = name;
    update();
  }

//add to setled food from kot order
  addToSettledFood() {
    print('object');
  }

//to change tapped category
  setStatusTappedIndex(int val) {
    tappedIndex = val;
    update();
  }

  showLoading() {
    isLoading = true;
  }

  hideLoading() {
    isLoading = false;
  }
}
