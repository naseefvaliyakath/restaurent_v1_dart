import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:restowrent_v_two/commoen/local_storage_controller.dart';
import 'package:restowrent_v_two/repository/foods_repo.dart';
import 'package:restowrent_v_two/screens/today_food_screen/controller/today_food_controller.dart';

import '../../../socket/socket_controller.dart';


class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SocketController>(SocketController());
    Get.put<MyLocalStorage>(MyLocalStorage(),permanent: true);
    Get.put<FoodsRepo>(FoodsRepo());
    Get.put<TodayFoodController>(TodayFoodController());
  }
}
