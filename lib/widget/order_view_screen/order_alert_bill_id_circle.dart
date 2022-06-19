import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restowrent_v_two/app_constans/app_colors.dart';
import 'package:restowrent_v_two/widget/big_text.dart';

class OrderBillAlertCircle extends StatelessWidget {
  final String billId;

  const OrderBillAlertCircle({
    Key? key,
    required this.billId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.sp,
      height: 250.sp,
      margin: EdgeInsets.all(5.sp),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.r),
          color: AppColors.mainColor_2),
      child: Center(
        child: Wrap(
          children: [
            Center(
                child: BigText(
              text: 'Bill ID',
              color: CupertinoColors.white,
              size: 16.sp,
            )),
            Center(
                child: BigText(
              text: billId,
              color: CupertinoColors.white,
              size: 20.sp,
            ))
          ],
        ),
      ),
    );
  }
}
