import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:restowrent_v_two/screens/order_view%20_screen.dart';
import 'package:restowrent_v_two/screens/sliver_check.dart';
import 'package:restowrent_v_two/widget/take_away_screen/take_away_food_card.dart';
import 'package:restowrent_v_two/widget/text_field_widget.dart';
import '../app_constans/app_colors.dart';
import '../widget/app_alerts.dart';
import '../widget/app_min_button.dart';
import '../widget/big_text.dart';
import '../widget/dialog_button.dart';
import '../widget/take_away_screen/billing_item_tile.dart';
import '../widget/take_away_screen/billing_table_heading.dart';
import '../widget/take_away_screen/category_drop_down.dart';
import '../widget/mid_text.dart';
import '../widget/order_settile_screen/order_settil_screen.dart';
import '../widget/white_button_with_icon.dart';

enum ButtonState { init, loading, done }

class OnlineBookingBillingScreen extends StatefulWidget {
  const OnlineBookingBillingScreen({Key? key}) : super(key: key);

  @override
  State<OnlineBookingBillingScreen> createState() =>
      _OnlineBookingBillingScreenState();
}

class _OnlineBookingBillingScreenState
    extends State<OnlineBookingBillingScreen> {
  ButtonState state = ButtonState.init;
  bool isAnimating = true;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isStreched = isAnimating || state == ButtonState.init;
    final isDone = state == ButtonState.done;
    var food = [
      InkWell(
        onTap: () {
          foodBillingAlert(context);
        },
        child: TakeAwayFoodCard(
          img: 'assets/image/food/ExplosionBurger.jpg',
          name: 'Explosion Burger',
          price: 'Rs : 350',
        ),
      ),
      TakeAwayFoodCard(
        img: 'assets/image/food/GrilledChicken.jpg',
        name: 'Grilled Chicken',
        price: 'Rs : 500',
      ),
      TakeAwayFoodCard(
        img: 'assets/image/food/GrilledFish.jpg',
        name: 'Grilled Fish',
        price: 'Rs : 1200',
      ),
      TakeAwayFoodCard(
        img: 'assets/image/food/HeavenlyPizza.jpg',
        name: 'Heavenly Pizza',
        price: 'Rs : 950',
      ),
      TakeAwayFoodCard(
        img: 'assets/image/food/MandarinPancake.jpg',
        name: 'Mandarin Pancake',
        price: 'Rs : 10',
      ),
      TakeAwayFoodCard(
        img: 'assets/image/food/OrganicMandarin.jpg',
        name: 'Organic Mandarin',
        price: 'Rs : 260',
      ),
      TakeAwayFoodCard(
        img: 'assets/image/food/OrganicOrange.jpg',
        name: 'Organic Orange',
        price: 'Rs : 3000',
      ),
    ];

    Widget elevatedButton(color, text) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color,
          textStyle: TextStyle(
            fontSize: 20.sp,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        ),
        onPressed: () async {
          setState(() => state = ButtonState.loading);
          await Future.delayed(const Duration(milliseconds: 2000));
          setState(() => state = ButtonState.done);
          await Future.delayed(const Duration(milliseconds: 2000));
          setState(() => state = ButtonState.init);
        },
        child: FittedBox(
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    Widget buildSmallButton(bool isDone) {
      const color = Colors.green;
      return Container(
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        child: isDone
            ? Icon(
                Icons.done,
                size: 30.sp,
                color: Colors.white,
              )
            : Center(
                child: SizedBox(
                    width: 30.w,
                    height: 30.h,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ))),
      );
    }

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          height: 1.sh,
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.verticalSpace,
              //back arroow and heading and notification
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //back arroow and heading
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.arrow_back,
                          size: 24.sp,
                        ),
                        15.horizontalSpace,
                        Flexible(
                          child: FittedBox(
                            child: RichText(
                              softWrap: false,
                              text: TextSpan(children: [
                                TextSpan(
                                    text: "Online Apps billing",
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
                      ],
                    ),
                  ),

                  //notification icon
                  Container(
                    padding: EdgeInsets.all(8.sp),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(color: Colors.grey)),
                    child: Center(
                      child: Badge(
                        badgeColor: Colors.red,
                        child: Icon(
                          FontAwesomeIcons.bell,
                          size: 24.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // serch and category
              Row(
                children: [
                  //search bar
                  Flexible(
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r)),
                      child: SizedBox(
                        height: 0.05.sh,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.0.w, vertical: 8.h),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  size: 24.sp,
                                  color: Colors.grey,
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
                  //category
                  CategoryDropDown()
                ],
              ),
              // show foods
              Container(
                  width: double.maxFinite,
                  height: 0.18.sh,
                  padding: EdgeInsets.all(5.sp),
                  //height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return food[index];
                    },
                    itemCount: 7,
                  )),
              //Items Orderd title
              //table
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 0.04.sh,
                    child: Center(
                      child: BigText(
                        text: 'Items Orderd ',
                        size: 15.sp,
                      ),
                    ),
                  ),
                  10.horizontalSpace,
                  WhiteButtonWithIcon(
                    text: 'Enter Order ID',
                    icon: Icons.edit,
                    onTap: () => addOrderIdAlert(context),
                  )
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.mainColor),
                    borderRadius: BorderRadius.circular(5.r)),
                padding: EdgeInsets.all(3.sp),
                width: double.maxFinite,
                height: 0.52.sh,
                child: Column(
                  children: [
                    // table hedings
                    BillingTableHeading(),
                    6.verticalSpace,
                    Container(
                      height: 0.45.sh,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return BillingItemTile(
                            slNumber: index + 1,
                            itemName: 'Checken biriyani',
                            qnt: 5,
                            kitchenNote: '',
                            price: 250,
                            onLongTap: () {
                              deleteItemFromBillAlert(context);
                            },
                          );
                        },
                        itemCount: 10,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  height: 0.04.sh,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BigText(
                        text: 'Totel : ',
                        size: 18.sp,
                      ),
                      20.horizontalSpace,
                      BigText(
                        text: 'Rs 235',
                        size: 18.sp,
                        color: Colors.black54,
                      )
                    ],
                  )),
              // controlle buttons
              Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 3.h),
                  height: 0.05.sh,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: AnimatedContainer(
                          // width: state == ButtonState.init ? 150.w : 45.w,
                          width: 150.w,
                          height: 40,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                          onEnd: () =>
                              setState(() => isAnimating = !isAnimating),
                          child: isStreched
                              ? elevatedButton(Color(0xff4caf50), 'Order')
                              : buildSmallButton(isDone),
                        ),
                      ),
                      3.horizontalSpace,
                      Flexible(
                        child: AppMIniButton(
                          bgColor: Color(0xffee588f),
                          text: 'Deliver',
                          onTap: () {
                            successAlert(context);
                          },
                        ),
                      ),
                      3.horizontalSpace,
                      Flexible(
                        child: AppMIniButton(
                          bgColor: AppColors.mainColor_2,
                          text: 'Hold',
                          onTap: () {},
                        ),
                      ),
                      3.horizontalSpace,
                      Flexible(
                        child: AppMIniButton(
                          bgColor: AppColors.mainColor,
                          text: 'Quick bill',
                          onTap: () {},
                        ),
                      ),
                      3.horizontalSpace,
                      Flexible(
                        child: AppMIniButton(
                          bgColor: AppColors.mainColor,
                          text: 'New Order',
                          onTap: () {},
                        ),
                      ),
                      3.horizontalSpace,
                      Flexible(
                        child: AppMIniButton(
                          bgColor: Color(0xff62c5ce),
                          text: 'All Order',
                          onTap: () {
                            Get.to(OrderViewScreen());
                          },
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      )),
    );
  }
}

//0.5 fpr headin
//0.7 for heading
