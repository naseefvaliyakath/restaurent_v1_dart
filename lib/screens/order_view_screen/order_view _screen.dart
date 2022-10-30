import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:restowrent_v_two/hive_database/controller/hive_hold_bill_controller.dart';
import 'package:restowrent_v_two/model/kitchen_order_response/order_bill.dart';
import 'package:restowrent_v_two/routes/route_helper.dart';
import 'package:restowrent_v_two/screens/order_view_screen/controller/order_view_controller.dart';
import 'package:restowrent_v_two/screens/take_away_billing%20screen/take_away_billing%20screen.dart';
import 'package:restowrent_v_two/widget/big_text.dart';
import 'package:restowrent_v_two/widget/order_view_screen/order_category.dart';

import '../../app_constans/app_colors.dart';
import '../../model/kitchen_order_response/kitchen_order.dart';
import '../../widget/app_alerts.dart';
import '../../widget/app_min_button.dart';
import '../../widget/cash_bill_show_alert_for_order_view.dart';
import '../../widget/date_range_picker.dart';
import '../../widget/myDialogBody.dart';
import '../../widget/order_view_screen/errOrder_status_card.dart';
import '../../widget/order_view_screen/order_hold_card.dart';
import '../../widget/order_view_screen/order_settled_card.dart';
import '../../widget/order_view_screen/order_status_card.dart';
import '../../widget/progress_button.dart';

class OrderViewScreen extends StatelessWidget {
  OrderViewScreen({Key? key}) : super(key: key);

