import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppMIniButton extends StatelessWidget {
  final String text;
  final Color bgColor;
  final Function onTap;


  const AppMIniButton(
      {Key? key, required this.text, required this.bgColor, required this.onTap,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: bgColor,
        textStyle: TextStyle(
          fontSize: 14.sp,
        ),
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      ),
      onPressed: () {
        onTap();
      },
      child: FittedBox(
        child: Text(
          text,
          softWrap: false,
          overflow: TextOverflow.clip,
          maxLines: 1,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
