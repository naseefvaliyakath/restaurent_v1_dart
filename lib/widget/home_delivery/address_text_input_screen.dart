import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restowrent_v_two/app_constans/app_colors.dart';
import 'package:restowrent_v_two/widget/big_text.dart';
import 'package:restowrent_v_two/widget/order_settile_screen/payment_type__drop_down.dart';
import 'package:restowrent_v_two/widget/take_away_screen/category_drop_down.dart';
import 'package:restowrent_v_two/widget/text_field_widget.dart';

import '../app_min_button.dart';
import '../horezondal_divider.dart';

class AddressTextInputScreen extends StatelessWidget {
  const AddressTextInputScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.95.sw,
      color: Colors.white,
      padding: EdgeInsets.all(10.sp),
      child: SizedBox(
        width: 0.8.sw,
        child: (Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            HorezondalDivider(),
            10.verticalSpace,
            //phone number
            Flexible(
                child: TextFieldWidget(
                    textEditingController: TextEditingController(),
                    hintText: 'Phone Number',
                    isDens: true,
                    hintSize: 16,
                    borderRadius: 10.r)),
            10.verticalSpace,

            //cus name
            Flexible(
                child: TextFieldWidget(
                    textEditingController: TextEditingController(),
                    hintText: 'Customer Name',
                    isDens: true,
                    hintSize: 16,
                    borderRadius: 10.r)),
            10.verticalSpace,
            //cus address
            Flexible(
                child: TextFieldWidget(
                    textEditingController: TextEditingController(),
                    hintText: 'Enter Address',
                    isDens: true,
                    maxLIne: 3,
                    hintSize: 16,
                    borderRadius: 10.r)),

            10.verticalSpace,
            //buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: AppMIniButton(
                    bgColor: AppColors.mainColor,
                    text: 'Submit Address',
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
