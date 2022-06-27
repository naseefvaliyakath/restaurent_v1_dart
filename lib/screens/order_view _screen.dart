import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:restowrent_v_two/widget/big_text.dart';
import 'package:restowrent_v_two/widget/order_view_screen/order_category.dart';

import '../app_constans/app_colors.dart';
import '../widget/app_alerts.dart';
import '../widget/date_range_picker.dart';
import '../widget/order_view_screen/order_status_card.dart';

class OrderViewScreen extends StatelessWidget {
  OrderViewScreen({Key? key}) : super(key: key);

  int tappedIndex = 0;
  CrossFadeState state = CrossFadeState.showFirst;
  List categoryCard = [
    {'text': "PENDING", 'circleColor': Colors.redAccent},
    {'text': "SETTLED", 'circleColor': Colors.green},
    {'text': "HOLD", 'circleColor': Colors.blueAccent},
    {'text': "QUICK PAY", 'circleColor': Colors.yellowAccent},
    {'text': "ALL ORDER", 'circleColor': Colors.pink},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          primary: false,
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              pinned: true,
              leading: Icon(
                Icons.arrow_back,
                size: 24.sp,
              ),
              snap: true,
              title: Text(
                'All Orders',
                overflow: TextOverflow.fade,
                softWrap: false,
              ),
              titleTextStyle: TextStyle(fontSize: 26.sp, color: Colors.black, fontWeight: FontWeight.w600),
              actions: [
                Badge(
                  badgeColor: Colors.red,
                  child: Container(
                      margin: EdgeInsets.only(right: 10.w),
                      child: Icon(
                        FontAwesomeIcons.bell,
                        size: 24.sp,
                      )),
                ),
              ],
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(110.h),
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0.w, right: 10.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FittedBox(
                              child: BigText(
                            text: 'Select Date : ',
                            size: 18.sp,
                          )),
                          Flexible(
                            child: InkWell(
                              onTap: () {
                                Get.to(DateRangePickerDemo());
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                                child: SizedBox(
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 8.h),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.calendar_today,
                                            color: Colors.grey,
                                            size: 24.sp,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 10.0.w),
                                            child: FittedBox(
                                              child: Text(
                                                "22/03/2022 (Today)",
                                                style: TextStyle(
                                                  fontSize: 15.sp,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0.w),
                            child: Container(
                                padding: EdgeInsets.all(8.sp),
                                decoration: BoxDecoration(
                                  color: Color(0xFFF7F7F7),
                                  borderRadius: BorderRadius.circular(50),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black87.withOpacity(0.1),
                                      spreadRadius: 1.sp,
                                      blurRadius: 1.r,
                                      offset: const Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: Center(
                                    child: Icon(
                                  Icons.qr_code_scanner,
                                  size: 24.sp,
                                  color: Colors.grey,
                                ))),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 55.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categoryCard.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return InkWell(
                              onTap: () {},
                              //category tile
                              child: OrderCategory(
                                color: tappedIndex == index ? AppColors.mainColor_2 : Colors.white,
                                circleColor: categoryCard[index]['circleColor'],
                                text: categoryCard[index]['text'],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              backgroundColor: const Color(0xfffafafa),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverGrid.count(
                  childAspectRatio: 2 / 3,
                  crossAxisCount: 2,
                  crossAxisSpacing: 18.sp,
                  mainAxisSpacing: 18.sp,
                  children: [
                    OrderStatusCard(
                      name: 'Chicken CurryPasta',
                      price: 'Rs : 250',
                      onTap: () {
                        orderManageAlert(context);
                      },
                    ),
                    OrderStatusCard(
                      name: 'Explosion Burger',
                      price: 'Rs : 350',
                      onTap: () {},
                    ),
                    OrderStatusCard(
                      name: 'Grilled Chicken',
                      price: 'Rs : 500',
                      onTap: () {},
                    ),
                    OrderStatusCard(
                      name: 'Grilled Fish',
                      price: 'Rs : 1200',
                      onTap: () {},
                    ),
                    OrderStatusCard(
                      name: 'Heavenly Pizza',
                      price: 'Rs : 950',
                      onTap: () {},
                    ),
                    OrderStatusCard(
                      name: 'Mandarin Pancake',
                      price: 'Rs : 10',
                      onTap: () {},
                    ),
                    OrderStatusCard(
                      name: 'Organic Mandarin',
                      price: 'Rs : 260',
                      onTap: () {},
                    ),
                    OrderStatusCard(
                      name: 'Organic Orange',
                      price: 'Rs : 3000',
                      onTap: () {},
                    ),
                    OrderStatusCard(
                      name: 'Raspberries Cake',
                      price: 'Rs : 500',
                      onTap: () {},
                    ),
                    OrderStatusCard(
                      name: 'Organic Mandarin',
                      price: 'Rs : 250',
                      onTap: () {},
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
