import 'package:get/get.dart';
import 'package:restowrent_v_two/screens/add_food_screen/add_food_screen.dart';
import 'package:restowrent_v_two/screens/add_food_screen/binding/add_food_binding.dart';
import 'package:restowrent_v_two/screens/all_food_screen/all_food_screen.dart';
import 'package:restowrent_v_two/screens/all_food_screen/binding/all_food_binding.dart';
import 'package:restowrent_v_two/screens/create_table_screen/create_table_screen.dart';
import 'package:restowrent_v_two/screens/dining_screen/binding/dining_billing_binding.dart';
import 'package:restowrent_v_two/screens/dining_screen/dining_billing_screen.dart';
import 'package:restowrent_v_two/screens/kitchen_mode/kitchen_mode_main/kitchen_mode_main_screen.dart';
import 'package:restowrent_v_two/screens/online_booking_billing_screen/onlinebooking_billing_screen.dart';
import 'package:restowrent_v_two/screens/order_view_screen/binding/order_view_binding.dart';
import 'package:restowrent_v_two/screens/order_view_screen/order_view%20_screen.dart';
import 'package:restowrent_v_two/screens/select_online_app_screen/select_onlie_app_screen.dart';
import 'package:restowrent_v_two/screens/table_manage_screen/table_manage_screen.dart';
import 'package:restowrent_v_two/screens/take_away_billing%20screen/take_away_billing%20screen.dart';
import 'package:restowrent_v_two/screens/update_food_screen/binding/update_food_binding.dart';
import 'package:restowrent_v_two/screens/update_food_screen/update_food_screen.dart';

import '../screens/create_table_screen/binding/create_table_binding.dart';
import '../screens/home_delivery_screen/binding/home_delivery_binding.dart';
import '../screens/home_delivery_screen/home_delivery_screen.dart';
import '../screens/home_screen/binding/home_screen_binding.dart';
import '../screens/home_screen/home_screen.dart';
import '../screens/kitchen_mode/kitchen_mode_main/binding/kitchen_mode_main_binding.dart';
import '../screens/online_booking_billing_screen/binding/online_booking_binding.dart';
import '../screens/select_online_app_screen/binding/online_booking_binding.dart';
import '../screens/table_manage_screen/binding/table_manage_binding.dart';
import '../screens/take_away_billing screen/binding/take_away_binding.dart';

class RouteHelper {
  static const String intial = '/';
  static const String addFoodScreen = '/add-food';
  static const String allFoodScreen = '/all-food';
  static const String updateFoodScreen = '/update-food';
  static const String takeAwayBillingScreen = '/take-away-screen';
  static const String homeDeliveryScreen = '/home-delivery-screen';
  static const String onlineAppSelectScreen = '/online-app-select-screen';
  static const String onlineBookingBillingScreen = '/online-booking-billing-screen';
  static const String diningBillingScreen = '/dining-billing-screen';
  static const String orderViewScreen = '/order-view-screen';
  static const String tableManageScreen = '/table-manage-screen';
  static const String createTableScreen = '/create-table-screen';
  static const String kitchenModeMainScreen = '/kitchen-mode-main-screen';

  static String getInitial() => intial;

  static String getAddFoodScreen() => addFoodScreen;

  static String getAllFoodScreen() => allFoodScreen;

  static String getUpdateFoodScreen() => updateFoodScreen;

  static String getTakeAwayBillingScreen() => takeAwayBillingScreen;

  static String getHomeDeliveryScreen() => homeDeliveryScreen;

  static String getOnlineAppSelectScreen() => onlineAppSelectScreen;

  static String getOnlineBookingBillingScreen() => onlineBookingBillingScreen;

  static String getDiningBillingScreen() => diningBillingScreen;

  static String getOrderViewScreen() => orderViewScreen;

  static String getTableManageScreen() => tableManageScreen;

  static String getCreateTableScreen() => createTableScreen;

  static String getKitchenModeMainScreen() => kitchenModeMainScreen;

  static List<GetPage> routes = [
    GetPage(
        name: intial, page: () => HomeScreen(), binding: HomeBinding(), transitionDuration: const Duration(milliseconds: 400)),
    GetPage(
        name: addFoodScreen,
        page: () => const AddFoodScreen(),
        binding: AddFoodBinding(),
        transitionDuration: const Duration(milliseconds: 400)),
    GetPage(
        name: allFoodScreen,
        page: () => AllFoodScreen(),
        binding: AllFoodBinding(),
        transitionDuration: const Duration(milliseconds: 400)),
    GetPage(
        name: updateFoodScreen,
        page: () => const UpdateFoodScreen(),
        binding: UpdateFoodBinding(),
        transitionDuration: const Duration(milliseconds: 400)),
    GetPage(
        name: takeAwayBillingScreen,
        page: () => const TakeAwayBillingScreen(),
        binding: TakeAwayBinding(),
        transitionDuration: const Duration(milliseconds: 400)),
    GetPage(
        name: homeDeliveryScreen,
        page: () => const HomeDeliveryScreen(),
        binding: HomeDeliveryBinding(),
        transitionDuration: const Duration(milliseconds: 400)),
    GetPage(
        name: onlineAppSelectScreen,
        page: () => const SelectOnlineAppScreen(),
        binding: SelectOnlineAppBinding(),
        transitionDuration: const Duration(milliseconds: 400)),
    GetPage(
        name: onlineBookingBillingScreen,
        page: () => const OnlineBookingBillingScreen(),
        binding: OnlineBookingBillingBinding(),
        transitionDuration: const Duration(milliseconds: 400)),
    GetPage(
        name: diningBillingScreen,
        page: () => const DiningBillingScreen(),
        binding: DiningBillingBinding(),
        transitionDuration: const Duration(milliseconds: 400)),
    GetPage(
        name: orderViewScreen,
        page: () => OrderViewScreen(),
        binding: OrderViewBinding(),
        transitionDuration: const Duration(milliseconds: 400)),
    GetPage(
        name: tableManageScreen,
        page: () => TableManageScreen(),
        binding: TableManageBinding(),
        transitionDuration: const Duration(milliseconds: 400)),
    GetPage(
        name: createTableScreen,
        page: () => CreateTableScreen(),
        binding: CreateTableBinding(),
        transitionDuration: const Duration(milliseconds: 400)),

    GetPage(
        name: kitchenModeMainScreen,
        page: () => KitchenModeMainScreen(),
        binding: KitchenModeMainBinding(),
        transitionDuration: const Duration(milliseconds: 400)),


  ];
}
