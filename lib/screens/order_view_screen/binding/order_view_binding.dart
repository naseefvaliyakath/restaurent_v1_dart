import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:restowrent_v_two/screens/order_view_screen/controller/order_view_controller.dart';


class OrderViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<OrderViewController>(OrderViewController());
  }
}
