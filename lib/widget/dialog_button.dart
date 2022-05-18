import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restowrent_v_two/app_constans/app_colors.dart';

class DialogButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color? bgColor;
  final Function onPressd ;
  const DialogButton({Key? key, required this.text, required this.icon, this.bgColor=AppColors.mainColor, required this.onPressd}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        primary: bgColor,
        shape: new RoundedRectangleBorder(
          borderRadius:
          new BorderRadius.circular(30.0),
        ),
      ),
      icon: Icon(
        icon,
        color: Colors.white,
        size: 24.sp,
      ),
      label: Text(
        text,
        style:
        TextStyle(color: CupertinoColors.white,fontSize: 18.sp),
      ),
      onPressed: () {
        onPressd();
      },
    );
  }
}
