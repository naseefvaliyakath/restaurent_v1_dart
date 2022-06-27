import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_constans/app_colors.dart';

class FoodSearchBar extends StatelessWidget {
  final Function onChanged;
  const FoodSearchBar({Key? key, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r)),
        child: SizedBox(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 8.0.w, vertical: 8.h),
              child:TextField(
                onChanged: (vale){
                  onChanged(vale);
                },

                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  icon:  Icon(Icons.search,size: 24.sp,color: AppColors.textGrey,),
                  border: InputBorder.none,
                  hintText: 'Search here ...',
                  hintStyle: TextStyle(color: AppColors.textGrey,fontSize: 16.sp),
                  isDense: true,                      // Added this
                  contentPadding: EdgeInsets.all(3),  // Added this
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
