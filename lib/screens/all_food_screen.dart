import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:restowrent_v_two/widget/big_text.dart';
import '../app_constans/app_colors.dart';
import '../widget/food_card.dart';
import '../widget/two_button-bottom_sheet.dart';
import 'add_food_screen.dart';

class AllFoodScreen extends StatelessWidget {
  const AllFoodScreen({Key? key}) : super(key: key);

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
              snap: true,
              title: Text(
                'Your Foods ',
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
                      child:  Icon(FontAwesomeIcons.bell,size: 24.sp,)),
                ),
              ],
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(60.h),
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0.w, right: 10.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r)),
                          child: SizedBox(
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.0.w, vertical: 8.h),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.search,
                                      color: Colors.grey,
                                      size: 24.sp,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10.0.w),
                                      child: Text(
                                        "Search",
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0.w),
                        child: Container(
                            padding: EdgeInsets.all(8.sp),
                            decoration: BoxDecoration(
                              color: Color(0xFFF7F7F7),
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black87.withOpacity(0.1),
                                  spreadRadius: 1.sp,
                                  blurRadius: 1.r,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Center(
                                child: Icon(
                              Icons.sort,
                              size: 24.sp,
                            ))),
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
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
