import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:restowrent_v_two/widget/app_min_button.dart';
import 'package:restowrent_v_two/widget/big_text.dart';
import 'package:restowrent_v_two/widget/white_button_with_icon.dart';

import '../../app_constans/app_colors.dart';
import '../../widget/create_table/table_shape_drop_down.dart';
import '../../widget/heading_rich_text.dart';
import '../../widget/horezondal_divider.dart';
import '../../widget/notification_icon.dart';
import '../../widget/table_manage_screen/table_chair_widget.dart';
import 'create_table_controller.dart';

class CreateTableScreen extends StatelessWidget {
  CreateTableScreen({Key? key}) : super(key: key);

  int tappedIndex = 0;
  CrossFadeState state = CrossFadeState.showFirst;
  List categoryCard = [
    {'text': "Main", 'circleColor': Colors.redAccent},
    {'text': "Family Room", 'circleColor': Colors.green},
    {'text': "1st Floor", 'circleColor': Colors.blueAccent},
    {'text': "Out Side", 'circleColor': Colors.yellowAccent},
    {'text': "Room 2", 'circleColor': Colors.pink},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.maxFinite,
          height: 1.sh,
          child: GetBuilder<CreateTableController>(
            builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // heading
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // heading my restawrent
                        const HeadingRichText(name: 'Create your table'),
                        //notification
                        const NotificationIcon(),
                      ],
                    ),
                  ),
                  10.verticalSpace,
                  SizedBox(height: 1.sh * 0.4, child: TableChairWidget()),
                  SizedBox(
                    height: 1.sh * 0.03,
                  ),
                  5.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      WhiteButtonWithIcon(
                          text: 'Enter Table Name', icon: Icons.edit, onTap: () {}),
                      TableShapeDropDown(),
                    ],
                  ),
                  5.verticalSpace,
                  HorezondalDivider(),
                  //left chair
                  5.verticalSpace,
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15.w),
                    height: 55.h,
                    child: Card(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 100.w,
                            child: BigText(
                              text: 'Left Chair :',
                              size: 15.sp,
                            ),
                          ),
                          10.horizontalSpace,
                          IconButton(
                            icon: Icon(Icons.remove_circle),
                            color: Colors.black54,
                            iconSize: 35.sp,
                            onPressed: () {
                              controller.removeLeftChair();
                            },
                          ),
                          5.horizontalSpace,
                          BigText(
                            text: '${controller.leftChairCount}',
                            size: 20.w,
                            color: AppColors.titleColor,
                          ),
                          5.horizontalSpace,
                          IconButton(
                            icon: Icon(Icons.add_circle),
                            color: Colors.black54,
                            iconSize: 35.sp,
                            onPressed: () {
                              controller.addLeftChair();
                            },
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      ),
                    ),
                  ),
                  //right chair
                  5.verticalSpace,
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15.w),
                    height: 55.h,
                    child: Card(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 100.w,
                            child: BigText(
                              text: 'Right Chair :',
                              size: 15.sp,
                            ),
                          ),
                          10.horizontalSpace,
                          IconButton(
                            icon: Icon(Icons.remove_circle),
                            color: Colors.black54,
                            iconSize: 35.sp,
                            onPressed: () {
                              controller.removeRightChair();
                            },
                          ),
                          5.horizontalSpace,
                          BigText(
                            text: '${controller.rightChairCount}',
                            size: 20.w,
                            color: AppColors.titleColor,
                          ),
                          5.horizontalSpace,
                          IconButton(
                            icon: Icon(Icons.add_circle),
                            color: Colors.black54,
                            iconSize: 35.sp,
                            onPressed: () {
                              controller.addRightChair();
                            },
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      ),
                    ),
                  ),
                  //top chair
                  5.verticalSpace,
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15.w),
                    height: 55.h,
                    child: Card(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 100.w,
                            child: BigText(
                              text: 'Frond Chair :',
                              size: 15.sp,
                            ),
                          ),
                          10.horizontalSpace,
                          IconButton(
                            icon: Icon(Icons.remove_circle),
                            color: Colors.black54,
                            iconSize: 35.sp,
                            onPressed: () {
                              controller.removeRightChair();
                            },
                          ),
                          5.horizontalSpace,
                          BigText(
                            text: '0',
                            size: 20.w,
                            color: AppColors.titleColor,
                          ),
                          5.horizontalSpace,
                          IconButton(
                            icon: Icon(Icons.add_circle),
                            color: Colors.black54,
                            iconSize: 35.sp,
                            onPressed: () {
                              controller.addRightChair();
                            },
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      ),
                    ),
                  ),
                  //bottomchair
                  5.verticalSpace,
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15.w),
                    height: 55.h,
                    child: Card(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 100.w,
                            child: BigText(
                              text: 'Back Chair :',
                              size: 15.sp,
                            ),
                          ),
                          10.horizontalSpace,
                          IconButton(
                            icon: Icon(Icons.remove_circle),
                            color: Colors.black54,
                            iconSize: 35.sp,
                            onPressed: () {
                              controller.removeRightChair();
                            },
                          ),
                          5.horizontalSpace,
                          BigText(
                            text: '0',
                            size: 20.w,
                            color: AppColors.titleColor,
                          ),
                          5.horizontalSpace,
                          IconButton(
                            icon: Icon(Icons.add_circle),
                            color: Colors.black54,
                            iconSize: 35.sp,
                            onPressed: () {
                              controller.addRightChair();
                            },
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      ),
                    ),
                  ),
                  5.verticalSpace,
                  SizedBox(
                    width: 1.sw * 0.4,
                    child: Row(
                      children: [
                        Expanded(
                            child: AppMIniButton(
                          text: 'Add Table',
                          bgColor: AppColors.mainColor,
                          onTap: () {},
                        )),
                      ],
                    ),
                  )
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}
