import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:restowrent_v_two/app_constans/app_colors.dart';

class TakeAwayFoodCard extends StatelessWidget {
  final String img;
  final String name;
  final String price;

  const TakeAwayFoodCard(
      {Key? key, required this.img, required this.name, required this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.sp),
      width: 0.23.sw,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(img),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFe8e8e8),
              blurRadius: 5.0,
              offset: Offset(0, 5),
            ),
            BoxShadow(
              color: Color(0xFFfafafa),
              offset: Offset(-5, 0),
            ),
            BoxShadow(
              color: Color(0xFFfafafa),
              offset: Offset(5, 0),
            ),
          ]
      ),
      child: Padding(
        padding:  EdgeInsets.all(3.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.black54,
              padding: EdgeInsets.symmetric(horizontal: 2.sp),
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 1.sh / 85.15,
                  color:  Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: false,
              ),
            ),
            Container(
              color: Colors.black54,
              padding: EdgeInsets.symmetric(horizontal: 5.sp),
              child: Text(price,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 1.sh / 59,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
