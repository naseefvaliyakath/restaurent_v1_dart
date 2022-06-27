import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Response;
import 'package:restowrent_v_two/model/my_response.dart';
import 'package:restowrent_v_two/widget/snack_bar.dart';

import '../../../commoen/dio_error.dart';
import '../../../model/category_respons/category.dart';
import '../../../model/category_respons/category_response.dart';
import '../../../model/foods_respons/food_response.dart';
import '../../../repository/foods_repo.dart';
import '../../../services/service.dart';

class UpdateFoodController extends GetxController {


  //to get categorys
  final FoodsRepo _foodsRepo = Get.find<FoodsRepo>();
  List<Category>? _category;
  List<Category>? get category => _category;

  //tochane tapped coloer of category
  int tappedIndex = 0;

  late TextEditingController fdNameTD;
  late TextEditingController fdPriceTD;
  late TextEditingController fdFullPriceTD;
  late TextEditingController fdThreeBiTwoPrsTD;
  late TextEditingController fdHalfPriceTD;
  late TextEditingController fdQtrPriceTD;


  File? file;
  bool priceToggle = false;
  bool imageToggle = false;
  // bool get priceToggle => _priceToggle;

  final HttpService _httpService = HttpService();
  bool isLoading = false;

  @override
  Future<void> onInit() async {
    super.onInit();
    fdNameTD = TextEditingController();
    fdPriceTD = TextEditingController();
    fdFullPriceTD = TextEditingController();
    fdThreeBiTwoPrsTD = TextEditingController();
    fdHalfPriceTD = TextEditingController();
    fdQtrPriceTD = TextEditingController();

    await  getCategory();
  }

  @override
  void onClose() {
    fdNameTD.dispose();
    fdFullPriceTD.dispose();
    fdThreeBiTwoPrsTD.dispose();
    fdHalfPriceTD.dispose();
    fdQtrPriceTD.dispose();
  }

  updateInitialValue(fdNameIn, fdPriceIn, fdThreeBiTwoPrsPriceIn, fdHalfPriceIn, fdQtrPriceIn,fdIsLoos) {
    try {
      fdNameTD.text = fdNameIn;

      fdThreeBiTwoPrsTD.text = fdThreeBiTwoPrsPriceIn.toString();
      fdHalfPriceTD.text = fdHalfPriceIn.toString();
      fdQtrPriceTD.text = fdQtrPriceIn.toString();
      fdIsLoos == 'yes' ? priceToggle = true : priceToggle = false;
      fdIsLoos == 'yes' ? fdFullPriceTD.text = fdPriceIn.toString() : fdPriceTD.text = fdPriceIn.toString();
      print(' toggle $priceToggle');
    } catch (e) {
      rethrow;
    }
    update();
  }

  setPricetoggle(bool val){
    priceToggle = val;
    update();
  }

  setImagetoggle(bool val){
    imageToggle = val;
    update();
  }


  // it called inside validator
  Future<MyResponse> updateFood(
      {File? file,
      required fdName,
      required fdCategory,
      required fdPrice,
      required fdThreeBiTwoPrsPrice,
      required fdHalfPrice,
      required fdQtrPrice,
      required fdIsLoos,
      required cookTime,
      required fdShopId,
      required fdImg,
      required fdIsToday,
      required id}) async {
    // TODO: implement getNewsHeadline

    try {
      final response = await _httpService.updateFood(
        file: file,
        fdName: fdName,
        fdCategory: fdCategory,
        fdPrice: fdPrice,
        fdThreeBiTwoPrsPrice: fdThreeBiTwoPrsPrice,
        fdHalfPrice: fdHalfPrice,
        fdQtrPrice: fdQtrPrice,
        fdIsLoos: fdIsLoos,
        cookTime: cookTime,
        fdShopId: fdShopId,
        fdImg: fdImg,
        fdIsToday: fdIsToday,
        id: id,
      );
      FoodResponse parsedResponse = FoodResponse.fromJson(response.data);
      print(parsedResponse);
      return MyResponse(statusCode: 1, status: 'Success', data: parsedResponse, message: parsedResponse.errorCode);
    } on DioError catch (e) {
      return MyResponse(statusCode: 0, status: 'Error', message: MyDioError.dioError(e));
    }
  }

