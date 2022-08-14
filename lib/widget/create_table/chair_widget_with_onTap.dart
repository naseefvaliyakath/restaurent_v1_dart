import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restowrent_v_two/app_constans/app_colors.dart';

class ChairWidgetWithOnTap extends StatelessWidget {
  final String text;
  final Function onTap;
  final Color color;
  final Color borderColor;

  const ChairWidgetWithOnTap({
    Key? key,
    required this.text,
    required this.onTap,
    this.color = Colors.green,
     this.borderColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: FittedBox(
        child: InkWell(
          onTap: () async {
            await onTap();
            //print(kotId);
          },
          child: Container(
            padding: EdgeInsets.all(5.sp),
            margin: EdgeInsets.all(1.sp),
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(5.r),
                border: Border.all(width: 2.sp, color: borderColor)),
            child: Center(
                child: FittedBox(
                    child: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 8.sp),
            ))),
          ),
        ),
      ),
    );
  }
}
