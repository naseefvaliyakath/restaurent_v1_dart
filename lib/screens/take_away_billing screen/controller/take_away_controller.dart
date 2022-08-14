import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:restowrent_v_two/app_constans/hive_costants.dart';
import 'package:restowrent_v_two/commoen/local_storage_controller.dart';
import 'package:restowrent_v_two/hive_database/controller/hive_hold_bill_controller.dart';
import 'package:restowrent_v_two/hive_database/hive_model/hold_item/hive_hold_item.dart';
import 'package:restowrent_v_two/model/my_response.dart';
import 'package:restowrent_v_two/repository/foods_repo.dart';
import 'package:restowrent_v_two/socket/socket_controller.dart';
import 'package:restowrent_v_two/widget/kot_bill_show_alert.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../../app_constans/api_link.dart';
import '../../../commoen/dio_error.dart';
import '../../../hive_database/box_repository.dart';
import '../../../model/foods_respons/food_response.dart';
import '../../../model/foods_respons/foods.dart';
import '../../../model/kitchen_order_response/kitchen_order.dart';
import '../../../model/kitchen_order_response/order_bill.dart';
import '../../../routes/route_helper.dart';
import '../../../services/service.dart';
import '../../../widget/app_alerts.dart';
import '../../../widget/snack_bar.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../order_view_screen/controller/order_view_controller.dart';

class TakeAwayController extends GetxController {
  final FoodsRepo _foodsRepo = Get.find<FoodsRepo>();
  late IO.Socket socket;
  final SocketController _socketCtrl = Get.find<SocketController>();
  final MyLocalStorage _myLocalStorage = Get.find<MyLocalStorage>();
  final HttpService _httpService = Get.find<HttpService>();
  final HiveHoldBillController _hiveHoldBillController = Get.find<HiveHoldBillController>();

  final RoundedLoadingButtonController btnControllerKot = RoundedLoadingButtonController();
  final RoundedLoadingButtonController btnControllerSettle = RoundedLoadingButtonController();
  final RoundedLoadingButtonController btnControllerHold = RoundedLoadingButtonController();
  final RoundedLoadingButtonController btnControllerUpdateKot = RoundedLoadingButtonController();

  bool isLoading = false;
  List<Foods>? _foods = [];

  List<Foods>? get foods => _foods;

  int _count = 1;

  int get count => _count;

  double _price = 0;

  double get price => _price;

  // billing list
  final List<dynamic> _billingItems = [];

  List<dynamic> get billingItems => _billingItems;

  // to visible and hide edit billing item in delete popup

  bool isVisibleEditBillItem = false;

  // totel price in bill
  double _totelPrice = 0;

  double get totelPrice => _totelPrice;

  //for search field text
  late TextEditingController searchTD;

  //to convert search query to obs for debounce
  var searchQuery = ''.obs;

  //to dasable button after click settle button
  var isClickedSettle = false.obs;

  //to check navigated from kotUpdate bill
  bool isNavigateFromKotUpdate = false;

  //kot id from orderview screen for update kot item,it will assign in when navigation
  //from kotupdate from orderview screen
  int kotIdReciveFromKotUpdate = -1;

  ///bill settled///

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

  @override
  void onInit() async {
    getxArgumetsReciveHadler();
    searchTD = TextEditingController();
    settleNetTotalCtrl = TextEditingController().obs;
    settleDiscountCashCtrl = TextEditingController().obs;
    settleDiscountPersentCtrl = TextEditingController().obs;
    settleChargesCtrl = TextEditingController().obs;
    settleGrandTotelCtrl = TextEditingController().obs;
    settleCashRecivedCtrl = TextEditingController().obs;
    socket = _socketCtrl.socket;
    await getTodayFoods();
    await initialLoadingBillFromHive();
    //only send search requst after typing 500 millisecond
    debounce(searchQuery, (callback) => searchTodayFoods(), time: const Duration(milliseconds: 500));
    super.onInit();
  }

  ////socket io////

  Future sendKotOrder() async {
    try {
      if (_billingItems.isNotEmpty) {
        Map<String, dynamic> kotOrder = {
          'fdShopId': 10,
          'fdOrder': _billingItems,
          'fdOrderStatus': 'pending',
          'fdOrderType': 'Takeaway',
        };

        final response = await _httpService.insertWithBody(ADD_KOT_ORDER, kotOrder);

        FoodResponse parsedResponse = FoodResponse.fromJson(response.data);
        if (parsedResponse.error) {
          btnControllerKot.error();
          AppSnackBar.errorSnackBar('Error', parsedResponse.errorCode);
        } else {
          print('object');
          _billingItems.clear();
          clearBillInHive();
          btnControllerKot.success();
          AppSnackBar.successSnackBar('Success', parsedResponse.errorCode);
          update();
        }
      }
      //if bill is empty
      else {
        btnControllerKot.error();
        AppSnackBar.errorSnackBar('No item added', 'No bills added');
      }
    } on DioError catch (e) {
      print('dio eero');
      btnControllerKot.error();
      AppSnackBar.errorSnackBar('Error', MyDioError.dioError(e));
    } catch (e) {
      btnControllerKot.error();
      print('catch eero');
    } finally {
      update();
      print('finally');
      Future.delayed(const Duration(seconds: 1), () {
        btnControllerKot.reset();
      });
    }
  }

