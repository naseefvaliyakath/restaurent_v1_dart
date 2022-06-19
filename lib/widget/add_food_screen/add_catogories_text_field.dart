import 'dart:math';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restowrent_v_two/app_constans/app_colors.dart';
import 'package:restowrent_v_two/widget/big_text.dart';

class AddCatogeriesTextField extends StatelessWidget {
  final Function onTapAdd;
  final Function onTapBack;


  const AddCatogeriesTextField({Key? key, required this.onTapAdd, required this.onTapBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      child: SizedBox(
        height: 60.h,
        width: MediaQuery.of(context).size.width * 0.39,
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                onTap: ()=>onTapBack(),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        color: Colors.white,
                        width: 30.h,
                        height: 30.h,
                        child: Center(
                          child: Icon(Icons.arrow_back_outlined),
                        ),
                      )),
                ),
                Flexible(
                  child: TextField(
                    controller: TextEditingController(),
                    maxLines: 1,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Name',
                      hintStyle:  TextStyle(color: AppColors.textGrey,fontSize:14.sp,),
                      filled: true,
                      isDense: true,
                      fillColor: AppColors.textHolder,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(color: Colors.white, width: 1.sp)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(color: Colors.white, width: 1.sp)),
                    ),
                  ),
                ),

                //onTap for add category
                InkWell(
                  onTap: ()=>onTapAdd(),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        color: Colors.white,
                        width: 30.h,
                        height: 30.h,
                        child: Center(
                          child: Icon(Icons.add),
                        ),
                      )),
                ),

                6.horizontalSpace,

              ],
            ),
          ),
        ),
      ),
    );
  }
}
