import 'package:flutter/material.dart';
import 'package:restowrent_v_two/widget/app_alerts.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:restowrent_v_two/socket/socket_controller.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../../../app_constans/api_link.dart';
import '../../../../commoen/dio_error.dart';
import '../../../../model/foods_respons/food_response.dart';
import '../../../../model/kitchen_order_response/kitchen_order.dart';
import '../../../../model/kitchen_order_response/kitchen_order_array.dart';
import '../../../../services/service.dart';
import '../../../../widget/snack_bar.dart';

class KitchenModeMainController extends GetxController {
  final IO.Socket _socket = Get.find<SocketController>().socket;
  final HttpService _httpService = Get.find<HttpService>();
  bool isLoading = false;

  //tochane tapped coloer of ordr status tab
  int tappedIndex = 0;
  String tappedTabName = 'PENDING';

  //this will change as per clicking tab
  //when click pending it assign pending kots
  //if click rrady it assign ready kots
  final List<KitchenOrder> _kotBillingItems = [];

  List<KitchenOrder> get kotBillingItems => _kotBillingItems;

  List<KitchenOrder> _allKotBillingItems = [];

  List<KitchenOrder> get allKotBillingItems => _allKotBillingItems;

  final List<KitchenOrder> _kotBillingPendingItems = [];

  List<KitchenOrder> get kotBillingPendingItems => _kotBillingPendingItems;

  final List<KitchenOrder> _kotBillingProgressItems = [];

  List<KitchenOrder> get kotBillingProgressItems => _kotBillingProgressItems;

  final List<KitchenOrder> _kotBillingReadyItems = [];

  List<KitchenOrder> get kotBillingReadyItems => _kotBillingReadyItems;

  final List<KitchenOrder> _kotBillingRejectItems = [];

  List<KitchenOrder> get kotBillingRejectItems => _kotBillingRejectItems;

  RoundedLoadingButtonController btnControllerUpdateFullKotSts = RoundedLoadingButtonController();
  RoundedLoadingButtonController btnControllerProgressUpdateFullKotSts = RoundedLoadingButtonController();
  RoundedLoadingButtonController btnControllerReadyUpdateFullKotSts = RoundedLoadingButtonController();
  RoundedLoadingButtonController btnControllerPendingUpdateFullKotSts = RoundedLoadingButtonController();
  RoundedLoadingButtonController btnControllerRejectUpdateFullKotSts = RoundedLoadingButtonController();



  final player = AudioPlayer();
  final cache = AudioCache();

