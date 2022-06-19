import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:restowrent_v_two/screens/online_booking_billing_screen/controller/online_booking_billing_controller.dart';
import 'package:restowrent_v_two/screens/order_view%20_screen.dart';
import '../../app_constans/app_colors.dart';
import '../../widget/app_alerts.dart';
import '../../widget/app_min_button.dart';
import '../../widget/big_text.dart';
import '../../widget/billing_food_card.dart';
import '../../widget/billing_food_err_card.dart';
import '../../widget/heading_rich_text.dart';
import '../../widget/notification_icon.dart';
import '../../widget/online_booking_screen/online_billing_alerts.dart';
import '../../widget/search_bar_in_billing_screen.dart';
import '../../widget/take_away_screen/billing_item_tile.dart';
import '../../widget/take_away_screen/billing_table_heading.dart';
import '../../widget/take_away_screen/category_drop_down.dart';
import '../../widget/take_away_screen/clear_all_bill_widget.dart';
import '../../widget/take_away_screen/take_away_billing_alerts.dart';
import '../../widget/totel_price_txt.dart';
import '../../widget/white_button_with_icon.dart';

enum ButtonState { init, loading, done }

class OnlineBookingBillingScreen extends StatefulWidget {
  const OnlineBookingBillingScreen({Key? key}) : super(key: key);

  @override
  State<OnlineBookingBillingScreen> createState() => _OnlineBookingBillingScreenState();
}

class _OnlineBookingBillingScreenState extends State<OnlineBookingBillingScreen> {
  ButtonState state = ButtonState.init;
  bool isAnimating = true;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isStreched = isAnimating || state == ButtonState.init;
    final isDone = state == ButtonState.done;

    Widget elevatedButton(color, text) {
      return  GFButton(
        onPressed: () async {
          setState(() => state = ButtonState.loading);
          await Future.delayed(const Duration(milliseconds: 2000));
          setState(() => state = ButtonState.done);
          await Future.delayed(const Duration(milliseconds: 2000));
          setState(() => state = ButtonState.init);
        },
        textStyle: TextStyle(fontSize: 14.sp),
        shape: GFButtonShape.pills,
        color: color,
        elevation: 4.sp,
        child: FittedBox(
          child: Text(
            text,
            softWrap: false,
            overflow: TextOverflow.clip,
            maxLines: 1,
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

    return WillPopScope(
      onWillPop: () async {
        if (!Get.find<OnlineBookingBillingController>().billingItems.isEmpty) {
          OnlineBookingBillingAlert.askConfirm(context);
          return false;
        } else {
          return true;
        }
      },
      child: GestureDetector(
        onTap: () {
          //to close key bord on outside touch
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          body: GetBuilder<OnlineBookingBillingController>(builder: (ctrl) {
            return SafeArea(
                child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Container(
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
                              const HeadingRichText(name: 'Online Booking billing'),
                            ],
                          ),
                        ),

                        //notification icon
                        const NotificationIcon(),
                      ],
                    ),
                    // serch and category
                    Row(
                      children: [
                        //search bar
                        SearchBarInBillingScreen(searchController: TextEditingController(),onChanged: (){}),
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
                            return ctrl.isLoading
                                ? const BillingFoodErrCard()
                                : BillingFoodCard(
                                    //foodBillingAlert9context
                                    onTap: () {
                                      OnlineBookingBillingAlert.foodBillingAlert(
                                        context,
                                        price: ctrl.foods?[index].fdFullPrice ?? 0,
                                        img: ctrl.foods![index].fdImg == 'no_data'
                                            ? 'https://mobizate.com/uploads/sample.jpg'
                                            : ctrl.foods![index].fdImg,
                                        name: ctrl.foods?[index].fdName ?? '',
                                        fdId: ctrl.foods?[index].id ?? 0,
                                      );
                                      FocusScope.of(context).requestFocus(FocusNode());
                                    },
                                    img: ctrl.foods![index].fdImg == 'no_data'
                                        ? 'https://mobizate.com/uploads/sample.jpg'
                                        : ctrl.foods![index].fdImg,
                                    name: ctrl.foods?[index].fdName ?? '',
                                    price: ctrl.foods?[index].fdFullPrice ?? 0,
                                  );
                          },
                          itemCount: ctrl.isLoading ? 8 : ctrl.foods?.length ?? 0,
                        )),
                    //Items Orderd title
                    Container(
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        BigText(
                          text: 'Items Orderd ',
                          size: 15.sp,
                        ),
                        10.horizontalSpace,
                        WhiteButtonWithIcon(
                          text: 'Enter Order ID',
                          icon: Icons.edit,
                          onTap: () => addOrderIdAlert(context),
                        ),
                        ClearAllBill(onTap: () {
                          ctrl.clearAllBillItems();
                        }),
                      ]),
                    ),
                    //table
                    Container(
                      decoration:
                          BoxDecoration(border: Border.all(color: AppColors.mainColor), borderRadius: BorderRadius.circular(5.r)),
                      padding: EdgeInsets.all(3.sp),
                      width: double.maxFinite,
                      height: 0.53.sh,
                      child: Column(
                        children: [
                          // table hedings
                          BillingTableHeading(),
                          6.verticalSpace,
                          Container(
                            height: 0.46.sh,
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return BillingItemTile(
                                  index: index,
                                  slNumber: index + 1,
                                  itemName: ctrl.billingItems[index]['name'],
                                  qnt: ctrl.billingItems[index]['qnt'],
                                  kitchenNote: ctrl.billingItems[index]['ktNote'],
                                  price: ctrl.billingItems[index]['price'],
                                  onLongTap: () {
                                    OnlineBookingBillingAlert.deleteItemFromBillAlert(context, index);
                                  },
                                );
                              },
                              itemCount: ctrl.billingItems.length,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: TotelPriceTxt(price: ctrl.totelPrice),
                    ),
                    // controlle buttons
                    Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.symmetric(vertical: 3.h),
                        height: 40.h,
                        child: IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Flexible(
                                child: AnimatedContainer(
                                  width: state == ButtonState.init ? 150.w : 45.w,
                                  //width: 150.w,
                                  height: 40,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn,
                                  onEnd: () => setState(() => isAnimating = !isAnimating),
                                  child: isStreched ? elevatedButton(Color(0xff4caf50), 'Order') : buildSmallButton(isDone),
                                ),
                              ),
                              3.horizontalSpace,
                              Flexible(
                                child: AppMIniButton(
                                  bgColor: Color(0xffee588f),
                                  text: 'Settle',
                                  onTap: () {
                                    billingCashScreenAlert(context);
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
                                  text: 'Quick Pay',
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
                          ),
                        )),
                  ],
                ),
              ),
            ));
          }),
        ),
      ),
    );
  }
}

//0.5 fpr headin
//0.7 for heading
