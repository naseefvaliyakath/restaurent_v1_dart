import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'big_text.dart';

class TotelPriceTxt extends StatelessWidget {
  final double price;
  const TotelPriceTxt({Key? key, required this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        BigText(
          text: 'Totel : ',
          size: 18.sp,
        ),
        20.horizontalSpace,
        BigText(
          text: 'Rs $price',
          size: 18.sp,
          color: Colors.black54,
        )
      ],
    );
  }
}
