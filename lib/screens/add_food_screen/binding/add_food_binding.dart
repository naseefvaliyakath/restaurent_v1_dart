import 'package:get/get.dart';
import 'package:restowrent_v_two/screens/add_food_screen/controller/add_food_controller.dart';

class AddFoodBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddFoodController>(() => AddFoodController());

  }
}