import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:restowrent_v_two/model/kitchen_order_response/order_bill.dart';
import 'package:restowrent_v_two/screens/order_view_screen/controller/order_view_controller.dart';
import 'package:restowrent_v_two/widget/big_text.dart';
import 'package:restowrent_v_two/widget/order_view_screen/order_category.dart';

import '../../app_constans/app_colors.dart';
import '../../widget/app_alerts.dart';
import '../../widget/date_range_picker.dart';
import '../../widget/order_view_screen/errOrder_status_card.dart';
import '../../widget/order_view_screen/order_status_card.dart';

class OrderViewScreen extends StatelessWidget {
  OrderViewScreen({Key? key}) : super(key: key);

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
      body: GetBuilder<OrderViewController>(builder: (ctrl) {
        return SafeArea(
          child: CustomScrollView(
            primary: false,
            slivers: <Widget>[
              SliverAppBar(
                floating: true,
                pinned: true,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    size: 24.sp,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  splashRadius: 24.sp,
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
                              return OrderCategory(
                                onTap: () => ctrl.setStatusTappedIndex(index),
                                color: ctrl.tappedIndex == index ? AppColors.mainColor_2 : Colors.white,
                                circleColor: categoryCard[index]['circleColor'],
                                text: categoryCard[index]['text'],
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
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200.0.sp,
                    mainAxisSpacing: 18.sp,
                    crossAxisSpacing: 18.sp,
                    childAspectRatio: 2 / 2.8,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      //OrderBill? firstProductInBill = ctrl.billingItems?[index].fdOrder?[0];
                      return ctrl.billingItems![index].fdOrder!.isEmpty
                          ? const ErrOrderStatusCard()
                          : OrderStatusCard(
                              name: ctrl.billingItems?[index].fdOrder?[0]?.name ?? "",
                              price: 'Total : ${ctrl.billingItems?[index].totelPrice ?? 0}',
                              onTap: () {
                                orderManageAlert(context);
                              },
                              orderId: ctrl.billingItems?[index].id ?? 0,
                              orderStatus: ctrl.billingItems![index].fdOrderStatus,
                              orderType: ctrl.billingItems![index].fdOrderType,
                              dateTime: '26-04-20222 : 10:30',
                              totelItem: ctrl.billingItems![index].fdOrder!.length,
                            );
                    },
                    childCount: ctrl.billingItems!.length,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
