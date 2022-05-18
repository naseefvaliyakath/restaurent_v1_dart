import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:restowrent_v_two/screens/sliver_check.dart';
import 'package:restowrent_v_two/screens/take_away_billing%20screen.dart';
import 'package:restowrent_v_two/widget/card_design.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../app_constans/app_colors.dart';
import 'dining_screen.dart';
import 'home_delivery_screen.dart';
import 'online_booking_screen.dart';

class DashBordScreen extends StatelessWidget {
  const DashBordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: <Widget>[
        10.verticalSpace,
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16).r,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // heading my restawrent
              Flexible(
                child: FittedBox(
                  child: RichText(
                    softWrap: false,
                    text: TextSpan(children: [
                      TextSpan(
                          text: "Quality Restaurants ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28.sp,
                              color: AppColors.textColor)),
                    ]),
                    maxLines: 1,
                  ),
                ),
              ),
              //notification
              InkWell(
                onTap: () {

                },
                child: Container(
                  padding: EdgeInsets.all(8.sp),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: Colors.grey)),
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
                      Get.to(const TakeAwayBillingScreen());
                    },
                    child: CardDesign(
                      title: 'Take Away',
                      subTitle: 'food take away',
                      bgColor: AppColors.mainColor,
                      icon: FontAwesomeIcons.burger,
                    ),
                  ),
                  InkWell(
                      onTap:(){
                        Get.to(HomeDeliveryScreen());
                      },
                    child: CardDesign(
                      title: 'Home Delivery',
                      subTitle: 'Home delivry Bills',
                      bgColor: Color(0xff4db6ac),
                      icon: FontAwesomeIcons.wallet,
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Get.to(OnlineBookingScreen());
                    },
                    child: CardDesign(
                      title: 'Online Booking',
                      subTitle: 'Online Booking',
                      bgColor: Color(0xff62c5ce),
                      icon: FontAwesomeIcons.kitchenSet,
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Get.to(DiningScreen());
                    },
                    child: CardDesign(
                      title: 'Dining',
                      subTitle: 'Dining Foods',
                      bgColor: Color(0xff4caf50),
                      icon: FontAwesomeIcons.burger,
                    ),
                  ),
                  CardDesign(
                    title: 'Waitert',
                    subTitle: 'Waiter status',
                    bgColor: Color(0xff727070),
                    icon: FontAwesomeIcons.bowlFood,
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
    ));
  }
}
