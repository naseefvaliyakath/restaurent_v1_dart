import 'package:get/get.dart';
import 'package:restowrent_v_two/screens/add_food_screen/add_food_screen.dart';
import 'package:restowrent_v_two/screens/add_food_screen/binding/add_food_binding.dart';
import 'package:restowrent_v_two/screens/all_food_screen/all_food_screen.dart';
import 'package:restowrent_v_two/screens/all_food_screen/binding/all_food_binding.dart';
import 'package:restowrent_v_two/screens/dining_screen/binding/dining_billing_binding.dart';
import 'package:restowrent_v_two/screens/dining_screen/dining_billing_screen.dart';
import 'package:restowrent_v_two/screens/online_booking_billing_screen/onlinebooking_billing_screen.dart';
import 'package:restowrent_v_two/screens/order_view_screen/binding/order_view_binding.dart';
import 'package:restowrent_v_two/screens/order_view_screen/order_view%20_screen.dart';
import 'package:restowrent_v_two/screens/take_away_billing%20screen/take_away_billing%20screen.dart';
import 'package:restowrent_v_two/screens/update_food_screen/binding/update_food_binding.dart';
import 'package:restowrent_v_two/screens/update_food_screen/update_food_screen.dart';

import '../screens/home_delivery_screen/binding/home_delivery_binding.dart';
import '../screens/home_delivery_screen/home_delivery_screen.dart';
import '../screens/home_screen/binding/home_screen_binding.dart';
import '../screens/home_screen/home_screen.dart';
import '../screens/online_booking_billing_screen/binding/online_booking_binding.dart';
import '../screens/take_away_billing screen/binding/take_away_binding.dart';

class RouteHelper {
  static const String intial = '/';
  static const String addFoodScreen = '/add-food';
  static const String allFoodScreen = '/all-food';
  static const String updateFoodScreen = '/update-food';
  static const String takeAwayBillingScreen = '/take-away-screen';
  static const String homeDeliveryScreen = '/home-delivery-screen';
  static const String onlineBookingBillingScreen = '/online-booking-billing-screen';
  static const String diningBillingScreen = '/dining-billing-screen';
  static const String orderViewScreen = '/order-view-screen';


  static String getInitial() => intial;

  static String getAddFoodScreen() => addFoodScreen;

  static String getAllFoodScreen() => allFoodScreen;

  static String getUpdateFoodScreen() => updateFoodScreen;

  static String getTakeAwayBillingScreen() => takeAwayBillingScreen;

  static String getHomeDeliveryScreen() => homeDeliveryScreen;

  static String getOnlineBookingBillingScreen() => onlineBookingBillingScreen;

  static String getDiningBillingScreen() => diningBillingScreen;

  static String getOrderViewScreen() => orderViewScreen;

  static List<GetPage> routes = [
    GetPage(
      name: intial,
      page: () => HomeScreen(),
      binding: HomeBinding(),
        transitionDuration: const Duration(milliseconds: 400)
    ),
    GetPage(
      name: addFoodScreen,
      page: () => const AddFoodScreen(),
      binding: AddFoodBinding(),
        transitionDuration: const Duration(milliseconds: 400)

    ),
    GetPage(
      name: allFoodScreen,
      page: () => AllFoodScreen(),
      binding: AllFoodBinding(),
        transitionDuration: const Duration(milliseconds: 400)
    ),
    GetPage(
      name: updateFoodScreen,
      page: () => const UpdateFoodScreen(),
      binding: UpdateFoodBinding(),
      transitionDuration: const Duration(milliseconds: 400)
    ),

    GetPage(
        name: takeAwayBillingScreen,
        page: () => const TakeAwayBillingScreen(),
        binding: TakeAwayBinding(),
        transitionDuration: const Duration(milliseconds: 400)
    ),

    GetPage(
        name: homeDeliveryScreen,
        page: () => const HomeDeliveryScreen(),
        binding: HomeDeliveryBinding(),
        transitionDuration: const Duration(milliseconds: 400)
    ),

    GetPage(
        name: onlineBookingBillingScreen,
        page: () => const OnlineBookingBillingScreen(),
        binding: OnlineBookingBillingBinding(),
        transitionDuration: const Duration(milliseconds: 400)
    ),

    GetPage(
        name: diningBillingScreen,
        page: () => const DiningBillingScreen(),
        binding: DiningBillingBinding(),
        transitionDuration: const Duration(milliseconds: 400)
    ),

    GetPage(
        name: orderViewScreen,
        page: () =>  OrderViewScreen(),
        binding: OrderViewBinding(),
        transitionDuration: const Duration(milliseconds: 400)
    ),


  ];
}
