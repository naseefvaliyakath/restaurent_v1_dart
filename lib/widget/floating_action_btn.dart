import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restowrent_v_two/app_constans/app_colors.dart';

class FloatingActionBtn extends StatelessWidget {
  final IconData icon;
  final Function onTap;
  const FloatingActionBtn({Key? key, required this.icon, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {onTap();},
      child: Icon(icon,size: 1.sw*0.06,color: Colors.white,),
      style: ButtonStyle(
        shape: MaterialStateProperty.all(CircleBorder()),
        padding: MaterialStateProperty.all(EdgeInsets.all(20)),
        backgroundColor: MaterialStateProperty.all(AppColors.mainColor), // <-- Button color
        overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
          if (states.contains(MaterialState.pressed)) return Colors.red; // <-- Splash color
        }),
      ),
    );
  }
}
