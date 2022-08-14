import 'package:get/get.dart';

import '../controller/table_manage_controller.dart';

class TableManageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TableManageController());
  }
}
