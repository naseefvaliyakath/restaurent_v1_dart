import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restowrent_v_two/widget/big_text.dart';

class OnlineAppCard extends StatelessWidget {
  final String text;
  final String img;
   const OnlineAppCard({Key? key, required this.text, required this.img}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(20.r), boxShadow: [
        BoxShadow(
          offset: const Offset(4, 6),
          blurRadius: 4,
          color: Colors.black.withOpacity(0.3),
        )
      ]),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.only(top: 10.h),
                width: 1.sw * 0.3,
                child: ClipRRect(
                  child: Image.asset(img),
                  borderRadius:  BorderRadius.all(Radius.circular(20.r)),
                ),
              ),
              10.verticalSpace,
              BigText(text: text,color: Colors.grey,)
            ],
          ),
        ),
      ),
    );
  }
}
