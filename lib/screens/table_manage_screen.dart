import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:restowrent_v_two/widget/order_view_screen/order_category.dart';

import '../app_constans/app_colors.dart';
import '../widget/floating_action_btn.dart';
import '../widget/table_manage_screen/table_chair_widget_test.dart';
import 'create_table_screen/create_table_binding.dart';
import 'create_table_screen/create_table_screen.dart';


class TableManageScreen extends StatelessWidget {
  TableManageScreen({Key? key}) : super(key: key);

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
        child: CustomScrollView(
          primary: false,
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              pinned: true,
              leading:  IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: 24.sp,
                ),
                onPressed: () {
                  Get.back();
                },
                splashRadius: 24.sp,
              ),
              snap: true,
              title: Text(
                'Manage Table',
                overflow: TextOverflow.fade,
                softWrap: false,
              ),
              titleTextStyle: TextStyle(
                  fontSize: 26.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
              actions: [
                Badge(
                  badgeColor: Colors.red,
                  child: Container(
                      margin: EdgeInsets.only(right: 10.w),
                      child: Icon(
                        FontAwesomeIcons.bell,
                        size: 24.sp,
                      )),
                ),
              ],

              bottom: PreferredSize(
                preferredSize: Size.fromHeight(60.h),
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0.w, right: 10.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 55.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categoryCard.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return InkWell(
                              onTap: () {},
                              //category tile
                              child: OrderCategory(
                                color: tappedIndex == index
                                    ? AppColors.mainColor_2
                                    : Colors.white,
                                circleColor: categoryCard[index]['circleColor'],
                                text: categoryCard[index]['text'],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              backgroundColor: const Color(0xfffafafa),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverGrid.count(
                  childAspectRatio: 2 / 3,
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.sp,
                  mainAxisSpacing: 5.sp,
                  children: [
                    TableChairWidgetTest(),
                    TableChairWidgetTest(),
                    TableChairWidgetTest(),
                    TableChairWidgetTest(),
                    TableChairWidgetTest(),
                    TableChairWidgetTest(),

                  ]),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionBtn(
        onTap: () {
          Get.to(CreateTableScreen(), binding: CreateTableBinding());
        },
        icon: Icons.chair,
      ),
    );
  }
}
