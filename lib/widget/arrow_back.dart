import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ArrowBack extends StatelessWidget {
  const ArrowBack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 1.sh/19.51,
        width: 1.sw/10.28,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.25),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: IconButton(
          onPressed: (){Navigator.pop(context);},
          icon : Icon(Icons.arrow_back),
          color: Colors.white,
        )
    );
  }
}
