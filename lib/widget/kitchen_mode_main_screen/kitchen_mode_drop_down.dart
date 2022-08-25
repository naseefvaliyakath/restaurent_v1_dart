import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../routes/route_helper.dart';


class KitchenModeDropDown extends StatelessWidget {
  const KitchenModeDropDown({Key? key}) : super(key: key);

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
          customItemsIndexes: const [4],
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
          itemPadding:  EdgeInsets.only(left: 16.sp, right: 16.sp),
          dropdownWidth: 160.sp,
          dropdownPadding:  EdgeInsets.symmetric(vertical: 6.sp),
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
  static const List<MenuItem> firstItems = [home,ring, soundOnOff, settings];
  static const List<MenuItem> secondItems = [logout];

  static const home = MenuItem(text: 'Home', icon: Icons.home);
  static const ring = MenuItem(text: 'Ring', icon: Icons.ring_volume);
  static const soundOnOff = MenuItem(text: 'Sound', icon: Icons.vibration);
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
          width: 10.sp
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
      case MenuItems.soundOnOff:
      //Do something
        break;
      case MenuItems.logout:
        Get.offAllNamed(RouteHelper.getInitial());
        break;
    }
  }
}
