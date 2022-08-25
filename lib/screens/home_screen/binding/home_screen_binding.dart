import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:restowrent_v_two/commoen/local_storage_controller.dart';
import 'package:restowrent_v_two/repository/foods_repo.dart';
import 'package:restowrent_v_two/screens/today_food_screen/controller/today_food_controller.dart';
import '../../../socket/socket_controller.dart';
import '../../settings_page_screen/controller/settings_controller.dart';


class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<MyLocalStorage>(MyLocalStorage(),permanent: true);
    Get.put<FoodsRepo>(FoodsRepo(),permanent: true);
    Get.put<SettingsController>(SettingsController());
    Get.put<SocketController>(SocketController());
    Get.put<TodayFoodController>(TodayFoodController());
  }
}
