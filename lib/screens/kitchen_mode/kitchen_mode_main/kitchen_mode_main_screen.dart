import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:restowrent_v_two/hive_database/controller/hive_hold_bill_controller.dart';
import 'package:restowrent_v_two/model/kitchen_order_response/order_bill.dart';
import 'package:restowrent_v_two/routes/route_helper.dart';
import 'package:restowrent_v_two/screens/kitchen_mode/kitchen_mode_main/controller/kitchen_mode_main_controller.dart';
import 'package:restowrent_v_two/widget/big_text.dart';
import 'package:restowrent_v_two/widget/order_view_screen/order_category.dart';

import '../../../app_constans/app_colors.dart';
import '../../../widget/app_alerts.dart';
import '../../../widget/date_range_picker.dart';
import '../../../widget/kitchen_mode_main_screen/kitchen_mode_drop_down.dart';
import '../../../widget/order_view_screen/order_status_card.dart';
import '../../sliver_check.dart';

class KitchenModeMainScreen extends StatelessWidget {
  KitchenModeMainScreen({Key? key}) : super(key: key);

  final List categoryCard = [
    {'text': "PENDING", 'circleColor': Colors.orange},
    {'text': "PROGRESS", 'circleColor': Colors.purple},
    {'text': "READY", 'circleColor': Colors.green},
    {'text': "REJECT", 'circleColor': Colors.red},
    {'text': "ALL KOT", 'circleColor': Colors.cyan},
  ];

