import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:restowrent_v_two/app_constans/api_link.dart';
import 'package:restowrent_v_two/app_constans/hive_costants.dart';
import 'package:restowrent_v_two/commoen/local_storage_controller.dart';
import 'package:restowrent_v_two/model/my_response.dart';
import 'package:restowrent_v_two/repository/foods_repo.dart';

import '../../../commoen/dio_error.dart';
import '../../../model/foods_respons/food_response.dart';
import '../../../model/foods_respons/foods.dart';
import '../../../services/service.dart';
import '../../../socket/socket_controller.dart';
import '../../../widget/kot_bill_show_alert.dart';
import '../../../widget/snack_bar.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class DiningBillingController extends GetxController {
  final FoodsRepo _foodsRepo = Get.find<FoodsRepo>();
    late IO.Socket socket;
  final SocketController _socketCtrl = Get.find<SocketController>();
  final MyLocalStorage _myLocalStorage = Get.find<MyLocalStorage>();
  //for search field text
  late TextEditingController searchTD;
  //to convert search query to obs for debounce
  var searchQuery = ''.obs;
  //for progress button if true it show cross else show tick
  var socketError = false.obs;

  @override
  void onInit() async {
        socket = _socketCtrl.socket;
    await getTodayFoods();
    await initialLoadingBillFromHive();
        searchTD = TextEditingController();
    //only send search requst after typing 500 millisecond
    debounce(searchQuery, (callback) => searchTodayFoods(),time: const Duration(milliseconds: 500));
    super.onInit();
  }

  bool isLoading = false;
  List<Foods>? _foods;

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

  ////socket io////

  Future<void> sendOrder() async {
    var data = {"fdShopId": 10, "fdOrder": _billingItems, "fdOrderStatus": "Pending", "fdOrderType": "Takeaway"};
    if (_billingItems.isEmpty) {
      socketError.value = true;
      AppSnackBar.errorSnackBar('No item added', 'No bills added');
    } else {
      try {
        socketError.value = false;
        update();
        //delay for progress btn
        await Future.delayed(const Duration(milliseconds: 500));
        //check interet coectio then only coect else it try to coect again ad again
        socket.connect();
        //check socket is connected or not
        if(!socket.connected){
          socketError.value = true;
          AppSnackBar.errorSnackBar('Error', 'Something went to wrong !');
          print('socket not connected');
        }
        else {
          socket.emitWithAck('kitchen_orders', data, ack: (dataAck) {
            if (dataAck == 'success') {
              print('suceess');
              _billingItems.clear();
              clearBillInHive();
              socketError.value = false;
              update();
            } else {
              if (dataAck == 'error') {
                socketError.value = true;
                update();
                AppSnackBar.errorSnackBar('Error', 'Something went to wrong !');
              } else {
                socketError.value = true;
                update();
                AppSnackBar.errorSnackBar('Error', 'Something went to wrong !');
              }
            }
          });
        }
      } catch (e) {
        socketError.value = true;
        update();
        rethrow;
      }
    }
  }



  ///socket io ////

  //kot printing dialog
  kotDialogBox() {
    showKotBillAlert(type: 'DINING', billingItems: _billingItems);
  }

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
        // AppSnackBar.errorSnackBar(response.status, response.message);
        return;
      }
    } catch (e) {
      rethrow;
    }
    update();
  }

  reciveSearchValue(String query){
    searchQuery.value = query;
  }

  // bill manipulations

  addFoodToBill(int fdId, String name, int qnt, double price, String ktNote) {

    try{
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

    }
    catch(e){
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
    } catch (e) {
     rethrow;
    }
    update();
  }

  // finding totel price
  
  find_totelPrice(){
    try {
      double totalScores = 0;
      _billingItems.forEach((item){
        double result = item["price"] * item["qnt"];
            totalScores +=result;
          });
      _totelPrice = totalScores;
      update();
    } catch (e) {
      rethrow;
    }
  }


  saveBillInHive(){
    try {
      _myLocalStorage.setData(HIVE_DINING_BILL, _billingItems);
    } catch (e) {
      rethrow;
    }
  }

  Future readBillInHive(){
   try {
     return _myLocalStorage.readData(HIVE_DINING_BILL);
   } catch (e) {
     rethrow;
   }
  }

  Future? clearBillInHive(){
    try {
      return _myLocalStorage.removeData(HIVE_DINING_BILL);
    } catch (e) {
      rethrow;
    }
  }

  initialLoadingBillFromHive() async {
    try {
      List<dynamic>? billFromHive = [];
      billFromHive = await readBillInHive();
      if(billFromHive != null){
        // if data in hive
        if(billFromHive.isNotEmpty){
          _billingItems.addAll(billFromHive);
          update();
        }
        else{
          _billingItems.clear();
        }
      }
      else{

        return;
      }
    } catch (e) {
      rethrow;
    }
  }


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
