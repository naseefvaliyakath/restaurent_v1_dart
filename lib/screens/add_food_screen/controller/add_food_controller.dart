import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Response;
import 'package:restowrent_v_two/model/category_respons/category.dart';
import 'package:restowrent_v_two/model/my_response.dart';
import 'package:restowrent_v_two/widget/snack_bar.dart';

import '../../../commoen/dio_error.dart';
import '../../../model/category_respons/category_response.dart';
import '../../../model/foods_respons/food_response.dart';
import '../../../repository/foods_repo.dart';
import '../../../services/service.dart';

class AddFoodController extends GetxController {

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
  bool addCategoryToggle = false;

  final HttpService _httpService = HttpService();
  bool isLoading = false;
  //for category update need other loader , so after catch isLoading become false so in ctr.list.length may couse error
  bool isLoadingCategory = false;

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

  // it called inside validator
  Future<MyResponse> insertFood({
    File? file,
    required fdName,
    required fdCategory,
    required fdPrice,
    required fdThreeBiTwoPrsPrice,
    required fdHalfPrice,
    required fdQtrPrice,
    required fdIsLoos,
  }) async {
    // TODO: implement getNewsHeadline

    try {
      final response = await _httpService.insertFood(
        file: file,
        fdName: fdName,
        fdCategory: fdCategory,
        fdPrice: fdPrice,
        fdThreeBiTwoPrsPrice: fdThreeBiTwoPrsPrice,
        fdHalfPrice: fdHalfPrice,
        fdQtrPrice: fdQtrPrice,
        fdIsLoos: fdIsLoos,
      );
      FoodResponse parsedResponse = FoodResponse.fromJson(response.data);
      print(parsedResponse);
      return MyResponse(statusCode: 1, status: 'Success', data: parsedResponse, message: parsedResponse.errorCode);
    } on DioError catch (e) {
      return MyResponse(statusCode: 0, status: 'Error', message: MyDioError.dioError(e));
    }
  }

  //validate before insert
  validateFoodDetails(fdCategory) async {

    try {
      if ((fdPriceTD.text != '' || fdFullPriceTD.text != '')) {
            showLoading();
            update();
            var fdIsLoos = 'no';
            var fdCategoryNew = 'COMMON';
            int fdPriceNew = 0;
            var fdNameNew = '';
            int fdThreeBiTwoPrsPriceNew = 0;
            int fdHalfPriceNew = 0;
            int fdQtrPriceNew = 0;

            //full price only
            if (!priceToggle) {
              fdIsLoos = 'no';
              fdPriceNew = fdPriceTD.text == '' ? 0 : int.parse(fdPriceTD.text);
            } else {
              fdIsLoos = 'yes';
              fdPriceNew = fdFullPriceTD.text == '' ? 0 : int.parse(fdFullPriceTD.text);
            }

            fdNameNew = fdNameTD.text;
            fdCategoryNew = fdCategory == '' ? 'COMMON' : fdCategory;
            fdThreeBiTwoPrsPriceNew = fdThreeBiTwoPrsTD.text == '' ? 0 : int.parse(fdThreeBiTwoPrsTD.text);
            fdHalfPriceNew = fdHalfPriceTD.text == '' ? 0 : int.parse(fdHalfPriceTD.text);
            fdQtrPriceNew = fdQtrPriceTD.text == '' ? 0 : int.parse(fdQtrPriceTD.text);


            print('object start');
            MyResponse response = await insertFood(
              file: file,
              fdName: fdNameNew,
              fdCategory:  fdCategoryNew,
              fdPrice: fdPriceNew,
              fdThreeBiTwoPrsPrice: fdThreeBiTwoPrsPriceNew,
              fdHalfPrice: fdHalfPriceNew,
              fdQtrPrice: fdQtrPriceNew,
              fdIsLoos: fdIsLoos,
            );
            print('object end');

            hideLoading();
            update();
            print('is load end $isLoading');
            if (response.statusCode == 1) {
              FoodResponse parsedResponse = response.data;
              if (parsedResponse.error) {
                AppSnackBar.errorSnackBar(response.status, parsedResponse.errorCode);
              } else {
                clearFields();
                AppSnackBar.successSnackBar(response.status, parsedResponse.errorCode);
              }
            } else {
              AppSnackBar.errorSnackBar(response.status, response.message);
            }
          } else {
            AppSnackBar.errorSnackBar('Fill the fields!', 'Enter the values in fields!!');
          }
    } catch (e) {
      hideLoading();
      update();
      rethrow;
    }

  }

//to clear value after toggle off
  void clearLoosPrice() {
    if (!priceToggle) {
      fdFullPriceTD.text = '';
      fdThreeBiTwoPrsTD.text = '';
      fdHalfPriceTD.text = '';
      fdQtrPriceTD.text = '';
    }
  }


  // get category
  getCategory() async {
    try {
      print('category');
      showLoadingCategory();
      update();
      print('category'+isLoadingCategory.toString());
      MyResponse response = await _foodsRepo.getCategory();

      hideLoadingCategory();
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
      hideLoading();
      update();
      rethrow;
    }
    update();



  }

  //to add category widget show and hide
  setAddcategoryToggle(bool val){
    addCategoryToggle = val;
    update();
  }

  //to change tapped category
  setCategoryTappedIndex(int val){
    tappedIndex = val;
    update();
  }

  clearFields(){
    fdNameTD.text = '';
    fdPriceTD.text = '';
    fdFullPriceTD.text = '';
    fdThreeBiTwoPrsTD.text = '';
    fdHalfPriceTD.text = '';
    fdQtrPriceTD.text = '';
    priceToggle = false;
    file = null;

    update();
  }

  setPricetoggle(bool val){
    priceToggle = val;
    update();
  }

  showLoading() {
    isLoading = true;
  }

  hideLoading() {
    isLoading = false;
  }

  showLoadingCategory() {
    isLoadingCategory = true;
  }

  hideLoadingCategory() {
    isLoadingCategory = false;
  }

}
