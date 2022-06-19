import 'package:get/get.dart';
import 'package:restowrent_v_two/screens/update_food_screen/controller/update_food_controller.dart';

class UpdateFoodBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateFoodController>(() => UpdateFoodController());

  }
}