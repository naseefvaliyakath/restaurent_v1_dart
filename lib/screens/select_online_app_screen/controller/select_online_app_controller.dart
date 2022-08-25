import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:restowrent_v_two/model/online_app_respons/online_app_response.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../../app_constans/api_link.dart';
import '../../../commoen/dio_error.dart';
import '../../../model/foods_respons/food_response.dart';
import '../../../model/my_response.dart';
import '../../../model/online_app_respons/online_app.dart';
import '../../../repository/foods_repo.dart';
import '../../../services/service.dart';
import '../../../widget/snack_bar.dart';

class SelectOnlineAppController extends GetxController {
  final FoodsRepo _foodsRepo = Get.find<FoodsRepo>();
  final HttpService _httpService = HttpService();

  final RoundedLoadingButtonController btnControllerSubmitOnlineApp = RoundedLoadingButtonController();

  List<OnlineApp>? _onlineApp = [];

  List<OnlineApp>? get onlineApp => _onlineApp;

  bool isLoading = false;

  //add online app
  late TextEditingController onlineAppNameTD;
  File? file;

  @override
  void onInit() async {
    onlineAppNameTD = TextEditingController();
    getOnlineApp();
    super.onInit();
  }

  @override
  void onClose() {}

  // get online app
  getOnlineApp() async {
    try {
      print('ff');
      showLoading();
      update();
      MyResponse response = await _foodsRepo.getOnlineApp();

      if (response.statusCode == 1) {
        OnlineAppResponse parsedResponse = response.data;
        if (parsedResponse.data == null) {
          _onlineApp = [];
        } else {
          _onlineApp = parsedResponse.data;
          print('onlineApp ${_onlineApp!.length}');
        }
      } else {
        print(response.message);
        return;
      }
    } catch (e) {
      rethrow;
    } finally {
      hideLoading();
      update();
    }
  }

  //validate before insert
  validateAppDetails(BuildContext context) async {
    try {
      var onlineAppNameNew = '';
      if ((onlineAppNameTD.text != '')) {
        onlineAppNameNew = onlineAppNameTD.text;

        MyResponse response = await insertOnlineApp(file: file, fdShopId: 10, appName: onlineAppNameNew);
        btnControllerSubmitOnlineApp.stop();
        update();
        if (response.statusCode == 1) {
          //food response enough so no data , just error or success
          FoodResponse parsedResponse = response.data;
          if (parsedResponse.error) {
            btnControllerSubmitOnlineApp.error();

          } else {
            btnControllerSubmitOnlineApp.success();

          }
        } else {
          btnControllerSubmitOnlineApp.error();
          AppSnackBar.errorSnackBar(response.status, response.message);
        }
      } else {
        btnControllerSubmitOnlineApp.error();
        AppSnackBar.errorSnackBar('Fill the fields!', 'Enter the values in fields!!');
      }
    } catch (e) {
      btnControllerSubmitOnlineApp.error();
      hideLoading();
      update();
      rethrow;
    } finally {
      Future.delayed(const Duration(seconds: 1), () {
        btnControllerSubmitOnlineApp.reset();
      });
      Navigator.pop(context);
      onlineAppNameTD.text = '';
      update();
    }
  }

  // it called inside validator
  Future<MyResponse> insertOnlineApp({
    File? file,
    required fdShopId,
    required appName,
  }) async {
    // TODO: implement getNewsHeadline

    try {
      final response = await _httpService.insertOnlineApp(
        file: file,
        fdShopId: fdShopId,
        appName: appName,
      );
      FoodResponse parsedResponse = FoodResponse.fromJson(response.data);
      print(parsedResponse);
      return MyResponse(statusCode: 1, status: 'Success', data: parsedResponse, message: parsedResponse.errorCode);
    } on DioError catch (e) {
      return MyResponse(statusCode: 0, status: 'Error', message: MyDioError.dioError(e));
    } catch (e) {
      return MyResponse(statusCode: 0, status: 'Error', message: 'Error');
    } finally {}
  }



  deleteOnlineApp(int id) async {

    try {

      Map<String,dynamic>onlineAppData={
        'onlineApp_id':id,
        'fdShopId':10,
      };
      final response = await _httpService.delete(DELETE_ONLINE_APP,onlineAppData);
      FoodResponse parsedResponse = FoodResponse.fromJson(response.data);
      if(parsedResponse.error){
        AppSnackBar.errorSnackBar('Error', parsedResponse.errorCode);
      }
      else{
        getOnlineApp();
        AppSnackBar.successSnackBar('Success', parsedResponse.errorCode);
      }
    } on DioError catch (e) {
      AppSnackBar.errorSnackBar('Error',MyDioError.dioError(e));
    }
    catch (e) {
      AppSnackBar.errorSnackBar('Error', 'Something wet to wrong');
    } finally {
      update();
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
