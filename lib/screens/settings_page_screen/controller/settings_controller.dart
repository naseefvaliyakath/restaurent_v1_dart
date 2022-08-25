import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:restowrent_v_two/routes/route_helper.dart';
import 'package:restowrent_v_two/widget/snack_bar.dart';
import '../../../app_constans/hive_costants.dart';
import '../../../commoen/local_storage_controller.dart';

class SettingsController extends GetxController {
  final MyLocalStorage _myLocalStorage = Get.find<MyLocalStorage>();

  late TextEditingController modeChangePassTD;

  //for selecting modes of app from radio buttons
  int _groupValueForModes = 0;
  int get groupValueForModes => _groupValueForModes;


  //application mode number

  int _appModeNumber = 1;

  int get appModeNumber => _appModeNumber;

  @override
  void onInit() async {
    await getAppModeNumber();
    modeChangePassTD = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    modeChangePassTD.dispose();
  }

  updateModesOfApp(int groupValue) {
    _groupValueForModes = groupValue;
    update();
  }



  getAppModeNumber() async {
    int? appModeNumberGet = await _myLocalStorage.readData(HIVE_APP_MODE_NUMBER) ?? 1;
    _appModeNumber = appModeNumberGet!;
    _groupValueForModes = _appModeNumber;
    update();
  }

  modeChangeSubmit(){
    // if(modeChangePassTD.text == 'admin'){
    //   Get.offAllNamed(RouteHelper.getKitchenModeMainScreen());
    // }
    // else{
    //   AppSnackBar.errorSnackBar('Wrong password', 'Pleas enter correct password');
    // }
    Get.offAllNamed(RouteHelper.getKitchenModeMainScreen());
  }

}
