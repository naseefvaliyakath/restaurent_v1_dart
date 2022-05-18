import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:restowrent_v_two/screens/add_food_screen.dart';
import 'package:restowrent_v_two/screens/all_food_screen.dart';
import 'package:restowrent_v_two/screens/today_food_screen/controller/today_food_controller.dart';
import 'package:restowrent_v_two/widget/two_button-bottom_sheet.dart';
import '../../app_constans/app_colors.dart';
import '../../widget/food_card.dart';
import '../../widget/scroll_to_hide_widget.dart';

class TodayFoodScreen extends StatefulWidget {
  const TodayFoodScreen({Key? key}) : super(key: key);

  @override
  State<TodayFoodScreen> createState() => _TodayFoodScreenState();
}

class _TodayFoodScreenState extends State<TodayFoodScreen> {
  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<TodayFoodController>();
    return Obx(() {
      return ctrl.isLoading.value ? Center(child: CircularProgressIndicator()) : SafeArea(
        child: CustomScrollView(
          primary: false,
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              snap: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //heading
                  Flexible(
                    child: FittedBox(
                      child: RichText(
                        softWrap: false,
                        text: TextSpan(children: [
                          TextSpan(
                              text: "Today Food",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28.sp,
                                  overflow: TextOverflow.fade,
                                  color: AppColors.textColor)),

                        ]),
                        maxLines: 1,
                      ),
                    ),
                  ),
                  //add food and all food icon icon
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(const AddFoodScreen(),
                              transition: Transition.cupertinoDialog,
                              duration: const Duration(milliseconds: 500));
                        },
                        child: Container(
                          padding: EdgeInsets.all(8.sp),
                          decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius: BorderRadius.circular(15.r),
                              border: Border.all(color: Colors.white)),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  FontAwesomeIcons.utensils,
                                  size: 16.sp,
                                  color: Colors.white,
                                ),
                                3.verticalSpace,
                                Flexible(
                                    child: Text(
                                      'Add food',
                                      style: TextStyle(
                                          fontSize: 8.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.fade,
                                      maxLines: 1,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                      10.horizontalSpace,
                      InkWell(
                        onTap: () {
                          Get.to(const AllFoodScreen(),
                              transition: Transition.cupertinoDialog,
                              duration: const Duration(milliseconds: 500));
                        },
                        child: Container(
                          padding: EdgeInsets.all(8.sp),
                          decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius: BorderRadius.circular(15.r),
                              border: Border.all(color: Colors.white)),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  FontAwesomeIcons.borderAll,
                                  size: 16.sp,
                                  color: Colors.white,
                                ),
                                3.verticalSpace,
                                Flexible(
                                    child: Text(
                                      'All food',
                                      style: TextStyle(
                                          fontSize: 8.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.fade,
                                      maxLines: 1,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              backgroundColor: const Color(0xfffafafa),
            ),
            SliverPadding(
              padding: EdgeInsets.all(20.sp),
              sliver: SliverGrid.count(
                  childAspectRatio: 2 / 2.8,

                  crossAxisCount: 2,
                  crossAxisSpacing: 18.sp,
                  mainAxisSpacing: 18.sp,
                  children: [
                    InkWell(
                      onTap: () {
                        TwoBtnBottomSheet.bottomSheet(
                            b1Name: 'Remove From Today Food',
                            b2Name: 'Edit Food',
                            b1Function: () {},
                            b2Function: () {});
                      },
                      child: FoodCard(
                        img: 'assets/image/food/ChickenCurryPasta.jpg',
                        name: 'Chicken CurryPasta',
                        price: 'Rs : 250',
                      ),
                    ),
                    FoodCard(
                      img: 'assets/image/food/ExplosionBurger.jpg',
                      name: 'Explosion Burger',
                      price: 'Rs : 350',
                    ),
                    FoodCard(
                      img: 'assets/image/food/GrilledChicken.jpg',
                      name: 'Grilled Chicken',
                      price: 'Rs : 500',
                    ),
                    FoodCard(
                      img: 'assets/image/food/GrilledFish.jpg',
                      name: 'Grilled Fish',
                      price: 'Rs : 1200',
                    ),
                    FoodCard(
                      img: 'assets/image/food/HeavenlyPizza.jpg',
                      name: 'Heavenly Pizza',
                      price: 'Rs : 950',
                    ),
                    FoodCard(
                      img: 'assets/image/food/MandarinPancake.jpg',
                      name: 'Mandarin Pancake',
                      price: 'Rs : 10',
                    ),
                    FoodCard(
                      img: 'assets/image/food/OrganicMandarin.jpg',
                      name: 'Organic Mandarin',
                      price: 'Rs : 260',
                    ),
                    FoodCard(
                      img: 'assets/image/food/OrganicOrange.jpg',
                      name: 'Organic Orange',
                      price: 'Rs : 3000',
                    ),
                    FoodCard(
                      img: 'assets/image/food/RaspberriesCake.jpg',
                      name: 'Raspberries Cake',
                      price: 'Rs : 500',
                    ),
                    FoodCard(
                      img: 'assets/image/food/OrganicMandarin.jpg',
                      name: 'Organic Mandarin',
                      price: 'Rs : 250',
                    ),
                  ]
              ),
            ),
          ],
        ),
      );
    });
  }
}
