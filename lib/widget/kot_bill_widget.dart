import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restowrent_v_two/widget/small_text.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:get/get.dart';
import '../screens/dining_screen/controller/dining_billing_controller.dart';
import 'big_text.dart';
import 'horezondal_divider.dart';
import 'kot_bill_item_heding.dart';
import 'kot_item_tile.dart';
import 'mid_text.dart';

class KotBillWidget extends StatelessWidget {
  final String type;
  final int kotId;
  final List<dynamic> billingItems;
  //for show the table from order view page
  final String tableName;

  const KotBillWidget({Key? key, required this.type, required this.billingItems, required this.kotId,  this.tableName = ''}) : super(key: key);

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
          BigText(text: 'KOT', color: Colors.black),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SmallText(
                text: 'KOT ID : $kotId',
                color: Colors.black54,
                size: 15.sp,
              ),
              SmallText(
                text: 'DATE : 01-05-2022',
                color: Colors.black54,
                size: 10.sp,
              ),
            ],
          ),
          3.verticalSpace,
          HorezondalDivider(color: Colors.black, height: 1.sp),
          SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MidText(
                  text: 'TYPE : $type',
                  size: 13.sp,
                  color: Colors.black,
                ),
                MidText(
                  text: type == 'DINING'
                      ? (Get.find<DiningBillingController>().tableId != -1
                          ? 'TABLE :${Get.find<DiningBillingController>().selectedTableName} (${Get.find<DiningBillingController>().roomName})'
                          : 'TABLE : NO TABLE')
                      : type == 'ORDER_VIEW' ? 'TABLE :$tableName' :'TABLE :',
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
              shrinkWrap: true,
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
        ],
      ),
    );
  }
}
