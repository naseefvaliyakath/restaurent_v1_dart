import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:restowrent_v_two/hive_database/controller/hive_hold_bill_controller.dart';
import 'package:restowrent_v_two/repository/foods_repo.dart';
import 'package:restowrent_v_two/screens/take_away_billing%20screen/controller/take_away_controller.dart';



class TakeAwayBinding implements Bindings {
  @override
  Future<void> dependencies() async {
    Get.put<FoodsRepo>(FoodsRepo());
    Get.lazyPut(() => HiveHoldBillController());
    Get.lazyPut(() => TakeAwayController());

  }
}
