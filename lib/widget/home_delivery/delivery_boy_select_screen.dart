import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restowrent_v_two/widget/big_text.dart';
import 'package:restowrent_v_two/widget/mid_text.dart';

import '../../app_constans/app_colors.dart';
import '../app_min_button.dart';
import '../horezondal_divider.dart';

class DeliveryBoySelectScreen extends StatelessWidget {
  const DeliveryBoySelectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
         HorezondalDivider(),
        10.verticalSpace,
        Wrap(
          direction: Axis.horizontal,
          spacing: 5.sp,
          runSpacing: 5.sp,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(4, 6),
                      blurRadius: 4,
                      color: Colors.black.withOpacity(0.3),
                    )
                  ],
                  border: Border.all(color: Colors.grey, width: 1.sp)),
              child: Container(
                width: 90.w,
                height: 90.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  children: [
                    Icon(Icons.person,size: 38.sp,color: AppColors.mainColor_2,),
                    BigText(text: 'BOY 1',size: 16.sp,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.phone,size: 10.sp,),
                        3.horizontalSpace,
                        MidText(text: '89434743',size: 10.sp,),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(4, 6),
                      blurRadius: 4,
                      color: Colors.black.withOpacity(0.3),
                    )
                  ],
                  border: Border.all(color: Colors.grey, width: 1.sp)),
              child: Container(
                width: 90.w,
                height: 90.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  children: [
                    Icon(Icons.person,size: 38.sp,color: AppColors.mainColor_2,),
                    BigText(text: 'BOY 2',size: 16.sp,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.phone,size: 10.sp,),
                        3.horizontalSpace,
                        MidText(text: '89434743',size: 10.sp,),
                      ],
                    )
                  ],
                ),
              ),
            ),
            //add new boy
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(4, 6),
                      blurRadius: 4,
                      color: Colors.black.withOpacity(0.3),
                    )
                  ],
                  border: Border.all(color: Colors.grey, width: 1.sp)),
              child: Container(
                width: 90.w,
                height: 90.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_circle,size: 38.sp,color: Colors.grey,),
                    BigText(text: 'Add',size: 16.sp,color:Colors.grey,),

                  ],
                ),
              ),
            ),

          ],
        ),
        10.verticalSpace,
        Flexible(
          child: AppMIniButton(
            bgColor:AppColors.mainColor, text: 'Submit And Print', onTap: (){},),

        ),
      ],
    );
  }
}
