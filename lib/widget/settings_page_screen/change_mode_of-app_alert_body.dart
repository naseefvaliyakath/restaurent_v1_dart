import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/components/radio/gf_radio.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:getwidget/types/gf_radio_type.dart';
import 'package:restowrent_v_two/screens/settings_page_screen/controller/settings_controller.dart';
import 'package:restowrent_v_two/widget/app_min_button.dart';
import 'package:restowrent_v_two/widget/mid_text.dart';
import '../../app_constans/app_colors.dart';
import '../big_text.dart';
import '../text_field_widget.dart';

class ChangeModeOfAppAlertBody extends StatelessWidget {
  const ChangeModeOfAppAlertBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(builder: (ctrl) {
      return SizedBox(
        width: 1.sw * 0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GFCard(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: [
                      GFRadio(
                        type: GFRadioType.custom,
                        activeIcon: Icon(Icons.monetization_on),
                        inactiveIcon: Icon(Icons.monetization_on),
                        activeBgColor: AppColors.mainColor_2,
                        size: GFSize.MEDIUM,
                        value: 1,
                        groupValue: ctrl.groupValueForModes,
                        onChanged: (val) {
                          ctrl.updateModesOfApp(1);
                        },
                        radioColor: GFColors.SUCCESS,
                      ),
                      5.verticalSpace,
                      MidText(
                        text: 'CASHIER',
                      )
                    ],
                  ),
                  Column(
                    children: [
                      GFRadio(
                        type: GFRadioType.custom,
                        activeIcon: Icon(Icons.man),
                        inactiveIcon: Icon(Icons.man),
                        activeBgColor: AppColors.mainColor_2,
                        size: GFSize.MEDIUM,
                        value: 2,
                        groupValue: ctrl.groupValueForModes,
                        onChanged: (val) {
                          ctrl.updateModesOfApp(2);
                        },
                        radioColor: GFColors.SUCCESS,
                      ),
                      5.verticalSpace,
                      MidText(
                        text: 'WAITER',
                      )
                    ],
                  ),
                  Column(
                    children: [
                      GFRadio(
                        type: GFRadioType.custom,
                        activeIcon: Icon(Icons.fastfood),
                        inactiveIcon: Icon(Icons.fastfood),
                        activeBgColor: AppColors.mainColor_2,
                        size: GFSize.MEDIUM,
                        value: 3,
                        groupValue: ctrl.groupValueForModes,
                        onChanged: (val) {
                          ctrl.updateModesOfApp(3);
                        },
                        radioColor: GFColors.SUCCESS,
                      ),
                      5.verticalSpace,
                      MidText(
                        text: 'KITCHEN',
                      )
                    ],
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              //check app mode number is 1 and selected also 1 then no need of pass box
              height: ctrl.appModeNumber != ctrl.groupValueForModes ? 140.sp : 0,
              width: 1.sw * 0.8,
              child: SizedBox(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: 50.sp,
                      child: TextFieldWidget(
                        hintText: 'Enter Password ....',
                        textEditingController: ctrl.modeChangePassTD,
                        borderRadius: 15.r,
                        onChange: (_) {},
                      ),
                    ),
                    15.verticalSpace,
                    SizedBox(
                        height: 40.sp,
                        child: AppMIniButton(
                          text: 'Submit',
                          bgColor: AppColors.mainColor_2,
                          onTap: () {
                            ctrl.modeChangeSubmit();
                          },
                        )),
                    10.verticalSpace,
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
