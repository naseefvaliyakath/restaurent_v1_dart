import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:restowrent_v_two/repository/foods_repo.dart';



class OnlineBookingBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<FoodsRepo>(FoodsRepo());


  }
}
