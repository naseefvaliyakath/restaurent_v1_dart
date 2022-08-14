import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:restowrent_v_two/app_constans/api_link.dart';
import 'package:restowrent_v_two/model/my_response.dart';
import 'package:restowrent_v_two/repository/foods_repo.dart';

import '../../../commoen/dio_error.dart';
import '../../../model/foods_respons/food_response.dart';
import '../../../model/foods_respons/foods.dart';
import '../../../services/service.dart';
import '../../../widget/snack_bar.dart';

class TodayFoodController extends GetxController {

  final FoodsRepo _foodsRepo = Get.find<FoodsRepo>();
  final HttpService _httpService = Get.find<HttpService>();
  //for search field text
  late TextEditingController searchTD;
  //to convert search query to obs for debounce
  var searchQuery = ''.obs;


  @override
  void onInit() async {
    searchTD = TextEditingController();
    //only send search requst after typing 500 millisecond
    debounce(searchQuery, (callback) => searchTodayFoods(),time: const Duration(milliseconds: 500));
    super.onInit();
  }


  bool isLoading = false;
  bool isloading2 =false; //for hide screen on update remove because isloading only change cards in today food
  List<Foods>? _foods = [];
  List<Foods>? get foods => _foods;

  getTodayFoods() async {
    try {
      showLoading();
      update();
      MyResponse response = await _foodsRepo.getTodayFoods();

      hideLoading();
      update();

      if (response.statusCode == 1) {

            FoodResponse parsedResponse = response.data;
            if(parsedResponse.data == null){
              _foods = [];

            }
            else{
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
    finally{
      hideLoading();
      update();
    }
    update();



  }

  //searching today foods
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

   removeFromToday(int fdId ,String isToday) async {

    try {
      showLoading();
      isloading2 = true;
      update();
      Map<String,dynamic>foodData={
        'fdId':fdId,
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
        getTodayFoods();
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
