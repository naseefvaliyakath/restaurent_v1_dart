import 'package:dio/dio.dart';
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

  TodayFoodController() {
//  _foodsRepo.getTodayFoods();
  }

  bool isLoading = false;
  bool isloading2 =false; //for hide screen on update remove because isloading only change cards in today food
  List<Foods>? _foods;
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
    update();



  }

   removeFromToday(int id ,String isToday) async {

    try {
      showLoading();
      isloading2 = true;
      update();
      Map<String,dynamic>foodData={
        'id':id,
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

    update();

  }

  showLoading() {
    isLoading = true;
  }

  hideLoading() {
    isLoading = false;
  }
}