  @override
  void onInit() async {
    _socket.connect();
    setNewKotRingRemember();
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
      KitchenOrder order = KitchenOrder(
          fdOrderType: '',
          totelPrice: 0,
          fdOrderStatus: '',
          Kot_id: 0,
          errorCode: '',
          totalSize: 0,
          error: true,
          orderColor: 111);
      _socket.on('kitchen_orders_receive', (data) async {
        print('kotorder single rcv');
        order = KitchenOrder.fromJson(data);
        //no error
        if (!order.error) {
          //check if item is already in list
          bool isExist = true;
          for (var element in _allKotBillingItems) {
            if (element.Kot_id != order.Kot_id) {
              isExist = false;
            } else {
              isExist = true;
            }
          }
          //add if not exist
          if (isExist == false) {
            _allKotBillingItems.insert(0, order);
            updateKotItemsAsPerTab();
            ringOrderAlert();
          } else {
            _allKotBillingItems = _allKotBillingItems;
          }
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
          _allKotBillingItems.clear();
          _allKotBillingItems
              .addAll(kitcheOrders!.where((newItem) => _allKotBillingItems.every((oldItem) => newItem.Kot_id != oldItem.Kot_id)));
          //to load pending kot on page loading
          updateKotItemsAsPerTab();
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

  updateTappedTabName(String name) {
    print(name);
    tappedTabName = name;
    update();
  }

//to change tapped category
  setStatusTappedIndex(int val) {
    tappedIndex = val;
    update();
  }

  updateKotItemsAsPerTab() {
    print('dd $tappedTabName');
    if (tappedTabName == 'PENDING') {
      _kotBillingPendingItems.clear();
      for (var element in _allKotBillingItems) {
        if (element.fdOrderStatus == 'pending') {
          _kotBillingPendingItems.add(element);
        }
      }
      _kotBillingItems.clear();
      _kotBillingItems.addAll(_kotBillingPendingItems);
      update();
    } else if (tappedTabName == 'PROGRESS') {
      _kotBillingProgressItems.clear();
      for (var element in _allKotBillingItems) {
        if (element.fdOrderStatus == 'progress') {
          _kotBillingProgressItems.add(element);
        }
      }
      _kotBillingItems.clear();
      _kotBillingItems.addAll(_kotBillingProgressItems);
      update();
    } else if (tappedTabName == 'READY') {
      _kotBillingReadyItems.clear();
      for (var element in _allKotBillingItems) {
        if (element.fdOrderStatus == 'ready') {
          _kotBillingReadyItems.add(element);
        }
      }
      _kotBillingItems.clear();
      _kotBillingItems.addAll(_kotBillingReadyItems);
      update();
    } else if (tappedTabName == 'REJECT') {
      _kotBillingRejectItems.clear();
      for (var element in _allKotBillingItems) {
        if (element.fdOrderStatus == 'reject') {
          _kotBillingRejectItems.add(element);
        }
      }
      _kotBillingItems.clear();
      _kotBillingItems.addAll(_kotBillingRejectItems);
      print(_kotBillingRejectItems.length);
      update();
    } else {
      _kotBillingItems.clear();
      _kotBillingItems.addAll(_allKotBillingItems);
      update();
    }
  }

  //update full order status
  Future updateFullOrderStatus({required BuildContext context, required int kotId, required String fdOrderStatus}) async {
    try {
      if (fdOrderStatus == 'progress') {
        btnControllerUpdateFullKotSts = btnControllerProgressUpdateFullKotSts;
      } else if (fdOrderStatus == 'ready') {
        btnControllerUpdateFullKotSts = btnControllerReadyUpdateFullKotSts;
      } else if (fdOrderStatus == 'pending') {
        btnControllerUpdateFullKotSts = btnControllerPendingUpdateFullKotSts;
      } else if (fdOrderStatus == 'reject') {
        btnControllerUpdateFullKotSts = btnControllerRejectUpdateFullKotSts;
      } else {
        btnControllerUpdateFullKotSts = btnControllerPendingUpdateFullKotSts;
      }

      Map<String, dynamic> kotOrderStatusUpdate = {'fdShopId': 10, 'Kot_id': kotId, 'fdOrderStatus': fdOrderStatus};
      final response = await _httpService.updateData(UPDATE_FULL_ORDER_STATUS, kotOrderStatusUpdate);

      FoodResponse parsedResponse = FoodResponse.fromJson(response.data);
      if (parsedResponse.error) {
        btnControllerUpdateFullKotSts.error();
        AppSnackBar.errorSnackBar('Error', parsedResponse.errorCode);
      } else {
        refreshDatabaseKot();
        btnControllerUpdateFullKotSts.success();
        AppSnackBar.successSnackBar('Success', parsedResponse.errorCode);
        update();
      }
    } on DioError catch (e) {
      btnControllerUpdateFullKotSts.error();
      AppSnackBar.errorSnackBar('Error', MyDioError.dioError(e));
    } catch (e) {
      btnControllerUpdateFullKotSts.error();
    } finally {
      Future.delayed(const Duration(seconds: 1), () {
        btnControllerUpdateFullKotSts.reset();
      });
      Navigator.pop(context);
      update();
    }
  }

  //update single order status
  Future updateSingleOrderStatus({
    required BuildContext context,
    required int kotId,
    required int fdOrderIndex,
    required String fdOrderSingleStatus,
    required RoundedLoadingButtonController btnControllerUpdateSingleKotSts
  }) async {
    try {

      Map<String, dynamic> kotOrderSingleStatusUpdate = {
        'fdShopId': 10,
        'Kot_id': kotId,
        'fdOrderIndex': fdOrderIndex,
        'fdOrderSingleStatus': fdOrderSingleStatus,
      };
      final response = await _httpService.updateData(UPDATE_SINGLE_ORDER_STATUS, kotOrderSingleStatusUpdate);

      FoodResponse parsedResponse = FoodResponse.fromJson(response.data);
      if (parsedResponse.error) {
        btnControllerUpdateSingleKotSts.error();
        AppSnackBar.errorSnackBar('Error', parsedResponse.errorCode);
      } else {
        refreshDatabaseKot();
        btnControllerUpdateSingleKotSts.success();
        AppSnackBar.successSnackBar('Success', parsedResponse.errorCode);
        update();
      }
    } on DioError catch (e) {
      btnControllerUpdateSingleKotSts.error();
      AppSnackBar.errorSnackBar('Error', MyDioError.dioError(e));
    } catch (e) {
      btnControllerUpdateSingleKotSts.error();
    } finally {
      Future.delayed(const Duration(seconds: 1), () {
        btnControllerUpdateSingleKotSts.reset();
      });
      // Navigator.pop(context);
      update();
    }
  }

  showLoading() {
    isLoading = true;
  }

  hideLoading() {
    isLoading = false;
  }

  Future<void> ringOrderAlert() async {
    print('ring sound');
    Uri uri = await cache.load('sounds/ring_two.mp3');
    String url = uri.path;
    await player.setSourceUrl(url);
    player.resume();
  }

  Future<void> ringRememberAlert() async {
    print('ring sound');
    Uri uri = await cache.load('sounds/alert.mp3');
    String url = uri.path;
    await player.setSourceUrl(url);
    player.resume();
  }

  //for single order adding live
  setNewKotRingRemember() {
    try {
      _socket.on('for-ring-to-kitchen', (data) async {
        print('ring kot $data');
        //show popup
        KitchenOrder kitchenOrder = KitchenOrder(
            Kot_id: -1,
            error: true,
            errorCode: 'error',
            totalSize: 0,
            fdOrderStatus: 'pending',
            fdOrderType: 'TakeAway',
            totelPrice: 0,
            orderColor: 1);
        for (var element in _allKotBillingItems) {
          if (element.Kot_id == data) {
            kitchenOrder = element;
            break;
          }
        }
        kitchenRingPopupAlert(kitchenOrder);
        //make sound
        ringRememberAlert();
      });
    } catch (e) {
      rethrow;
    }
  }
}