  //validate before insert
  validateFoodDetails({
    required fdName,
    required fdCategory,
    required fdImg,
    required fdIsToday,
    required cookTime,
    required fdShopId,
    required id,
  }) async {
    try {
      if ((fdPriceTD.text != '' || fdFullPriceTD.text != '')) {
            var fdIsLoos = 'no';
            int fdPriceNew = 0;
            var fdNameNew = fdName == null ? fdName = '' : fdName = fdName;
            var fdCategoryNew = fdCategory == null ? fdCategory = '' : fdCategory = fdCategory;
            int idNew  = id == null ? id = 0 : id = id;
            var fdImgNew = fdImg == null ? fdImg = '' : fdImg = fdImg;
            var fdIsTodayNew = fdIsToday == null ? fdIsToday = '' : fdIsToday = fdIsToday;
            int cookTimeNew = cookTime == null ? cookTime = '' : cookTime = cookTime;
            int fdShopIdNew = fdShopId == null ? fdShopId = '' : fdShopId = fdShopId;
            int fdThreeBiTwoPrsPriceNew = 0;
            int fdHalfPriceNew = 0;
            int fdQtrPriceNew = 0;

            print(' kkk $fdIsLoos');
            //full price only
            if (!priceToggle) {
              fdIsLoos = 'no';
              fdPriceNew = fdPriceTD.text == '' ? 0 : int.parse(fdPriceTD.text);
            } else {
              fdIsLoos = 'yes';
              fdPriceNew = fdFullPriceTD.text == '' ? 0 : int.parse(fdFullPriceTD.text);
            }
            print(' hhh $fdIsLoos');
            fdNameNew = fdNameTD.text;
            fdThreeBiTwoPrsPriceNew = fdThreeBiTwoPrsTD.text == '' ? 0 : int.parse(fdThreeBiTwoPrsTD.text);
            fdHalfPriceNew = fdHalfPriceTD.text == '' ? 0 : int.parse(fdHalfPriceTD.text);
            fdQtrPriceNew = fdQtrPriceTD.text == '' ? 0 : int.parse(fdQtrPriceTD.text);

            showLoading();
            update();

            MyResponse response = await updateFood(
              file: file,
              fdName: fdNameNew,
              fdCategory: fdCategoryNew,
              fdPrice: fdPriceNew,
              fdThreeBiTwoPrsPrice: fdThreeBiTwoPrsPriceNew,
              fdHalfPrice: fdHalfPriceNew,
              fdQtrPrice: fdQtrPriceNew,
              fdIsLoos: fdIsLoos,
              cookTime: cookTimeNew,
              fdShopId: fdShopId,
              fdImg: fdImgNew,
              fdIsToday: fdIsTodayNew,
              id: idNew,
            );

            hideLoading();
            update();
            if (response.statusCode == 1) {
              FoodResponse parsedResponse = response.data;
              if (parsedResponse.error) {
                AppSnackBar.errorSnackBar(response.status, parsedResponse.errorCode);
              } else {
                AppSnackBar.successSnackBar(response.status, parsedResponse.errorCode);
              }
            } else {
              AppSnackBar.errorSnackBar(response.status, response.message);
            }
            hideLoading();
            update();
          } else {
            AppSnackBar.errorSnackBar('Fill the fields!', 'Enter the values in fields!!');
          }
    } catch (e) {
      rethrow;
    }
  }


  // get category
  getCategory() async {
    try {
      showLoading();
      update();
      MyResponse response = await _foodsRepo.getCategory();

      hideLoading();
      update();

      if (response.statusCode == 1) {

            CategoryResponse parsedResponse = response.data;
            if(parsedResponse.data == null){
              _category = [];

            }
            else{
              _category = parsedResponse.data;
              print('category ${_category}');

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



  //to change tapped category
  setCategoryTappedIndex(int val){
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
