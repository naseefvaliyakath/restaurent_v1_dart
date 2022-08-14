import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app_constans/app_colors.dart';

class TableRectangle extends StatelessWidget {
  final double width;
  final double height;
  final String text;

  const TableRectangle(
      {Key? key, required this.width, required this.height, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: Color(0xffe75f10),
          borderRadius: BorderRadius.circular(5.r),
          border: Border.all(width: 1.sp, color: AppColors.mainColor)),
      child: Center(
          child: RotatedBox(
              quarterTurns: 3,
              child: Text(
                text,
                style: TextStyle(color: Colors.white),
              ))),
    );
  }
}
