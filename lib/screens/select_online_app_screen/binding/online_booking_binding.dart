import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:restowrent_v_two/repository/foods_repo.dart';

import '../controller/select_online_app_controller.dart';

class SelectOnlineAppBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<FoodsRepo>(FoodsRepo());
  //  Get.put<SelectOnlineAppController>(SelectOnlineAppController());
    Get.lazyPut(() => SelectOnlineAppController());
  }
}