  ///socket io ////

  /// edit or update kot billing item  to receive data for orderView screen and process ////

  reciveUpdateKotBillingItem() {
    try {
      //otherwaiys will throw error
      KitchenOrder emptyKotOrder = KitchenOrder(
          Kot_id: -1,
          error: true,
          errorCode: 'SomthingWrong',
          totalSize: 0,
          fdOrderStatus: 'Pending',
          fdOrderType: 'Takeaway',
          fdOrder: [],
          totelPrice: 0,
          orderColor: 111);
      var args = Get.arguments ?? {'kotItem': emptyKotOrder};
      KitchenOrder? kotOrder = args['kotItem'] ?? emptyKotOrder;
      kotIdReciveFromKotUpdate = kotOrder?.Kot_id ?? -1;
      List<OrderBill>? kotItem = kotOrder?.fdOrder;
      if (kotItem == null) {
        AppSnackBar.errorSnackBar('Something wrong', 'something went to wrong this order !! ');
        _billingItems.clear();
      } else {
        //from other pages than orderview screen
        if (kotItem.isEmpty) {
          //normal working will happened
          _billingItems.clear();
        } else {
          isNavigateFromKotUpdate = true; //to make kot update button
          clearBillInHive();
          _billingItems.clear();
          for (var element in kotItem) {
            _billingItems.add({
              'fdId': element.fdId,
              'name': element.name,
              'qnt': element.qnt,
              'price': element.price.toDouble(),
              'ktNote': element.ktNote
            });
          }
          find_totelPrice();
          update();
        }
      }
    } catch (e) {
      _billingItems.clear();
      rethrow;
    } finally {}
  }

  /// edit or update kot billing item  to receive data for orderView screen and process ////

  /// updatekot to server///

  Future updateKotOrder() async {
    try {
      if (_billingItems.isNotEmpty) {
        Map<String, dynamic> kotOrderUpdate = {'fdOrder': _billingItems, 'Kot_id': kotIdReciveFromKotUpdate};
        final response = await _httpService.updateData(UPDATE_KOT_ORDER, kotOrderUpdate);

        FoodResponse parsedResponse = FoodResponse.fromJson(response.data);
        if (parsedResponse.error) {
          btnControllerUpdateKot.error();
          AppSnackBar.errorSnackBar('Error', parsedResponse.errorCode);
        } else {
          print('object');
          _billingItems.clear();
          clearBillInHive();
          btnControllerUpdateKot.success();
          AppSnackBar.successSnackBar('Success', parsedResponse.errorCode);
          Get.offNamed(RouteHelper.getOrderViewScreen());
          update();
        }
      }
      //if bill is empty
      else {
        btnControllerUpdateKot.error();
        AppSnackBar.errorSnackBar('No item added', 'No bills added');
      }
    } on DioError catch (e) {
      btnControllerUpdateKot.error();
      AppSnackBar.errorSnackBar('Error', MyDioError.dioError(e));
    } catch (e) {
      btnControllerUpdateKot.error();
    } finally {
      update();
      print('finally');
      Future.delayed(const Duration(seconds: 1), () {
        btnControllerUpdateKot.reset();
      });
    }
  }

  /// updatekot to server//

  //to handle Get.argemrt fro diffrent pages like fro hold item or kot update .. etc
  getxArgumetsReciveHadler() {
    KitchenOrder emptyKotOrder = KitchenOrder(
        Kot_id: -1,
        error: true,
        errorCode: 'SomthingWrong',
        totalSize: 0,
        fdOrderStatus: 'Pending',
        fdOrderType: 'Takeaway',
        fdOrder: [],
        totelPrice: 0,
        orderColor: 111); //just [] will throw error
    var args = Get.arguments ?? {'holdItem': [], 'kotItem': emptyKotOrder};
    KitchenOrder? kotOrder = args['kotItem'] ?? emptyKotOrder;
    List<OrderBill>? kotItem = kotOrder?.fdOrder;
    List<dynamic>? holdItem = args['holdItem'] ?? [];
    if (kotItem!.isNotEmpty) {
      reciveUpdateKotBillingItem();
    } else if (holdItem!.isNotEmpty) {
      unHoldTakeAwayBillingItem();
    } else {
      _billingItems.clear;
    }
  }

