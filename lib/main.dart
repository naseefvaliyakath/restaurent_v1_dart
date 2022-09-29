import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:restowrent_v_two/hive_database/hive_init.dart';
import 'package:restowrent_v_two/routes/route_helper.dart';
import 'package:restowrent_v_two/screens/home_screen/binding/home_screen_binding.dart';
import 'package:restowrent_v_two/screens/home_screen/home_screen.dart';
import 'app_constans/app_colors.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MyHiveInit.initMyHive();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return ScreenUtilInit(
      designSize: const Size(411, 843),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demoo',
          theme: ThemeData(
            primaryColor: AppColors.mainColor,
            primarySwatch: Colors.amber,
          ),
          initialRoute: RouteHelper.getInitial(),
          initialBinding: HomeBinding(),
          unknownRoute: GetPage(name: '/notFount', page: () => HomeScreen()),
          defaultTransition: Transition.fade,
          getPages: RouteHelper.routes,
        );
      },
    );
  }
}
