import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restowrent_v_two/app_constans/app_colors.dart';
import 'package:restowrent_v_two/widget/text_field_widget.dart';

import '../../screens/home_delivery_screen/controller/home_delivery_controller.dart';
import '../app_min_button.dart';
import '../horezondal_divider.dart';

class AddressTextInputScreen extends StatelessWidget {
  final HomeDeliveryController ctrl;
  const AddressTextInputScreen({Key? key, required this.ctrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.75.sw,
      color: Colors.white,
      padding: EdgeInsets.all(10.sp),
      child: SizedBox(
        width: 0.8.sw,
        child: (Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //phone number
            Flexible(
                child: TextFieldWidget(
                    textEditingController: ctrl.deliveryAddrNumberCtrl,
                    hintText: 'Phone Number',
                    isDens: true,
                    hintSize: 16,
                    borderRadius: 10.r, onChange: (number) {
                      ctrl.getDeliveryAddressItemForRefillItem(number);
                },)),
            10.verticalSpace,

            //cus name
            Flexible(
                child: TextFieldWidget(
                    textEditingController: ctrl.deliveryAddrNameCtrl,
                    hintText: 'Customer Name',
                    isDens: true,
                    hintSize: 16,
                    borderRadius: 10.r, onChange: (_) {},)),
            10.verticalSpace,
            //cus address
            Flexible(
                child: TextFieldWidget(
                    textEditingController: ctrl.deliveryAddrAddressCtrl,
                    hintText: 'Enter Address',
                    isDens: true,
                    maxLIne: 3,
                    hintSize: 16,
                    borderRadius: 10.r, onChange: (_) {},)),

            10.verticalSpace,
          ],
        )),
      ),
    );
  }
}
