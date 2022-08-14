import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:restowrent_v_two/app_constans/app_colors.dart';
import 'package:restowrent_v_two/screens/home_delivery_screen/controller/home_delivery_controller.dart';
import 'package:restowrent_v_two/screens/order_view_screen/controller/order_view_controller.dart';
import 'package:restowrent_v_two/screens/take_away_billing%20screen/controller/take_away_controller.dart';
import 'package:restowrent_v_two/widget/big_text.dart';
import 'package:restowrent_v_two/widget/home_delivery/delivery_boy_select_screen.dart';
import 'package:restowrent_v_two/widget/mid_text.dart';
import 'package:restowrent_v_two/widget/progress_button.dart';
import 'package:restowrent_v_two/widget/small_text.dart';
import 'package:restowrent_v_two/widget/table_manage_screen/view_order_in_table_content.dart';
import 'package:restowrent_v_two/widget/text_field_widget.dart';

import '../hive_database/controller/hive_delivery_address_controller.dart';
import '../model/kitchen_order_response/kitchen_order.dart';
import '../model/kitchen_order_response/order_bill.dart';
import 'app_min_button.dart';
import 'app_round_mini_btn.dart';
import 'dialog_button.dart';
import 'home_delivery/address_text_input_screen.dart';
import 'myDialogBody.dart';
import 'order_settile_screen/order_update_settil_screen.dart';
import 'order_settile_screen/order_settil_screen.dart';
import 'order_view_screen/order_alert_bill_id_circle.dart';
import 'order_view_screen/view_order_list_content.dart';
import 'take_away_screen/billing_alert_food.dart';

