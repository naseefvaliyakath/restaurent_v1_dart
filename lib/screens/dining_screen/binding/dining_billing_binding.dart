import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:restowrent_v_two/repository/foods_repo.dart';
import 'package:restowrent_v_two/screens/take_away_billing%20screen/controller/take_away_controller.dart';
import 'package:restowrent_v_two/screens/today_food_screen/controller/today_food_controller.dart';

import '../../../hive_database/controller/hive_hold_bill_controller.dart';
import '../controller/dining_billing_controller.dart';


class DiningBillingBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<FoodsRepo>(FoodsRepo());
    Get.put<HiveHoldBillController>(HiveHoldBillController());
    Get.put<DiningBillingController>(DiningBillingController());

  }
}
