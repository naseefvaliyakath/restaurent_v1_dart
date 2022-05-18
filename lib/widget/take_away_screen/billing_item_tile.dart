import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app_constans/app_colors.dart';

class BillingItemTile extends StatelessWidget {
  final int slNumber;
  final String itemName;
  final int qnt;
  final int price;
  final String kitchenNote;
  final Function onLongTap;

  const BillingItemTile(
      {Key? key,
      required this.slNumber,
      required this.itemName,
      required this.qnt,
      required this.price,
      required this.kitchenNote,
      required this.onLongTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
      onLongTap();
      },
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.textHolder,
            border: Border.all(color: AppColors.textGrey.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(5.r)),
        height: 40.h,
        padding: EdgeInsets.symmetric(
          vertical: 3.sp,
        ),
        margin: EdgeInsets.only(bottom: 2.sp),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  slNumber.toString(),
                  maxLines: 1,
                  style: TextStyle(fontSize: 13.sp),
                ),
                width: 1.sw * 0.1,
                padding: EdgeInsets.only(left: 5.sp),
              ),
              VerticalDivider(
                color: Colors.black,
                thickness: 1.sp,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      itemName,
                      maxLines: 1,
                      style: TextStyle(fontSize: 13.sp),
                    ),
                    Text(
                      kitchenNote,
                      maxLines: 1,
                      style: TextStyle(fontSize: 8.sp, color: Colors.grey),
                    ),
                  ],
                ),
                width: 1.sw * 0.38,
              ),
              VerticalDivider(
                color: Colors.black,
                thickness: 1.sp,
              ),
              Container(
                child: Text(
                  qnt.toString(),
                  maxLines: 1,
                  style: TextStyle(fontSize: 13.sp),
                ),
                width: 1.sw * 0.1,
              ),
              VerticalDivider(
                color: Colors.black,
                thickness: 1.sp,
              ),
              Container(
                child: Text(
                  price.toString(),
                  style: TextStyle(fontSize: 13.sp),
                ),
                width: 1.sw * 0.1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
