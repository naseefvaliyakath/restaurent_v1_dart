import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_constans/app_colors.dart';

class KotItemTile extends StatelessWidget {
  final int index;
  final int slNumber;
  final String itemName;
  final int qnt;

  final String kitchenNote;


  const KotItemTile(
      {Key? key,
      required this.slNumber,
      required this.itemName,
      required this.qnt,
      required this.kitchenNote,
        this.index = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white),
      margin: EdgeInsets.only(bottom: 1.sp),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                slNumber.toString(),
                maxLines: 1,
                style: TextStyle(fontSize: 13.sp),
              ),
            ),
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Text(
                      itemName,
                      maxLines: 1,
                      //softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 13.sp),
                    ),
                    width: 200.w,
                  ),
                  Text(
                    kitchenNote,
                    maxLines: 1,
                    style: TextStyle(fontSize: 8.sp, color: Colors.black),
                  ),
                ],
              ),
            ),

            SizedBox(
              child: Text(
                qnt.toString(),
                maxLines: 1,
                style: TextStyle(fontSize: 13.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
