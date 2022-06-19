import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:restowrent_v_two/screens/create_table_screen/create_table_controller.dart';
import 'package:restowrent_v_two/widget/create_table/table_rectangle.dart';

import '../create_table/chair_widget.dart';


class TableChairWidget extends StatelessWidget {
  const TableChairWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 200.h,
      width: 210.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              offset: const Offset(4, 6),
              blurRadius: 4,
              color: Colors.black.withOpacity(0.3),
            )
          ],
          border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1.sp)),
      child: Container(
        padding: EdgeInsets.all(5.sp),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Stack(
          children: <Widget>[
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return GetBuilder<CreateTableController>(builder: (controller) {
                  return Stack(
                    children: [
                      //table
                      Center(
                        child: TableRectangle(
                          text: 'TABLE 1',
                          width: constraints.maxWidth - 100.w,
                          height: constraints.maxHeight - 100.h,
                        ),
                      ),

                      //left side
                      Positioned(
                        child: Container(
                          width: 40.w,
                          height: constraints.maxHeight - 100.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List<Widget>.generate(
                                controller.leftChairCount, (index) {
                              return ChairWidget(text: 'C $index');
                            }).toList(growable: true),
                          ),
                        ),
                        top: 50.h,
                      ),
                      //right side
                      Positioned(
                        child: Container(
                          width: 40.w,
                          height: constraints.maxHeight - 100.h,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List<Widget>.generate(
                                  controller.rightChairCount, (index) {
                                return ChairWidget(text: 'C $index');
                              }).toList(growable: true)),
                        ),
                        top: 50.h,
                        right: 0,
                      ),
                      //top side
                      Positioned(
                        child: Container(
                          width: constraints.maxWidth - 100.w,
                          height: 40.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [],
                          ),
                        ),
                        top: 0,
                        left: 50.w,
                      ),
                      //bottom side
                      Positioned(
                        child: Container(
                          width: constraints.maxWidth - 100.w,
                          height: 40.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [],
                          ),
                        ),
                        bottom: 0,
                        left: 50.w,
                      ),
                    ],
                  );
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
