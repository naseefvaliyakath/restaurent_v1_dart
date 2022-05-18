import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restowrent_v_two/widget/small_text.dart';

import 'mid_text.dart';

class CardDesign extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subTitle;
  final Color bgColor;

  const CardDesign({
    Key? key,
    required this.icon,
    required this.title,
    required this.subTitle,
    required this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 30.sp, top: 30.sp,right: 15.sp),
      decoration: BoxDecoration(
          color: bgColor.withOpacity(0.9),
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFe8e8e8),
              blurRadius: 5.0,
              offset: Offset(0, 5),
            ),
            BoxShadow(
              color: Color(0xFFfafafa),
              offset: Offset(-5, 0),
            ),
            BoxShadow(
              color: Color(0xFFfafafa),
              offset: Offset(5, 0),
            ),
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            icon,
            color: Colors.white,
            size: 58.sp,
          ),
          FittedBox(
            child: MidText(
              text: title,
              color: Colors.white,
              size: 20.sp,
            ),
          ),
          SmallText(
            text: subTitle,
            color: Colors.white70,
            size: 12.sp,
          ),
        ],
      ),
    );
  }
}
