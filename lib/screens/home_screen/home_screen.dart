import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:restowrent_v_two/app_constans/app_colors.dart';
import 'package:restowrent_v_two/screens/dashbord_screen.dart';
import 'package:restowrent_v_two/screens/today_food_screen/controller/today_food_controller.dart';
import 'package:restowrent_v_two/screens/today_food_screen/today_food_screen.dart';
import '../../widget/snack_bar.dart';
import '../settings_page_screen/settings_page_screen.dart';





class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;
  List<Widget> pages = [

    const DashBordScreen(),
    const Center(child: Text('fourth screen')),
    const TodayFoodScreen(),
    const SettingsPageScreen(),
    const Center(child: Text('fivth screen')),
  ];

  @override
  void initState() {
    // TODO: implement initState
    Get.find<TodayFoodController>().getTodayFoods();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: getBody(),
        bottomNavigationBar: getFooter(),
        floatingActionButton: FloatingActionButton(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: () {
              AppSnackBar.errorSnackBar('Success', 'Data loaded');
              // selectedTab(4);
            },
            child:  Icon(
              Icons.add,
              size: 1.sw*0.06,
              color: Colors.white,
            ),
            backgroundColor: AppColors.mainColor
          //params
        ),
        floatingActionButtonLocation:
        FloatingActionButtonLocation.centerDocked);
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: pages,
    );
  }

  Widget getFooter() {
    List<IconData> iconItems = [
      Icons.home,
      Icons.stacked_bar_chart,
      Icons.fastfood,
      Icons.person_pin,
    ];

    return AnimatedBottomNavigationBar(
      activeColor: AppColors.mainColor,
      splashColor: Colors.red,
      inactiveColor: AppColors.mainColor_2,
      icons: iconItems,
      activeIndex: pageIndex,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.softEdge,
      leftCornerRadius: 10.r,
      iconSize: 25.sp,
      rightCornerRadius: 10.r,
      onTap: (index) {
        selectedTab(index);
      },
      //other params
    );
  }

  selectedTab(index) {
    setState(() {
      pageIndex = index;
    });
  }
}

