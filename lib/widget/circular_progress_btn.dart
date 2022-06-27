import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircularProgressBtn extends StatelessWidget {
  final bool isDone;
  final Color color;
  const CircularProgressBtn({Key? key, required this.isDone, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: isDone
          ? Icon(
        Icons.done,
        size: 30.sp,
        color: Colors.white,
      )
          : Center(
          child: Container(
              padding: EdgeInsets.all(3.sp),
              width: 30.sp,
              height: 30.sp,
              child: const CircularProgressIndicator(
                color: Colors.white,
              ))),
    );
  }
}
