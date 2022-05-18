import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Catogeries extends StatelessWidget {
  final Color color;
  final String text;
  final String images;

  const Catogeries(
      {Key? key, required this.color, required this.text, required this.images})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        height: 60.h,
        width: MediaQuery.of(context).size.width * 0.33,
        child: Center(
          child: Padding(
            padding:  EdgeInsets.all(8.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset(
                      images,
                      height: 30.h,
                      width: 30.w,
                      fit: BoxFit.cover,
                    )),
                6.horizontalSpace,
                Flexible(
                  child: Text(

                    text,
                    softWrap: false,
                    style:  TextStyle(
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
