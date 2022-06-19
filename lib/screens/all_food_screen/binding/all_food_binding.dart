import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:restowrent_v_two/repository/foods_repo.dart';
import 'package:restowrent_v_two/screens/all_food_screen/controller/all_food_controller.dart';


class AllFoodBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<FoodsRepo>(FoodsRepo());
    Get.put<AllFoodController>(AllFoodController());

  }
}
