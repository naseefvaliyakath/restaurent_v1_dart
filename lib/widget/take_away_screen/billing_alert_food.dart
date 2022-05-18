import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:restowrent_v_two/app_constans/app_colors.dart';

class BillingAlertFood extends StatelessWidget {
  final String img;

  const BillingAlertFood(
      {Key? key, required this.img,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.sp,
      height: 250.sp,
      margin: EdgeInsets.all(5.sp),
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(img),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(100.r),

      ),
    );
  }
}
