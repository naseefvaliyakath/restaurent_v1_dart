import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:restowrent_v_two/widget/settings_page_screen/profile_menu.dart';
import 'package:restowrent_v_two/widget/settings_page_screen/profile_pic.dart';
import '../../widget/app_alerts.dart';
import '../../widget/heading_rich_text.dart';

class SettingsPageScreen extends StatelessWidget {
  const SettingsPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //back arroow
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                       HeadingRichText(name: 'Settings'),
                    ],
                  ),
                ),
              ],
            ),

            10.verticalSpace,
            const ProfilePic(),
           20.verticalSpace,
            ProfileMenu(
              text: "My Account",
              icon: Icons.account_circle_rounded,
              press: () => {},
            ),
            ProfileMenu(
              text: "Notifications",
              icon: Icons.notification_add,
              press: () {},
            ),
            ProfileMenu(
              text: "Settings",
              icon: Icons.settings,
              press: () {},
            ),
            ProfileMenu(
              text: "Help Center",
              icon: Icons.help,
              press: () {},
            ),
            ProfileMenu(
              text: "Change mode",
              icon: Icons.mode_sharp,
              press: () {
                changeModeOfAppAlert(context: context);
              },
            ),
            ProfileMenu(
              text: "Log Out",
              icon: Icons.logout,
              press: () {},
            ),
          ],
        ),
      ),
    );
  }
}
