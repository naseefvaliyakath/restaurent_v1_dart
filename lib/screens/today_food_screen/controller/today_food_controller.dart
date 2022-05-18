import 'package:get/get.dart';
import 'package:restowrent_v_two/repository/foods_repo.dart';

class TodayFoodController extends GetxController{

 FoodsRepo _foodsRepo = FoodsRepo();

  NewsHeadlineController(){
    _foodsRepo = Get.find<FoodsRepo>();
    getTodayFoods();
  }

  var isLoading = false.obs;



 getTodayFoods() async{

    showLoading();

    final  result = await _foodsRepo.getTodayFoods();

    hideLoading();

    if(result!= null){

    }else{
      print("No data recieved");
    }
  }

  showLoading(){
    isLoading.toggle();
  }

  hideLoading(){
    isLoading.toggle();
  }

}