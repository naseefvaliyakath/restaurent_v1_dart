import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:restowrent_v_two/widget/app_alerts.dart';

import '../app_constans/app_colors.dart';
import '../widget/food_card.dart';
import '../widget/online_booking_screen/add_new_online_app_card.dart';
import '../widget/online_booking_screen/onlene_app_card.dart';
import '../widget/two_button-bottom_sheet.dart';
import 'add_food_screen.dart';
import 'all_food_screen.dart';
import 'onlinebooking_billing_screen.dart';

class OnlineBookingScreen extends StatelessWidget {
  const OnlineBookingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          primary: false,
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              snap: true,
              leading: Icon(Icons.arrow_back,size: 24.sp,),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //heading
                  Flexible(
                    child: FittedBox(
                      child: RichText(
                        softWrap: false,
                        text: TextSpan(children: [
                          TextSpan(
                              text: "Online Apps Booking",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28.sp,
                                  overflow: TextOverflow.fade,
                                  color: AppColors.textColor)),
                        ]),
                        maxLines: 1,
                      ),
                    ),
                  ),
                  //notification icon
                  Container(
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
                  )
                ],
              ),
              backgroundColor: const Color(0xfffafafa),
            ),
            SliverPadding(
              padding: EdgeInsets.all(20.sp),
              sliver: SliverGrid.count(
                  childAspectRatio: 2 / 2.5,
                  crossAxisCount: 2,
                  crossAxisSpacing: 18.sp,
                  mainAxisSpacing: 18.sp,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(OnlineBookingBillingScreen()) ;
                      },
                      child: OnlineAppCard(
                        text: 'Thalabath',
                        img: 'assets/image/thalabath.jpg',
                      ),
                    ),
                    InkWell(
                      onTap: () {

                      },
                      child: OnlineAppCard(
                        text: 'Snoonu',
                        img: 'assets/image/snoonu.png',
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        addNewonlineAppAlert(context);
                      },
                        child: const AddNewOnlineAppCard())
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
