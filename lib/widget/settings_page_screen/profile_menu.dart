import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app_constans/app_colors.dart';


class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final Function press;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: AppColors.mainColor,
          padding: EdgeInsets.all(20.sp),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
          backgroundColor: const Color(0xFFF5F6F9),
        ),
        onPressed: (){
          press();
        },
        child: Row(
          children: [
            Icon(icon,size: 24.sp,),
            20.horizontalSpace,
            Expanded(child: Text(text,style:TextStyle(fontSize: 16.sp)),),
            Icon(Icons.arrow_forward_ios,size: 16.sp,),
          ],
        ),
      ),
    );
  }
}