  //kot printing dialog
  kotDialogBox(context) {
    showKotBillAlert(type: 'Take away', billingItems: _billingItems,context: context);
  }

  ///settle bill ////
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
      balanceChange.value = double.parse((settleCashRecivedCtrl.value.text == '' ? 0 : cashReceived - grandTotalNew)
          .toStringAsFixed(3)); //limit double to 3 pont after decimal
      settleGrandTotelCtrl.value.text = '$grandTotalNew';
    } catch (e) {
      rethrow;
    }
  }

  //settile billing cash alert
  settleBillingCash(context, ctrl) {
    try {
      settleNetTotalCtrl.value.text = _totelPrice.toString();
      settleDiscountCashCtrl.value.text = '0';
      settleDiscountPersentCtrl.value.text = '0';
      settleChargesCtrl.value.text = '0';
      settleGrandTotelCtrl.value.text = '0';
      settleCashRecivedCtrl.value.text = '';
      calculateNetTotal();
      billingCashScreenAlert(context: context, ctrl: ctrl, from: 'billing');
    } catch (e) {
      rethrow;
    }
  }

  //insert settiled bill
  insertSettledBill(context) async {
    try {
      //check bill or grand totel is empty
      if (_billingItems.isEmpty &&
          (settleGrandTotelCtrl.value.text == '0.0' ||
              settleGrandTotelCtrl.value.text == '0' ||
              settleGrandTotelCtrl.value.text == '')) {
        btnControllerSettle.error();
        AppSnackBar.errorSnackBar('Error', 'No bill added');
      } else {
        Map<String, dynamic> settledBill = {
          'fdShopId': 10,
          'fdOrder': billingItems,
          'fdOrderKot': '-1',
          'fdOrderStatus': 'pending',
          'fdOrderType': 'Takeaway',
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
          isClickedSettle.value = true;
          AppSnackBar.successSnackBar('Success', parsedResponse.errorCode);
        }
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
      });
    }
  }

  //again enable settle order for new order button click
  enableNewOrder() {
    isClickedSettle.value = false;
    clearBillInHive();
    _billingItems.clear();
    update();
  }

  ///settle bill ////

  //load food to bill page
  getTodayFoods() async {
    try {
      showLoading();
      update();
      MyResponse response = await _foodsRepo.getTodayFoods();

      hideLoading();
      update();

      if (response.statusCode == 1) {
        FoodResponse parsedResponse = response.data;
        if (parsedResponse.data == null) {
          _foods = [];
        } else {
          _foods = parsedResponse.data;
        }

        //toast

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

  //searching foods in bill page
  searchTodayFoods() async {
    try {
      showLoading();
      update();
      MyResponse response = await _foodsRepo.searchTodayFoods(searchQuery.value, 'yes');

      if (response.statusCode == 1) {
        FoodResponse parsedResponse = response.data;
        if (parsedResponse.data == null) {
          _foods = [];
        } else {
          _foods = parsedResponse.data;
        }

        //toast

      } else {
        print('${response.message}');
        // AppSnackBar.errorSnackBar(response.status, response.message);
        return;
      }
    } catch (e) {
      rethrow;
    } finally {
      hideLoading();
      update();
    }
  }

  reciveSearchValue(String query) {
    searchQuery.value = query;
  }

  // bill manipulations

  addFoodToBill(int fdId, String name, int qnt, double price, String ktNote) {
    try {
      //checking if the food alrady added
      var values = _billingItems.map((items) => items['fdId']).toList();

      //if added
      if (values.contains(fdId)) {
        //getting the index of food in list of bil
        var index = values.indexOf(fdId);
        //getting the old qnt fo=rom bill
        int currentQnt = _billingItems[index]['qnt'] ?? 0;
        int newQnt = currentQnt + qnt;
        updateFodToBill(index, newQnt, price, ktNote);
      } else {
        _billingItems.add({'fdId': fdId, 'name': name, 'qnt': qnt, 'price': price, 'ktNote': ktNote});
      }
      find_totelPrice();
    } catch (e) {
      rethrow;
    }

    update();
  }

  //update bill qnt and pricde
  updateFodToBill(int index, int qnt, double price, String ktNote) {
    try {
      _billingItems[index]['qnt'] = qnt;
      _billingItems[index]['price'] = price;
      _billingItems[index]['ktNote'] = ktNote;
      find_totelPrice();
    } catch (e) {
      rethrow;
    }

    update();
  }

  // toremove from bill
  removeFoodFromBill(int index) async {
    try {
      _billingItems.removeAt(index);
      find_totelPrice();
    } catch (e) {
      rethrow;
    }

    update();
  }

  // clear all  in take away scrreen btn
  clearAllBillItems() {
    try {
      billingItems.clear();
      clearBillInHive();
    } catch (e) {
      rethrow;
    }
    update();
  }

  // finding totel price

  find_totelPrice() {
    try {
      double totalScores = 0;
      _billingItems.forEach((item) {
        double result = item["price"] * item["qnt"];
        totalScores += result;
      });
      _totelPrice = totalScores;
      update();
    } catch (e) {
      rethrow;
    }
  }

  saveBillInHive() {
    try {
      _myLocalStorage.setData(HIVE_TAKE_AWAY_BILL, _billingItems);
    } catch (e) {
      rethrow;
    }
  }

  Future readBillInHive() {
    try {
      return _myLocalStorage.readData(HIVE_TAKE_AWAY_BILL);
    } catch (e) {
      rethrow;
    }
  }

  Future? clearBillInHive() {
    try {
      return _myLocalStorage.removeData(HIVE_TAKE_AWAY_BILL);
    } catch (e) {
      rethrow;
    }
  }

  initialLoadingBillFromHive() async {
    try {
      List<dynamic>? billFromHive = [];
      billFromHive = await readBillInHive();
      if (billFromHive != null) {
        // if data in hive
        if (billFromHive.isNotEmpty) {
          _billingItems.addAll(billFromHive);
          find_totelPrice();
          update();
        } else {
          _billingItems.clear();
        }
      } else {
        return;
      }
    } catch (e) {
      rethrow;
    }
  }

  ///hold bikll item//

  addHoldBillItem() async {
    try {
      //check bill is not empty
      if (_billingItems.isNotEmpty) {
        DateTime now = DateTime.now();
        String date = DateFormat('d MMM yyyy').format(now);
        String time = DateFormat('kk:mm:ss').format(now);
        int timeStamp = DateTime.now().millisecondsSinceEpoch;
        HiveHoldItem holdBillingItem = HiveHoldItem(
            holdItem: _billingItems, date: date, time: time, id: timeStamp, totel: _totelPrice, orderType: 'Takeaway');
        await _hiveHoldBillController.createHoldBill(holdBillingItem: holdBillingItem);
        _hiveHoldBillController.getHoldBill();
        //_billingItems.clear();
        clearBillInHive();
        btnControllerHold.success();
        update();
      } else {
        AppSnackBar.errorSnackBar('No item Added', 'No any bill items to hold');
        btnControllerHold.error();
      }

      //_hiveHoldBillController.clearBill(index: 1);
    } catch (e) {
      btnControllerHold.error();
      rethrow;
    } finally {
      Future.delayed(const Duration(seconds: 1), () {
        btnControllerHold.reset();
      });
    }
  }

  /// hold bill item//

  /// Unhold billing item////

  unHoldTakeAwayBillingItem() {
    try {
      var args = Get.arguments ?? {'holdItem': []};
      List<dynamic>? holdItem = args['holdItem'] ?? [];
      if (holdItem == null) {
        AppSnackBar.errorSnackBar('Something wrong', 'something went to wrong this order !! ');
        _billingItems.clear();
      } else {
        //from other pages than orderview screen
        if (holdItem.isEmpty) {
          //normal working will happened
          _billingItems.clear();
        } else {
          clearBillInHive();
          _billingItems.clear();
          _billingItems.addAll(holdItem);
          find_totelPrice();
          update();
          print(holdItem.length);
        }
      }
    } catch (e) {
      _billingItems.clear();
      rethrow;
    }
  }

  /// Unhold billing item///

  // to visible and hide edit options in delete popup
  setIsVisibleEditBillItem(bool val) {
    isVisibleEditBillItem = val;
    update();
  }

  //set visibilty of edit btn fales on first time
  setIsVisibleEditBillItemFales() {
    isVisibleEditBillItem = false;
    update();
  }

  //used in billing popup start
  updatePriceFirstTime(double price) {
    _price = price;
    update();
  }

  //update qnt first time in delete popup
  updateQntFirstTime(int qnt) {
    _count = qnt;
    update();
  }

  //used in billing popup start
  setQntToZero() {
    _count = 1;
    update();
  }

  incrementPrice() {
    _price++;
    update();
  }

  decrimentPrice() {
    if (_price > 0) {
      _price--;
    }
    update();
  }

  incrementQnt() {
    _count++;
    update();
  }

  decrimentQnt() {
    if (_count > 0) {
      _count--;
    }
    update();
  }

  showLoading() {
    isLoading = true;
  }

  hideLoading() {
    isLoading = false;
  }
}
