import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restowrent_v_two/app_constans/app_colors.dart';
import 'package:restowrent_v_two/screens/home_delivery_screen/controller/home_delivery_controller.dart';
import 'package:restowrent_v_two/screens/take_away_billing%20screen/controller/take_away_controller.dart';
import 'package:restowrent_v_two/widget/big_text.dart';
import 'package:restowrent_v_two/widget/order_settile_screen/payment_type__drop_down.dart';
import 'package:restowrent_v_two/widget/text_field_widget.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../app_min_button.dart';
import '../horezondal_divider.dart';
import '../progress_button.dart';

class OrderUpdateSettileScreen extends StatelessWidget {
  final ctrl;

  const OrderUpdateSettileScreen({Key? key, required this.ctrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        width: 0.8.sw,
        padding: EdgeInsets.all(10.sp),
        child: SizedBox(
          width: 0.8.sw,
          child: (Column(
            children: [
              HorezondalDivider(),
              10.verticalSpace,
              //net totel
              Row(
                children: [
                  FittedBox(
                    child: BigText(
                      text: 'Net Totel : ',
                      size: 20.sp,
                      color: AppColors.titleColor,
                    ),
                  ),
                  Flexible(
                      child: TextFieldWidget(
                    textEditingController: ctrl.settleNetTotalCtrl.value,
                    hintText: 'Net Amount',
                    isDens: true,
                    hintSize: 16,
                    borderRadius: 10.r,
                    onChange: (value) {
                      ctrl.calculateNetTotal();
                    },
                  ))
                ],
              ),
              10.verticalSpace,

              //discound
              Row(
                children: [
                  FittedBox(
                    child: BigText(
                      text: 'Discount : ',
                      size: 20.sp,
                      color: AppColors.titleColor,
                    ),
                  ),
                  Flexible(
                      child: TextFieldWidget(
                    textEditingController: ctrl.settleDiscountPersentCtrl.value,
                    hintText: 'in %',
                    isDens: true,
                    hintSize: 16,
                    borderRadius: 10.r,
                    onChange: (value) {
                      ctrl.calculateNetTotal();
                    },
                  )),
                  Flexible(
                      child: TextFieldWidget(
                    textEditingController: ctrl.settleDiscountCashCtrl.value,
                    hintText: 'in Cash',
                    isDens: true,
                    hintSize: 16,
                    borderRadius: 10.r,
                    onChange: (_) {
                      ctrl.calculateNetTotal();
                    },
                  ))
                ],
              ),
              10.verticalSpace,
              Row(
                children: [
                  FittedBox(
                    child: BigText(
                      text: 'Charges : ',
                      size: 20.sp,
                      color: AppColors.titleColor,
                    ),
                  ),
                  Flexible(
                      child: TextFieldWidget(
                    textEditingController: ctrl.settleChargesCtrl.value,
                    hintText: 'Amount',
                    hintSize: 16,
                    isDens: true,
                    borderRadius: 10.r,
                    onChange: (_) {
                      ctrl.calculateNetTotal();
                    },
                  ))
                ],
              ),
              10.verticalSpace,
              //grand totel
              Row(
                children: [
                  FittedBox(
                    child: BigText(
                      text: 'Grand Totel : ',
                      size: 20.sp,
                      color: AppColors.titleColor,
                    ),
                  ),
                  Flexible(
                      child: TextFieldWidget(
                    textEditingController: ctrl.settleGrandTotelCtrl.value,
                    hintText: 'Grand Totel',
                    isDens: true,
                    hintSize: 16,
                    borderRadius: 10.r,
                    onChange: (_) {},
                  ))
                ],
              ),
              10.verticalSpace,
              //payment type
              Row(
                children: [
                  FittedBox(
                    child: BigText(
                      text: 'Payment : ',
                      size: 20.sp,
                      color: AppColors.titleColor,
                    ),
                  ),
                  Flexible(child: PaymentTypeDropDown())
                ],
              ),
              10.verticalSpace,
              //cash receved
              Row(
                children: [
                  FittedBox(
                    child: BigText(
                      text: 'Cash Received : ',
                      size: 20.sp,
                      color: AppColors.titleColor,
                    ),
                  ),
                  Flexible(
                      child: TextFieldWidget(
                    textEditingController: ctrl.settleCashRecivedCtrl.value,
                    hintText: 'Amount Received',
                    isDens: true,
                    hintSize: 16,
                    borderRadius: 10.r,
                    onChange: (value) {
                      ctrl.calculateNetTotal();
                    },
                  ))
                ],
              ),
              10.verticalSpace,
              //change cash text
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FittedBox(
                    child: BigText(
                      text: 'Change : ',
                      size: 20.sp,
                      color: AppColors.titleColor,
                    ),
                  ),
                  10.horizontalSpace,
                  FittedBox(
                    child: BigText(
                      text: ctrl.balanceChange.value.toString(),
                      size: 20.sp,
                      color: AppColors.mainColor,
                    ),
                  ),
                ],
              ),
              10.verticalSpace,
              //buttons
              SizedBox(
                height: 40.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: ProgressButton(
                                btnCtrlName: 'settle',
                                ctrl: ctrl,
                                color: Colors.blue,
                                text: 'Update',
                                onTap: () async {
                                  await ctrl.updateSettledBill(context);
                                },
                              )),
                    3.horizontalSpace,
                    Flexible(
                      child: AppMIniButton(
                        bgColor: Color(0xff4caf50),
                        text: 'Print',
                        onTap: () {},
                      ),
                    ),
                    3.horizontalSpace,
                    Flexible(
                      child:AppMIniButton(
                              bgColor: AppColors.mainColor,
                              text: 'Close',
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                    ),
                    3.horizontalSpace,
                  ],
                ),
              ),
            ],
          )),
        ),
      );
    });
  }
}
