import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restowrent_v_two/app_constans/app_colors.dart';
import 'package:restowrent_v_two/widget/big_text.dart';

class Catogeries extends StatelessWidget {
  final Color color;
  final String text;

  const Catogeries({Key? key, required this.color, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: SizedBox(
        height: 60.h,
        width: MediaQuery.of(context).size.width * 0.33,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: Container(
                      color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                      width: 30.h,
                      height: 30.h,
                      child: Center(
                        child: BigText(
                          text: text[0],
                          size: 20.h,
                          color:Colors.white,
                        ),
                      ),
                    )),
                6.horizontalSpace,
                Flexible(
                  child: FittedBox(
                    child: Text(
                      text,
                      softWrap: false,
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: const Color(0xFF333333),
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.fade,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