  final List categoryCard = [
    {'text': "KOT", 'circleColor': Colors.redAccent},
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
            physics: const BouncingScrollPhysics(),
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
                                    color: const Color(0xFFF7F7F7),
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
                                  if (ctrl.tappedTabName == 'KOT') {
                                    ctrl.refreshDatabaseKot();
                                  }
                                  if (ctrl.tappedTabName == 'SETTLED') {
                                    ctrl.getAllSettledOrder();
                                    Get.find<HiveHoldBillController>().getHoldBill();
                                  }
                                  if (ctrl.tappedTabName == 'HOLD') {
                                    await ctrl.getAllHoldOrder();
                                  }
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
                      if (ctrl.tappedTabName == 'KOT') {
                        return OrderStatusCard(
                          name: ctrl.kotBillingItems![index].fdOrder!.isEmpty
                              ? "error"
                              : ctrl.kotBillingItems?[index].fdOrder?[0].name ?? "",
                          price: (ctrl.kotBillingItems?[index].totelPrice ?? 0).toString(),
                          onTap: () {
                            kotOrderManageAlert(context: context, ctrl: ctrl, index: index);
                          },
                          borderColor: ctrl.kotBillingItems?[index].fdOrderStatus == 'pending'
                              ? Colors.orange
                              : ctrl.kotBillingItems?[index].fdOrderStatus == 'progress'
                                  ? Colors.pink
                                  : ctrl.kotBillingItems?[index].fdOrderStatus == 'ready'
                                      ? Colors.green
                                      : ctrl.kotBillingItems?[index].fdOrderStatus == 'reject'
                                          ? Colors.red
                                          : Colors.orange,
                          cardColor: ctrl.kotBillingItems![index].fdOrderStatus == 'reject'
                              ? Colors.red.withOpacity(0.1)
                              : ctrl.kotBillingItems![index].fdOrderStatus == 'ready'
                                  ? Colors.green.withOpacity(0.1)
                                  : Colors.white,
                          orderId: ctrl.kotBillingItems?[index].Kot_id ?? 0,
                          orderStatus: ctrl.kotBillingItems![index].fdOrderStatus,
                          orderType: ctrl.kotBillingItems![index].fdOrderType,
                          dateTime: '26-04-20222 : 10:30',
                          totelItem: ctrl.kotBillingItems![index].fdOrder!.length,
                        );
                      }
                      if (ctrl.tappedTabName == 'SETTLED') {
                        return OrderSettledCard(
                          name: ctrl.settledBillingItems![index].fdOrder!.isEmpty
                              ? "no item"
                              : (ctrl.settledBillingItems?[index].fdOrder?[0].name ?? ""),
                          price: '${ctrl.settledBillingItems?[index].grandTotal ?? 0}',
                          onLongTap: () {
                            MyDialogBody.myConfirmDialogBody(
                                title: 'update this order ?',
                                context: context,
                                desc: ' Do yoy want to update this order ? ',
                                btnCancelText: 'Delete',
                                btnOkText: 'Edit',
                                onTapOK: () {
                                  ctrl.updateSettleBillingCash(context, ctrl, index);
                                },
                                onTapCancel: () async {
                                  //delete the settled item from list
                                  await ctrl.deleteSettledOrder(ctrl.settledBillingItems?[index].settled_id ?? -1);
                                  Navigator.pop(context);
                                  //to refresh after update
                                  ctrl.getAllSettledOrder();
                                });
                          },
                          onTap: () {
                            // billing list
                            final List<OrderBill> fdOrder = [];
                            final List<dynamic> billingItems = [];
                            fdOrder.addAll(ctrl.settledBillingItems![index].fdOrder!.toList());
                            print(fdOrder.length);
                            billingItems.clear();
                            for (var element in fdOrder) {
                              billingItems.add({
                                'fdId': element.fdId,
                                'name': element.name,
                                'qnt': element.qnt,
                                'price': element.price.toDouble(),
                                'ktNote': element.ktNote
                              });
                            }
                            cashBillAlertForOrderViewPage(
                              singleOrder: ctrl.settledBillingItems![index],
                              billingItems: billingItems,
                              context: context,
                            );
                          },
                          settledId: ctrl.settledBillingItems?[index].settled_id ?? 0,
                          orderStatus: ctrl.settledBillingItems?[index].fdOrderStatus ?? 'error',
                          orderType: ctrl.settledBillingItems?[index].fdOrderType ?? 'error',
                          dateTime: '26-04-20222 : 10:30',
                          totelItem: ctrl.settledBillingItems?[index].fdOrder!.length ?? 0,
                          kotId: ctrl.settledBillingItems?[index].fdOrderKot ?? -1,
                          payType: ctrl.settledBillingItems?[index].paymentType ?? 'cash',
                        );
                      }

                      if (ctrl.tappedTabName == 'HOLD') {
                        return OrderHoldCard(
                          //checking if bill arry is empty
                          name: ctrl.holdBillingItems![index].holdItem!.isEmpty
                              ? 'error'
                              : ctrl.holdBillingItems?[index].holdItem?[0]['name'] ?? 'error',
                          price: (ctrl.holdBillingItems?[index].totel ?? 0).toString(),
                          onTap: () {
                            MyDialogBody.myConfirmDialogBody(
                                title: 'update this order ?',
                                context: context,
                                desc: ' Do yoy want to update this order ? ',
                                btnCancelText: 'Delete',
                                btnOkText: 'Update',
                                onTapOK: () {
                                  ctrl.unHoldHoldItem(
                                      holdBillingItems: ctrl.holdBillingItems?[index].holdItem ?? [],
                                      holdItemIndex: index,
                                      orderType: ctrl.holdBillingItems?[index].orderType ?? 'Takeaway');
                                },
                                onTapCancel: () async {
                                  //delete the hold item from list
                                  await Get.find<HiveHoldBillController>().deleteHoldBill(index: index);
                                  Navigator.pop(context);
                                  //to refresh after delete
                                  ctrl.getAllHoldOrder();
                                  //to dismiss popup
                                  //  Get.off(OrderViewScreen());
                                });
                          },
                          orderId: index + 1,
                          orderType: ctrl.holdBillingItems![index].orderType!,
                          dateTime:
                              '${ctrl.holdBillingItems![index].date ?? 'date'} ${ctrl.holdBillingItems![index].time ?? 'time'}',
                          totelItem: ctrl.holdBillingItems![index].holdItem?.length ?? 0,
                        );
                      }
                    },
                    childCount: ctrl.tappedTabName == 'KOT'
                        ? ctrl.kotBillingItems!.length
                        : ctrl.tappedTabName == 'SETTLED'
                            ? ctrl.settledBillingItems!.length
                            : ctrl.tappedTabName == 'HOLD'
                                ? ctrl.holdBillingItems!.length
                                : 0,
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
