import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../routes/route_helper.dart';

class CustomButtonTest extends StatefulWidget {
  const CustomButtonTest({Key? key}) : super(key: key);

  @override
  State<CustomButtonTest> createState() => _CustomButtonTestState();
}

class _CustomButtonTestState extends State<CustomButtonTest> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          focusColor: Colors.transparent,
          customButton:  Icon(
            Icons.list,
            size: 35.sp,
            color: Colors.black,
          ),
          customItemsIndexes: const [3],
          customItemsHeight: 8,
          items: [
            ...MenuItems.firstItems.map(
                  (item) =>
                  DropdownMenuItem<MenuItem>(
                    value: item,
                    child: MenuItems.buildItem(item),
                  ),
            ),
            const DropdownMenuItem<Divider>(enabled: false, child: Divider()),
            ...MenuItems.secondItems.map(
                  (item) =>
                  DropdownMenuItem<MenuItem>(
                    value: item,
                    child: MenuItems.buildItem(item),
                  ),
            ),
          ],
          onChanged: (value) {
            MenuItems.onChanged(context, value as MenuItem);
          },
          itemHeight: 48.sp,
          itemPadding:  EdgeInsets.only(left: 16.w, right: 16.w),
          dropdownWidth: 160.sp,
          dropdownPadding:  EdgeInsets.symmetric(vertical: 6.h),
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            color: Colors.white,
          ),
          dropdownElevation: 8,
          offset: const Offset(0, 8),
        ),
      ),
    );
  }
}

class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  static const List<MenuItem> firstItems = [home, share, settings];
  static const List<MenuItem> secondItems = [logout];

  static const home = MenuItem(text: 'Home', icon: Icons.home);
  static const share = MenuItem(text: 'Sound', icon: Icons.notifications);
  static const settings = MenuItem(text: 'Settings', icon: Icons.settings);
  static const logout = MenuItem(text: 'Log Out', icon: Icons.logout);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(
            item.icon,
            color: Colors.black,
            size: 22.sp
        ),
         SizedBox(
          width: 10.w,
        ),
        Text(
          item.text,
          style:  TextStyle(
            color: Colors.black,
            fontSize: 18.sp
          ),
        ),
      ],
    );
  }

  static onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.home:
      //Do something
        break;
      case MenuItems.settings:
      //Do something
        break;
      case MenuItems.share:
      //Do something
        break;
      case MenuItems.logout:
      Get.offAllNamed(RouteHelper.getInitial());
        break;
    }
  }
}
