import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restowrent_v_two/app_constans/app_colors.dart';

class OrderCategory extends StatelessWidget {
  final Color color;
  final String text;
  final Color? circleColor;

  const OrderCategory(
      {Key? key,
      required this.color,
      required this.text,
         this.circleColor = AppColors.mainColor })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        height: 55.h,
        width: MediaQuery.of(context).size.width * 0.33,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(20.0.r),
                    child: Container(
                      height: 30.h,
                      width: 30.w,
                      color: circleColor,
                      child: Center(
                        child: Text(
                          'O',
                          style: TextStyle(color: Colors.white,
                            fontSize: 15.sp,),
                        ),
                      ),
                    )),
                6.horizontalSpace,
                Flexible(
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
