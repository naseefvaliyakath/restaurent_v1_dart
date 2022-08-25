import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:restowrent_v_two/screens/order_view_screen/controller/order_view_controller.dart';

import '../../../hive_database/controller/hive_hold_bill_controller.dart';
import '../../../repository/foods_repo.dart';
import '../../../socket/socket_controller.dart';


class OrderViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<HiveHoldBillController>(HiveHoldBillController());
    Get.lazyPut(() => OrderViewController());
  }
}
