import 'package:get/get.dart';
import '../screens/home_screen/home_screen.dart';
import '../screens/home_screen/binding/home_screen_binding.dart';


class RouteHelper {
  static const String intial = '/';
  // static const String addTask = '/add-task';
  // static const String allTask = '/all-task';

  static String getInitial() => intial;

  // static String getaddTask() => addTask;
  //
  // static String getallTask() => allTask;

  static List<GetPage> routes = [
    GetPage(
      name: intial,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
/*    GetPage(
        name: addTask,
        page: () => AddTask(),
        binding: HomeBinding(),
        transition: Transition.fade,

    ),
    GetPage(
      name: allTask,
      page: () => AllTaskScreen(),
      binding: HomeBinding(),
    ),*/
  ];
}
