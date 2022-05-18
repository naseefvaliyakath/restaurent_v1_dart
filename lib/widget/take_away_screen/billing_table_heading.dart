import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../mid_text.dart';

class BillingTableHeading extends StatelessWidget {
  const BillingTableHeading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withOpacity(0.5),
      padding:
      EdgeInsets.symmetric(vertical: 3.sp, horizontal: 2.sp),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: MidText(text: 'No'),
              width: 1.sw * 0.1,
            ),
            VerticalDivider(
              color: Colors.black,
              thickness: 1.sp,
            ),
            Container(
              child: MidText(
                text: 'Name',
              ),
              width: 1.sw * 0.38,
            ),
            VerticalDivider(
              color: Colors.black,
              thickness: 1.sp,
            ),
            Container(
              child: MidText(text: 'Qnt'),
              width: 1.sw * 0.1,
            ),
            VerticalDivider(
              color: Colors.black,
              thickness: 1.sp,
            ),
            Container(
              child: MidText(
                text: 'Price',
              ),
              width: 1.sw * 0.1,
            )
          ],
        ),
      ),
    );
  }
}
