import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:restowrent_v_two/routes/route_helper.dart';
import 'package:restowrent_v_two/screens/create_table_screen/controller/create_table_controller.dart';

import 'package:restowrent_v_two/widget/big_text.dart';
import 'package:restowrent_v_two/widget/white_button_with_icon.dart';

import '../../app_constans/app_colors.dart';
import '../../widget/create_table/table_chair_widget/circle_table_chair_widget.dart';
import '../../widget/create_table/table_chair_widget/ovel_table_chair_widget.dart';
import '../../widget/create_table/table_chair_widget/rectangle_table_chair_widget.dart';
import '../../widget/create_table/table_chair_widget/squre_table_chair_widget.dart';
import '../../widget/create_table/table_shape_drop_down.dart';
import '../../widget/heading_rich_text.dart';
import '../../widget/horezondal_divider.dart';
import '../../widget/notification_icon.dart';
import '../../widget/progress_button.dart';

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
    return WillPopScope(
      onWillPop: () async{
        Get.offNamed(RouteHelper.getTableManageScreen());
        return true;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: GetBuilder<CreateTableController>(builder: (ctrl) {
            return SafeArea(
              child: SizedBox(
                width: double.maxFinite,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // heading
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //back arrow
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                size: 24.sp,
                              ),
                              onPressed: () {
                               Get.offNamed(RouteHelper.getTableManageScreen());
                              },
                              splashRadius: 24.sp,
                            ),
                            // heading my restawrent
                            const HeadingRichText(name: 'Create your table'),
                            //notification
                            const NotificationIcon(),
                          ],
                        ),
                      ),
                      10.verticalSpace,
                      SizedBox(
                        child: ctrl.tableShape == '1'
                            ? const RectangleTableChairWidget()
                            : ctrl.tableShape == '2'
                                ? const SquareTableChairWidget()
                                : ctrl.tableShape == '3'
                                    ? const CircleTableChairWidget()
                                    : ctrl.tableShape == '4'
                                        ? const OvalTableChairWidget()
                                        : const RectangleTableChairWidget(),
                      ),
                      SizedBox(
                        height: 1.sh * 0.03,
                      ),
                      5.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          WhiteButtonWithIcon(text: 'Enter Table Name', icon: Icons.edit, onTap: () {}),
                          const TableShapeDropDown(),
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                  ctrl.removeLeftChair();
                                },
                              ),
                              5.horizontalSpace,
                              BigText(
                                text: '${ctrl.leftChairCount}',
                                size: 20.w,
                                color: AppColors.titleColor,
                              ),
                              5.horizontalSpace,
                              IconButton(
                                icon: Icon(Icons.add_circle),
                                color: Colors.black54,
                                iconSize: 35.sp,
                                onPressed: () {
                                  ctrl.addLeftChair();
                                },
                              ),
                            ],
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                  ctrl.removeRightChair();
                                },
                              ),
                              5.horizontalSpace,
                              BigText(
                                text: '${ctrl.rightChairCount}',
                                size: 20.w,
                                color: AppColors.titleColor,
                              ),
                              5.horizontalSpace,
                              IconButton(
                                icon: Icon(Icons.add_circle),
                                color: Colors.black54,
                                iconSize: 35.sp,
                                onPressed: () {
                                  ctrl.addRightChair();
                                },
                              ),
                            ],
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 100.w,
                                child: BigText(
                                  text: 'Top Chair :',
                                  size: 15.sp,
                                ),
                              ),
                              10.horizontalSpace,
                              IconButton(
                                icon: Icon(Icons.remove_circle),
                                color: Colors.black54,
                                iconSize: 35.sp,
                                onPressed: () {
                                  ctrl.removeTopChair();
                                },
                              ),
                              5.horizontalSpace,
                              BigText(
                                text: ctrl.topChairCount.toString(),
                                size: 20.w,
                                color: AppColors.titleColor,
                              ),
                              5.horizontalSpace,
                              IconButton(
                                icon: Icon(Icons.add_circle),
                                color: Colors.black54,
                                iconSize: 35.sp,
                                onPressed: () {
                                  ctrl.addTopChair();
                                },
                              ),
                            ],
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 100.w,
                                child: BigText(
                                  text: 'Bottom Chair :',
                                  size: 15.sp,
                                ),
                              ),
                              10.horizontalSpace,
                              IconButton(
                                icon: Icon(Icons.remove_circle),
                                color: Colors.black54,
                                iconSize: 35.sp,
                                onPressed: () {
                                  ctrl.removeBottomChair();
                                },
                              ),
                              5.horizontalSpace,
                              BigText(
                                text: ctrl.bottomChairCount.toString(),
                                size: 20.w,
                                color: AppColors.titleColor,
                              ),
                              5.horizontalSpace,
                              IconButton(
                                icon: Icon(Icons.add_circle),
                                color: Colors.black54,
                                iconSize: 35.sp,
                                onPressed: () {
                                  ctrl.addBottomChair();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      5.verticalSpace,
                      SizedBox(
                        width: 1.sw * 0.4,
                        child: Row(
                          children: [
                           /* Expanded(
                                child: AppMIniButton(
                              text: 'Add Table',
                              bgColor: AppColors.mainColor,
                              onTap: () {
                                ctrl.insertTable();
                              },
                            )),*/
                            Expanded(
                                child: ProgressButton(
                                  btnCtrlName: 'createTable',
                                  text: 'Create Table',
                                  ctrl: ctrl,
                                  color: Color(0xfff25f27),
                                  onTap: () async {
                                    await ctrl.insertTable();
                                  },
                                ),),
                          ],
                        ),
                      )
                    ],
                  )

              ),
            );
          }),
        ),
      ),
    );
  }
}
