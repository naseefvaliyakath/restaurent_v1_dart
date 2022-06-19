import 'package:dio/dio.dart';
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
  FoodsRepo _foodsRepo = Get.find<FoodsRepo>();
  final HttpService _httpService = Get.find<HttpService>();
  bool isLoading = false;
  bool isloading2 = false;
  List<Foods>? _foods;

  List<Foods>? get foods => _foods;

  AllFoodController() {
    // print('object');
    _foodsRepo = Get.find<FoodsRepo>();

    // print('object $isLoading');
  }

  @override
  void onInit() async {

   await getAllFoods();
    print('object $isLoading');
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

  addToToday(int id ,String isToday) async {

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
        getAllFoods();
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
    isLoading =false;
  }
}
