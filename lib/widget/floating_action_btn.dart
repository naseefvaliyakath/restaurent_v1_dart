import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restowrent_v_two/app_constans/app_colors.dart';

class FloatingActionBtn extends StatelessWidget {
  final IconData icon;
  final Function onTap;
  final Color color;
  const FloatingActionBtn({Key? key, required this.icon, required this.onTap, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {onTap();},
      style: ButtonStyle(
        elevation:MaterialStateProperty.all(20),
        shape: MaterialStateProperty.all(CircleBorder()),
        padding: MaterialStateProperty.all(EdgeInsets.all(20)),
        backgroundColor: MaterialStateProperty.all(color), // <-- Button color

      ),
      child: Icon(icon,size: 1.sw*0.06,color: Colors.white,),
    );
  }
}
