import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:restowrent_v_two/app_constans/app_colors.dart';
import 'package:restowrent_v_two/widget/big_text.dart';
import 'package:restowrent_v_two/widget/home_delivery/delivery_boy_select_screen.dart';
import 'package:restowrent_v_two/widget/round_border_button.dart';
import 'package:restowrent_v_two/widget/text_field_widget.dart';

import 'app_min_button.dart';
import 'dialog_button.dart';
import 'home_delivery/address_text_input_screen.dart';
import 'order_settile_screen/order_settil_screen.dart';
import 'order_view_screen/order_alert_bill_id_circle.dart';
import 'take_away_screen/billing_alert_food.dart';

foodBillingAlert(context) {
  AwesomeDialog(
    customHeader: BillingAlertFood(
      img: 'assets/image/food/GrilledFish.jpg',
    ),
    context: context,
    animType: AnimType.SCALE,
    dialogType: DialogType.INFO,
    body: Center(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Chicke biriyani with more extra rice',
              style: TextStyle(
                  fontSize: 20.sp,
                  color: AppColors.titleColor,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            10.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: Card(
                    child: Row(
                      children: [
                        BigText(
                          text: 'Price',
                          size: 15.sp,
                        ),
                        10.horizontalSpace,
                        Icon(
                          Icons.add_circle,
                          color: Colors.black54,
                          size: 24.w,
                        ),
                        5.horizontalSpace,
                        BigText(
                          text: '250',
                          size: 15.w,
                          color: AppColors.titleColor,
                        ),
                        5.horizontalSpace,
                        Icon(
                          Icons.remove_circle,
                          color: Colors.black54,
                          size: 24.w,
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    ),
                  ),
                ),
                Flexible(
                  child: Card(
                    child: Row(
                      children: [
                        BigText(
                          text: 'Qnt',
                          size: 15.sp,
                        ),
                        10.horizontalSpace,
                        Icon(
                          Icons.add_circle,
                          color: Colors.black54,
                          size: 24.w,
                        ),
                        5.horizontalSpace,
                        BigText(
                          text: '250',
                          size: 15.w,
                          color: AppColors.titleColor,
                        ),
                        5.horizontalSpace,
                        Icon(
                          Icons.remove_circle,
                          color: Colors.black54,
                          size: 24.w,
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    ),
                  ),
                ),
              ],
            ),
            10.verticalSpace,
            TextFieldWidget(
              borderRadius: 10.r,
              hintText: 'Add Kitchen Text',
              textEditingController: TextEditingController(),
              maxLIne: 2,
            ),
            10.verticalSpace,
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: AppColors.mainColor,
                textStyle: TextStyle(
                  fontSize: 20.sp,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r)),
              ),
              onPressed: () {},
              child: Text(
                'Add Order',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    ),
    title: 'This is Ignored',
    desc: 'This is also Ignored',
  ).show();
}

deleteItemFromBillAlert(context) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.QUESTION,
    headerAnimationLoop: false,
    animType: AnimType.BOTTOMSLIDE,
    title: 'Chicken biriyani',
    buttonsTextStyle: const TextStyle(color: Colors.black),
    showCloseIcon: true,
    btnCancelOnPress: () {},
    btnOkOnPress: () {},
    btnCancel: DialogButton(
      icon: Icons.delete,
      onPressd: () {},
      text: 'Delete',
      bgColor: Colors.redAccent,
    ),
    btnOk: DialogButton(
      icon: Icons.edit,
      onPressd: () {
        Get.back();
      },
      text: 'Edit',
      bgColor: Colors.green,
    ),
  ).show();
}

orderManageAlert(context) {
  AwesomeDialog(
    customHeader: OrderBillAlertCircle(billId: '125',
    ),
    context: context,
    animType: AnimType.SCALE,
    dialogType: DialogType.INFO,
    body: SingleChildScrollView(
      child: Center(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Chicke biriyani with more extra rice',
                style: TextStyle(
                    fontSize: 20.sp,
                    color: AppColors.titleColor,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              10.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  3.horizontalSpace,
                  Expanded(
                    child: AppMIniButton(
                      bgColor: AppColors.mainColor_2,
                      text: 'Settle',
                      onTap: () {},
                    ),
                  ),
                  3.horizontalSpace,
                  Expanded(
                    child: AppMIniButton(
                      bgColor: AppColors.mainColor,
                      text: 'RIng',
                      onTap: () {},
                    ),
                  ),
                  3.horizontalSpace,
                  Expanded(
                    child: AppMIniButton(
                      bgColor: Colors.purple,
                      text: 'New Order',
                      onTap: () {},
                    ),
                  ),

                ],
              ),
              Row(
                children: [
                  3.horizontalSpace,
                  Expanded(
                    child: AppMIniButton(
                      bgColor: Color(0xff62c5ce),
                      text: 'Bill',
                      onTap: () {

                      },
                    ),
                  ),
                  3.horizontalSpace,
                  Expanded(
                    child: AppMIniButton(
                      bgColor:  Color(0xff4caf50),
                      text: 'Edit',
                      onTap: () {

                      },
                    ),
                  ),
                  3.horizontalSpace,
                  Expanded(
                    child: AppMIniButton(
                      bgColor: Color(0xff62c5ce),
                      text: 'Cancel',
                      onTap: () {

                      },
                    ),
                  ),
                ],
              )

            ],
          ),
        ),
      ),
    ),
    title: 'This is Ignored',
    desc: 'This is also Ignored',
  ).show();
}

void billingCashScreenAlert(context){

  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      title:  Center(child: BigText(text: 'Settle Order')),
      content: SingleChildScrollView(child: const OrderSettileScreen()),

    ),
  );

}

void deliveryAddressAlert(context){

  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      title:  Center(child: BigText(text: 'Enter Address')),
      content: SingleChildScrollView(child: const AddressTextInputScreen()),

    ),
  );

}

void deliveryboySelectAlert(context){

  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      title:  Center(child: BigText(text: 'Select Delivery Boy')),
      content: SingleChildScrollView(child: const DeliveryBoySelectScreen()),

    ),
  );

}

void addNewonlineAppAlert(context){

  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      title:  Center(child: BigText(text: 'Select Delivery Boy')),
      content: SingleChildScrollView(child: const DeliveryBoySelectScreen()),

    ),
  );

}

void addOrderIdAlert(context){
  AwesomeDialog(
    context: context,
    animType: AnimType.SCALE,
    dialogType: DialogType.INFO,
    keyboardAware: true,
    body: Padding(
      padding: EdgeInsets.all(8.sp),
      child: Column(
        children: <Widget>[
          Text(
            'Order ID',
            style: Theme.of(context).textTheme.headline6,
          ),
          10.verticalSpace,
          TextFieldWidget(
              textEditingController: TextEditingController(),
              autoFocus: true,
              hintText: 'hintText',
              borderRadius: 15.r),
          10.verticalSpace,
          AppMIniButton(
            text: 'Submit Order ID',
            onTap: () {},
            bgColor: AppColors.mainColor,
          )
        ],
      ),
    ),
  )..show();
}

void successAlert(context){
  AwesomeDialog(
    context: context,
    dialogType: DialogType.SUCCES,
    animType: AnimType.SCALE,
    title: 'Auto Hide Dialog',
    desc: 'AutoHide after 2 seconds',
    autoHide: const Duration(seconds: 3),
  ).show();
}



