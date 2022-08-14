import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:restowrent_v_two/routes/route_helper.dart';
import 'package:restowrent_v_two/widget/app_alerts.dart';
import '../../app_constans/app_colors.dart';
import '../../widget/heading_rich_text.dart';
import '../../widget/notification_icon.dart';
import '../../widget/online_booking_screen/add_new_online_app_card.dart';
import '../../widget/online_booking_screen/onlene_app_card.dart';
import '../online_booking_billing_screen/onlinebooking_billing_screen.dart';



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
              leading:  IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: 24.sp,
                ),
                onPressed: () {
                  Get.back();
                },
                splashRadius: 24.sp,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //heading
                  const HeadingRichText(name: 'Select Online Apps'),
                  //notification icon
                  const NotificationIcon(),
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
                        Get.toNamed(RouteHelper.getOnlineBookingBillingScreen(),arguments: {'holdItem':[]});
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