// in order hystory page
kotOrderManageAlert({required BuildContext context, required OrderViewController ctrl, required int index}) {
  showAnimatedDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
          insetPadding: EdgeInsets.all(0.sp),
          titlePadding: EdgeInsets.all(0.sp),
          actionsAlignment: MainAxisAlignment.center,
          contentPadding: EdgeInsets.symmetric(vertical: 0.sp, horizontal: 3.sp),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
          backgroundColor: Colors.transparent,
          content: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    width: 0.8.sw,
                    height: 270.h,
                    child: Stack(
                      alignment: AlignmentDirectional.topCenter,
                      children: [
                        Positioned(
                          top: 45.h,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10.sp),
                            width: 0.8.sw,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                20.verticalSpace,
                                Text(
                                  '${ctrl.kotBillingItems![index].fdOrder!.first.name} and other ${ctrl.kotBillingItems![index].fdOrder!.length - 1} items',
                                  style: TextStyle(fontSize: 20.sp, color: AppColors.titleColor, fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.center,
                                ),
                                10.verticalSpace,
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                                  height: 45.h,
                                  child: IntrinsicHeight(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        3.horizontalSpace,
                                        Expanded(
                                          child: AppMIniButton(
                                            bgColor: AppColors.mainColor_2,
                                            text: 'Settle',
                                            onTap: () {
                                              Navigator.pop(context);
                                              ctrl.settleKotBillingCash(context, ctrl, index);
                                            },
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
                                            text: 'View Order',
                                            onTap: () {
                                              Navigator.pop(context);
                                              viewOrderListAlert(ctrl: ctrl, context: context, kotIndex: index);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                10.verticalSpace,
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                                  height: 45.h,
                                  child: IntrinsicHeight(
                                    //for make all button same height
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        3.horizontalSpace,
                                        Expanded(
                                          child: AppMIniButton(
                                            bgColor: Color(0xff62c5ce),
                                            text: 'Bill',
                                            onTap: () {},
                                          ),
                                        ),
                                        3.horizontalSpace,
                                        Expanded(
                                          child: AppMIniButton(
                                            bgColor: Color(0xff4caf50),
                                            text: 'Edit',
                                            onTap: () {
                                              Navigator.pop(context); //this not add then page note kill
                                              //otherwaiys will throw error
                                              KitchenOrder emptyKotOrder = KitchenOrder(
                                                  Kot_id: -1,
                                                  error: true,
                                                  errorCode: 'Something Wrong',
                                                  totalSize: 0,
                                                  fdOrderStatus: 'Pending',
                                                  fdOrderType: 'Takeaway',
                                                  fdOrder: [],
                                                  totelPrice: 0,
                                                  orderColor: 111);
                                              ctrl.updateKotOrder(
                                                // sending full kot order , so need kot id also
                                                kotBillingOrder: ctrl.kotBillingItems?[index] ?? emptyKotOrder,
                                                orderType: ctrl.kotBillingItems?[index].fdOrderType ?? 'Takeaway',
                                              );
                                            },
                                          ),
                                        ),
                                        3.horizontalSpace,
                                        Expanded(
                                          child: ProgressButton(
                                            btnCtrlName: 'CancelOrder',
                                            text: 'Cancel',
                                            ctrl: ctrl,
                                            color: const Color(0xffef2f28),
                                            onTap: () async {
                                              await ctrl.deleteKotOrder(ctrl.kotBillingItems?[index].Kot_id ?? -1);
                                              ctrl.refreshDatabaseKot();
                                              Future.delayed(const Duration(seconds: 1), () {
                                                Navigator.pop(context);
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          child: CircleAvatar(
                            minRadius: 26.r,
                            maxRadius: 38.r,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.question_mark_sharp,
                              size: 38.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 3,
                          child: CircleAvatar(
                            minRadius: 19.r,
                            maxRadius: 31.r,
                            backgroundColor: Colors.green,
                            child: Icon(
                              Icons.question_mark_sharp,
                              size: 38.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ));
    },
    animationType: DialogTransitionType.scale,
    curve: Curves.fastOutSlowIn,
    duration: const Duration(milliseconds: 900),
  );
}

//in all billing page
void billingCashScreenAlert({required context, required ctrl, required from}) {
  showAnimatedDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
        insetPadding: EdgeInsets.all(5.sp),
        titlePadding: EdgeInsets.all(5.sp),
        contentPadding: EdgeInsets.symmetric(vertical: 5.sp, horizontal: 5.sp),
        actionsAlignment: MainAxisAlignment.center,
        title: Center(child: BigText(text: 'Settle Order')),
        content: SingleChildScrollView(
            child: from == 'billing' ? OrderSettileScreen(ctrl: ctrl) : OrderUpdateSettileScreen(ctrl: ctrl)),
      );
    },
    animationType: DialogTransitionType.scale,
    curve: Curves.fastOutSlowIn,
    duration: const Duration(milliseconds: 900),
  );
}

//in home deliver page
void deliveryAddressAlert({required BuildContext context, required HomeDeliveryController ctrl}) {
  try {
    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
          insetPadding: const EdgeInsets.all(0),
          titlePadding:  EdgeInsets.all(10.sp),
          contentPadding:  EdgeInsets.all(10.sp),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            AppRoundMiniBtn(
              text: 'Submit',
              color: Colors.green,
              onTap: () {
                ctrl.addDeliveryAddressItem(context:context);
              },
            ),
            AppRoundMiniBtn(
                text: 'Close',
                color: Colors.redAccent,
                onTap: () {
                  Navigator.pop(context);
                })
          ],
          title: Center(child: BigText(text: 'Enter Address')),
          content:  SingleChildScrollView(child: AddressTextInputScreen(ctrl: ctrl)),
        );
      },
      animationType: DialogTransitionType.scale,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 900),
    );
  } catch (e) {
    rethrow;
  }

/*  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
      title: Center(child: BigText(text: 'Enter Address')),
      content: SingleChildScrollView(child: const AddressTextInputScreen()),
    ),
  );*/
}

//in home deliver page
void deliveryboySelectAlert(context) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
      title: Center(child: BigText(text: 'Select Delivery Boy')),
      content: SingleChildScrollView(child: const DeliveryBoySelectScreen()),
    ),
  );
}

//in onlinebooking page
void addNewonlineAppAlert(context) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
      title: Center(child: BigText(text: 'Select Delivery Boy')),
      content: SingleChildScrollView(child: const DeliveryBoySelectScreen()),
    ),
  );
}

