import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:restowrent_v_two/app_constans/app_colors.dart';

class FoodCard extends StatelessWidget {
  final String img;
  final String name;
  final String price;

  const FoodCard(
      {Key? key, required this.img, required this.name, required this.price})
      : super(key: key);

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
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(img),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
          Positioned(
              left: 1.sw / 34.25,

              /// 12.0
              bottom: 1.sh / 45.54,

              /// 15.0
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    softWrap: false,
                    style: TextStyle(
                      fontSize: 1.sh / 55.15,
                      color:  Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.fade,
                  ),
                  Text(price,
                      softWrap: false,
                      style: TextStyle(
                        fontSize: 1.sh / 49,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              )),
          Positioned(
              top: 1.sh / 68.3,

              /// 10.0
              right: 1.sw / 41.1,

              /// 10.0
              child:  Icon(FontAwesomeIcons.fire, color: Colors.white,size: 24.sp,))
        ],
      ),
    );
  }
}
