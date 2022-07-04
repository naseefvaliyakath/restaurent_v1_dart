import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restowrent_v_two/app_constans/app_colors.dart';

class ErrOrderStatusCard extends StatelessWidget {



  const ErrOrderStatusCard(
      {Key? key,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              offset: const Offset(4, 6),
              blurRadius: 4,
              color: Colors.black.withOpacity(0.3),
            )
          ],
          border: Border.all(color: Colors.redAccent, width: 1.sp)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(3.sp),
            child: Center(
              child: Text(
                'Error',
                softWrap: false,
                style: TextStyle(
                  fontSize: 20.sp,
                  color: AppColors.mainColor,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.fade,
              ),
            )
          ),
        ),
      ),
    );
  }
}
