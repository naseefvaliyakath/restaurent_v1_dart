import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:restowrent_v_two/routes/route_helper.dart';
import 'package:restowrent_v_two/screens/sliver_check.dart';
import 'package:restowrent_v_two/screens/take_away_billing%20screen/take_away_billing%20screen.dart';
import 'package:restowrent_v_two/widget/app_min_button.dart';
import 'package:restowrent_v_two/widget/card_design.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:restowrent_v_two/widget/mid_text.dart';

import '../app_constans/app_colors.dart';
import '../model/kitchen_order_response/kitchen_order.dart';
import '../model/kitchen_order_response/order_bill.dart';
import '../widget/app_alerts.dart';
import '../widget/app_round_mini_btn.dart';
import '../widget/big_text.dart';
import '../widget/heading_rich_text.dart';
import 'dining_screen/dining_billing_screen.dart';
import 'home_delivery_screen/home_delivery_screen.dart';
import 'select_online_app_screen/online_booking_screen.dart';

class DashBordScreen extends StatelessWidget {
  const DashBordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        appCLoseConfirm(context);
        return false;
      },
      child: SafeArea(
          child: Column(
        children: <Widget>[
          10.verticalSpace,
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16).r,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // heading my restawrent
                const HeadingRichText(name: 'Quality Restaurants '),
                //notification
                InkWell(
                  onTap: () {
                    Get.to(MyApp());
                  },
                  child: Container(
                    padding: EdgeInsets.all(8.sp),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), border: Border.all(color: Colors.grey)),
                    child: Center(
                      child: Badge(
                        badgeColor: Colors.red,
                        child: Icon(
                          FontAwesomeIcons.bell,
                          size: 24.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          20.verticalSpace,
          Expanded(
            child: Container(
              width: double.maxFinite,
              height: double.maxFinite,
              child: GridView.count(
                  childAspectRatio: 2.7 / 2.2,
                  padding: const EdgeInsets.only(left: 16, right: 16).r,
                  crossAxisCount: 2,
                  crossAxisSpacing: 18.sp,
                  mainAxisSpacing: 18.sp,
                  children: [
                    InkWell(
                      onTap: () {
                        //always add argument for all route else error will occure
                        KitchenOrder emptyKotOrder = KitchenOrder(
                            Kot_id: -1,
                            error: true,
                            errorCode: 'SomthingWrong',
                            totalSize: 0,
                            fdOrderStatus: 'Pending',
                            fdOrderType: 'Takeaway',
                            fdOrder: [],
                            totelPrice: 0,
                            orderColor: 111);
                        Get.toNamed(RouteHelper.getTakeAwayBillingScreen(),);
                      },
                      child: CardDesign(
                        title: 'Take Away',
                        subTitle: 'food take away',
                        bgColor: AppColors.mainColor,
                        icon: FontAwesomeIcons.burger,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        //always add args to call route else error will occure
                        Get.toNamed(RouteHelper.getHomeDeliveryScreen());
                      },
                      child: CardDesign(
                        title: 'Home Delivery',
                        subTitle: 'Home delivry Bills',
                        bgColor: Color(0xff4db6ac),
                        icon: FontAwesomeIcons.wallet,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(RouteHelper.getOnlineAppSelectScreen());
                      },
                      child: CardDesign(
                        title: 'Online Booking',
                        subTitle: 'Online Booking',
                        bgColor: Color(0xff62c5ce),
                        icon: FontAwesomeIcons.kitchenSet,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(RouteHelper.getDiningBillingScreen());
                      },
                      child: CardDesign(
                        title: 'Dining',
                        subTitle: 'Dining Foods',
                        bgColor: Color(0xff4caf50),
                        icon: FontAwesomeIcons.burger,
                      ),
                    ),
                    InkWell(
                      onTap: () {

                      },
                      child: CardDesign(
                        title: 'Waitert',
                        subTitle: 'Waiter status',
                        bgColor: Color(0xff727070),
                        icon: FontAwesomeIcons.bowlFood,
                      ),
                    ),
                    CardDesign(
                      title: 'Food Court',
                      subTitle: 'Today Foods',
                      bgColor: Color(0xffd838de),
                      icon: FontAwesomeIcons.burger,
                    ),
                    CardDesign(
                      title: 'Food Court',
                      subTitle: 'Today Foods',
                      bgColor: Color(0xffee588f),
                      icon: FontAwesomeIcons.burger,
                    ),
                    CardDesign(
                      title: 'Bill',
                      subTitle: 'Costemer Bills',
                      bgColor: AppColors.mainColor_2,
                      icon: FontAwesomeIcons.wallet,
                    ),
                  ]),
            ),
          )
        ],
      )),
    );
  }
}

void myConfirmDialog({
  required BuildContext context,
  required String title,
  required String content,
  required String okButtonTxt,
  required String cancelBtnTxt,
  required Function okOnTap,
  required Function cancelOnTap,

}) {
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
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5.sp),
                  color: Colors.transparent,
                  width: 0.8.sw,
                  height: 200,
                  child: Stack(
                    alignment: AlignmentDirectional.topCenter,
                    children: [
                      Positioned(
                        top: 25.h,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 5.sp),
                          width: 0.7.sw,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.sp),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                55.verticalSpace,
                                FittedBox(
                                    child: BigText(
                                  text: title,
                                  color: Colors.black,
                                )),
                                5.verticalSpace,
                                 FittedBox(
                                    child: Text(
                                  content,
                                  style: const TextStyle(
                                    color: Colors.black54,
                                  ),
                                )),
                                10.verticalSpace,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    AppRoundMiniBtn(
                                      text: okButtonTxt,
                                      color: Colors.green,
                                      onTap: () async {
                                       await okOnTap();
                                      },
                                    ),
                                    AppRoundMiniBtn(
                                        text: cancelBtnTxt,
                                        color: Colors.redAccent,
                                        onTap: () async {
                                          await  cancelOnTap();
                                        })
                                  ],
                                ),
                                10.verticalSpace,
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        child: CircleAvatar(
                          minRadius: 19.r,
                          maxRadius: 31,
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
              ),
            ],
          ));
    },
    animationType: DialogTransitionType.scale,
    curve: Curves.fastOutSlowIn,
    duration: const Duration(milliseconds: 900),
  );
}