//in onlinebooking page
void addOrderIdAlert(context) {
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
            borderRadius: 15.r,
            onChange: (_) {},
          ),
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

void successAlert(context) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.SUCCES,
    animType: AnimType.SCALE,
    title: 'Auto Hide Dialog',
    desc: 'AutoHide after 2 seconds',
    autoHide: const Duration(seconds: 3),
  ).show();
}

//confirmation for close the app
void appCLoseConfirm(context) {
  MyDialogBody.myConfirmDialogBody(
    context: context,
    title: 'Hold the items ?',
    desc: 'Do you Want to hold the  item entered ?',
    btnCancelText: 'No',
    btnOkText: 'Yes',
    onTapOK: () async {
      SystemNavigator.pop();
    },
    onTapCancel: () async {
      Get.back();
    },
  );


}

//can be used as cpommen deleted
void deleteAlert({context, onTap}) {
  MyDialogBody.myConfirmDialogBody(
    context: context,
    title: 'Delete this food?',
    desc: 'Do you Want to delete food ?',
    btnCancelText: 'No',
    btnOkText: 'Yes',
    onTapOK: () async {
      await onTap();
      Navigator.pop(context);
    },
    onTapCancel: () async {
      Navigator.pop(context);
    },
  );
}


//can be used as cpommen deleted
void generalConfirmAlert({required context,required onTap,required onTapCancel, required title,required desc}) {
  MyDialogBody.myConfirmDialogBody(
    context: context,
    title: title,
    desc: desc,
    btnCancelText: 'No',
    btnOkText: 'Yes',
    onTapOK: () async {
      await onTap();
      Navigator.pop(context);
    },
    onTapCancel: () async {
      onTapCancel();
      Navigator.pop(context);
    },
  );
}


//view order list alert(Showing orderd item and its staus) i orderView
void viewOrderListAlert({required context, required ctrl,required int kotIndex}) {
  showAnimatedDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
          insetPadding: EdgeInsets.symmetric(horizontal: 5.sp),
          titlePadding: EdgeInsets.symmetric(horizontal: 5.sp,vertical: 10.sp),
          contentPadding: EdgeInsets.symmetric(horizontal: 5.sp),
          actionsAlignment: MainAxisAlignment.center,
          title: Center(child: BigText(text: 'View Orders')),
          content:  SingleChildScrollView(
            child: ViewOrderListContent(kotInt: kotIndex, ctrl: ctrl,),
          ));
    },
    animationType: DialogTransitionType.scale,
    curve: Curves.fastOutSlowIn,
    duration: const Duration(milliseconds: 900),
  );
}



//view order list alert(Showing orderd item and its staus) in taleMAage scree when clo]ick on chair
void viewOrderInTableAlert({required context,required int kotId,required int tbChrIndexInDb}) {
  showAnimatedDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
          insetPadding: EdgeInsets.symmetric(horizontal: 5.sp),
          titlePadding: EdgeInsets.only(left: 5.sp,right:5.sp,top: 10.sp),
          contentPadding: EdgeInsets.symmetric(horizontal: 5.sp),
          actionsAlignment: MainAxisAlignment.center,
          title: Center(child: BigText(text: 'View Orders')),
          content:  SingleChildScrollView(
            child: ViewOrderInTaleContent(kotId: kotId, tbChrIndexInDb: tbChrIndexInDb,),
          ));
    },
    animationType: DialogTransitionType.scale,
    curve: Curves.fastOutSlowIn,
    duration: const Duration(milliseconds: 900),
  );
}