  final List items = ["Notification", "settings"];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        appCLoseConfirm(context);
        return true;
      },
      child: Scaffold(
        body: GetBuilder<KitchenModeMainController>(builder: (ctrl) {
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
                      appCLoseConfirm(context);
                    },
                    splashRadius: 24.sp,
                  ),
                  snap: true,
                  title: const Text(
                    'Kitchen Orders',
                    overflow: TextOverflow.fade,
                    softWrap: false,
                  ),
                  titleTextStyle: TextStyle(fontSize: 26.sp, color: Colors.black, fontWeight: FontWeight.w600),
                  actions: [SizedBox(height: 50.sp, child: const KitchenModeDropDown()), 15.horizontalSpace],
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
                                text: 'Select Date :',
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
                                  onTap: () async {
                                    //for color change
                                    ctrl.setStatusTappedIndex(index);
                                    //for show different orders
                                    ctrl.updateTappedTabName(categoryCard[index]['text']);
                                    //sorting items
                                    ctrl.updateKotItemsAsPerTab();
                                    if (ctrl.tappedTabName == 'PENDING') {}
                                    if (ctrl.tappedTabName == 'PROGRESS') {}
                                    if (ctrl.tappedTabName == 'READY') {}
                                    if (ctrl.tappedTabName == 'REJECT') {}
                                    if (ctrl.tappedTabName == 'ALL KOT') {}
                                  },
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
                        // checking witch tab is selected
                        if (ctrl.tappedTabName == 'PENDING') {
                          return OrderStatusCard(
                            name: ctrl.kotBillingItems[index].fdOrder!.isEmpty
                                ? "error"
                                : ctrl.kotBillingItems[index].fdOrder?[0].name ?? "",
                            price: (ctrl.kotBillingItems[index].totelPrice).toString(),
                            onTap: () {
                              viewKitchenKotAlert(context: context, tbChrIndexInDb: 0, kotItem: ctrl.kotBillingItems[index]);
                            },
                            borderColor: Colors.orange,
                            orderId: ctrl.kotBillingItems[index].Kot_id,
                            orderStatus: ctrl.kotBillingItems[index].fdOrderStatus,
                            orderType: ctrl.kotBillingItems[index].fdOrderType,
                            dateTime: '26-04-20222 : 10:30',
                            totelItem: ctrl.kotBillingItems[index].fdOrder!.length,
                          );
                        }
                        if (ctrl.tappedTabName == 'PROGRESS') {
                          return OrderStatusCard(
                            name: ctrl.kotBillingItems[index].fdOrder!.isEmpty
                                ? "error"
                                : ctrl.kotBillingItems[index].fdOrder?[0].name ?? "",
                            price: (ctrl.kotBillingItems[index].totelPrice).toString(),
                            onTap: () {
                              viewKitchenKotAlert(context: context, tbChrIndexInDb: 0, kotItem: ctrl.kotBillingItems[index]);
                            },
                            borderColor: Colors.pink,
                            orderId: ctrl.kotBillingItems[index].Kot_id,
                            orderStatus: ctrl.kotBillingItems[index].fdOrderStatus,
                            orderType: ctrl.kotBillingItems[index].fdOrderType,
                            dateTime: '26-04-20222 : 10:30',
                            totelItem: ctrl.kotBillingItems[index].fdOrder!.length,
                          );
                        }
                        if (ctrl.tappedTabName == 'READY') {
                          return OrderStatusCard(
                            name: ctrl.kotBillingItems[index].fdOrder!.isEmpty
                                ? "error"
                                : ctrl.kotBillingItems[index].fdOrder?[0].name ?? "",
                            price: (ctrl.kotBillingItems[index].totelPrice).toString(),
                            onTap: () {
                              viewKitchenKotAlert(context: context, tbChrIndexInDb: 0, kotItem: ctrl.kotBillingItems[index]);
                            },
                            borderColor: Colors.green,
                            cardColor: Colors.green.withOpacity(0.1),
                            orderId: ctrl.kotBillingItems[index].Kot_id,
                            orderStatus: ctrl.kotBillingItems[index].fdOrderStatus,
                            orderType: ctrl.kotBillingItems[index].fdOrderType,
                            dateTime: '26-04-20222 : 10:30',
                            totelItem: ctrl.kotBillingItems[index].fdOrder!.length,
                          );
                        }

                        if (ctrl.tappedTabName == 'REJECT') {
                          return OrderStatusCard(
                            name: ctrl.kotBillingItems[index].fdOrder!.isEmpty
                                ? "error"
                                : ctrl.kotBillingItems[index].fdOrder?[0].name ?? "",
                            price: (ctrl.kotBillingItems[index].totelPrice).toString(),
                            onTap: () {
                              viewKitchenKotAlert(context: context, tbChrIndexInDb: 0, kotItem: ctrl.kotBillingItems[index]);
                            },
                            borderColor: Colors.red,
                            cardColor: Colors.red.withOpacity(0.1),
                            orderId: ctrl.kotBillingItems[index].Kot_id,
                            orderStatus: ctrl.kotBillingItems[index].fdOrderStatus,
                            orderType: ctrl.kotBillingItems[index].fdOrderType,
                            dateTime: '26-04-20222 : 10:30',
                            totelItem: ctrl.kotBillingItems[index].fdOrder!.length,
                          );
                        } else {
                          return OrderStatusCard(
                            name: ctrl.kotBillingItems[index].fdOrder!.isEmpty
                                ? "error"
                                : ctrl.kotBillingItems[index].fdOrder?[0].name ?? "",
                            price: (ctrl.kotBillingItems[index].totelPrice).toString(),
                            onTap: () {
                              viewKitchenKotAlert(context: context, tbChrIndexInDb: 0, kotItem: ctrl.kotBillingItems[index]);
                            },
                            borderColor: ctrl.allKotBillingItems[index].fdOrderStatus == 'pending'
                                ? Colors.orange
                                : ctrl.allKotBillingItems[index].fdOrderStatus == 'progress'
                                    ? Colors.pink
                                    : ctrl.allKotBillingItems[index].fdOrderStatus == 'ready'
                                        ? Colors.green
                                        : ctrl.allKotBillingItems[index].fdOrderStatus == 'reject'
                                            ? Colors.red
                                            : Colors.orange,
                            cardColor: ctrl.kotBillingItems[index].fdOrderStatus == 'reject'
                                ? Colors.red.withOpacity(0.1)
                                : ctrl.kotBillingItems[index].fdOrderStatus == 'ready'
                                ? Colors.green.withOpacity(0.1)
                                : Colors.white,
                            orderId: ctrl.kotBillingItems[index].Kot_id,
                            orderStatus: ctrl.kotBillingItems[index].fdOrderStatus,
                            orderType: ctrl.kotBillingItems[index].fdOrderType,
                            dateTime: '26-04-20222 : 10:30',
                            totelItem: ctrl.kotBillingItems[index].fdOrder!.length,
                          );
                        }
                      },
                      childCount: ctrl.kotBillingItems.length,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(value: item, child: Text(item));
}
