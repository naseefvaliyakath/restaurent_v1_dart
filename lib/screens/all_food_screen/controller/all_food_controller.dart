import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:restowrent_v_two/model/my_response.dart';
import 'package:restowrent_v_two/repository/foods_repo.dart';

import '../../../app_constans/api_link.dart';
import '../../../commoen/dio_error.dart';
import '../../../model/foods_respons/food_response.dart';
import '../../../model/foods_respons/foods.dart';
import '../../../services/service.dart';
import '../../../widget/snack_bar.dart';

class AllFoodController extends GetxController {
  final FoodsRepo _foodsRepo = Get.find<FoodsRepo>();
  final HttpService _httpService = Get.find<HttpService>();
  //for search field text
  late TextEditingController searchTD;
  //to convert search query to obs for debounce
  var searchQuery = ''.obs;

  bool isLoading = false;
  bool isloading2 = false;
  List<Foods>? _foods= [];

  List<Foods>? get foods => _foods;



  @override
  void onInit() async {
    searchTD = TextEditingController();
   await getAllFoods();
   //only send search requst after typing 500 millisecond
   debounce(searchQuery, (callback) => searchAllFoods(),time: const Duration(milliseconds: 500));
    super.onInit();
  }

  getAllFoods() async {
    try {
      showLoading();
      update();

      MyResponse response = await _foodsRepo.getAllFoods();


      hideLoading();
      update();

      if (response.statusCode == 1) {
            FoodResponse parsedResponse = response.data;
            if (parsedResponse.data == null) {
              _foods = [];
            } else {
              _foods = parsedResponse.data;
            }

            print(_foods![0].fdName);
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

  //searching today foods
  searchAllFoods() async {
    try {
      showLoading();
      update();
      MyResponse response = await _foodsRepo.searchAllFoods(searchQuery.value, 'any');

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

  addToToday(int id ,String isToday) async {

    try {
      showLoading();
      isloading2 = true;
      update();

      Map<String,dynamic>foodData={
        'fdId':id,
        'fdIsToday': isToday
      };
      final response = await _httpService.updateData(TODAY_FOOD_UPDATE,foodData);
      isloading2 = false;
      hideLoading();
      update();
      FoodResponse parsedResponse = FoodResponse.fromJson(response.data);
      if(parsedResponse.error){
        AppSnackBar.errorSnackBar('Error', parsedResponse.errorCode);
      }
      else{
        getAllFoods();
        AppSnackBar.successSnackBar('Success', parsedResponse.errorCode);
      }
    } on DioError catch (e) {
      hideLoading();
      AppSnackBar.errorSnackBar('Error',MyDioError.dioError(e));
    }
    catch (e) {
      AppSnackBar.errorSnackBar('Error', 'Something wet to wrong');
    } finally {
      update();
    }

    update();

  }

  deleteFood(int id) async {

    try {
      showLoading();
      isloading2 = true;
      update();

      Map<String,dynamic>foodData={
        'fdId':id,
      };
      final response = await _httpService.delete(DELETE_FOOD,foodData);
      isloading2 = false;
      hideLoading();
      update();
      FoodResponse parsedResponse = FoodResponse.fromJson(response.data);
      if(parsedResponse.error){
        AppSnackBar.errorSnackBar('Error', parsedResponse.errorCode);
      }
      else{
        getAllFoods();
        AppSnackBar.successSnackBar('Success', parsedResponse.errorCode);
      }
    } on DioError catch (e) {
      hideLoading();
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
    isLoading =false;
  }
}
