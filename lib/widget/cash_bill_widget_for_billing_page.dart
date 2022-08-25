import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restowrent_v_two/model/settled_order_response/settled_order.dart';
import 'package:restowrent_v_two/widget/small_text.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:get/get.dart';
import '../screens/dining_screen/controller/dining_billing_controller.dart';
import 'big_text.dart';
import 'horezondal_divider.dart';
import 'kot_bill_item_heding.dart';
import 'kot_item_tile.dart';
import 'mid_text.dart';

class CashBillWidgetForBillingPage extends StatelessWidget {
  final String orderType;
  final num grandTotal;
  final num change;
  final num cashReceived;
  final num netAmount;
  final num discountCash;
  final num discountPercent;
  final num charges;
  final List<dynamic> billingItems;

  const CashBillWidgetForBillingPage(
      {Key? key,
      required this.billingItems,
      required this.orderType,
      required this.grandTotal,
      required this.change,
      required this.cashReceived,
      required this.netAmount,
      required this.discountCash,
      required this.discountPercent,
      required this.charges})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TicketWidget(
      width: 0.8 * 1.sw,
      height: 0.68 * 1.sh,
      isCornerRounded: true,
      padding: EdgeInsets.symmetric(horizontal: 20.sp),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              width: 50.sp,
              height: 50.sp,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage('https://mobizate.com/uploadsOnlineApp/logo_hotel.png'),
                ),
              )),
          BigText(
            text: 'INVOICE',
            color: Colors.black,
            size: 20.sp,
          ),
          HorezondalDivider(color: Colors.black, height: 1.sp),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //if possible make id , its better

              // SmallText(
              //   text: 'ORDER ID : ${singleOrder.settled_id}',
              //   color: Colors.black54,
              //   size: 15.sp,
              // ),
              SmallText(
                text: 'DATE : 01-05-2022',
                color: Colors.black54,
                size: 10.sp,
              ),
            ],
          ),
          3.verticalSpace,
          SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MidText(
                  text: 'TYPE : $orderType',
                  size: 13.sp,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          3.verticalSpace,
          HorezondalDivider(color: Colors.black, height: 1.sp),
          const KotBillItemHeading(),
          HorezondalDivider(color: Colors.black, height: 1.sp),
          3.verticalSpace,
          Flexible(
            child: ListView.builder(
              shrinkWrap: false,
              itemBuilder: (context, index) {
                return KotItemTile(
                  index: index,
                  slNumber: index + 1,
                  itemName: billingItems[index]['name'],
                  qnt: billingItems[index]['qnt'],
                  kitchenNote: billingItems[index]['ktNote'],
                );
              },
              itemCount: billingItems.length,
            ),
          ),
          HorezondalDivider(color: Colors.black, height: 1.sp),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //Grand Total
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MidText(
                      text: 'Grand Total      : ',
                      size: 10.sp,
                    ),
                    MidText(
                      text: '$grandTotal',
                      size: 10.sp,
                    ),
                  ],
                ),
                //Charges
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MidText(
                      text: 'Charges             : ',
                      size: 10.sp,
                    ),
                    MidText(
                      text: '$charges',
                      size: 10.sp,
                    ),
                  ],
                ),
                //Discount in cash
                Visibility(
                  visible: discountCash == 0 ? false : true,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MidText(
                        text: 'Discount           : ',
                        size: 10.sp,
                      ),
                      MidText(
                        text: '$discountCash',
                        size: 10.sp,
                      ),
                    ],
                  ),
                ),

                //Discount in %
                Visibility(
                  visible: discountPercent == 0 ? false : true,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MidText(
                        text: 'Discount in %  : ',
                        size: 10.sp,
                      ),
                      MidText(
                        text: '$discountPercent',
                        size: 10.sp,
                      ),
                    ],
                  ),
                ),

                HorezondalDivider(color: Colors.black54, height: 1.sp),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MidText(
                      text: 'Net Total            : ',
                      size: 13.sp,
                    ),
                    MidText(
                      text: ' $netAmount',
                      size: 13.sp,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MidText(
                      text: 'Cash Received  : ',
                      size: 13.sp,
                    ),
                    MidText(
                      text: ' $cashReceived',
                      size: 13.sp,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MidText(
                      text: 'Change               : ',
                      size: 13.sp,
                    ),
                    MidText(
                      text: ' $change',
                      size: 13.sp,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
