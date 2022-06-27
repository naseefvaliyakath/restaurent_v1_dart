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
import '../../widget/progress_btn_controle.dart';
import '../../widget/search_bar_in_billing_screen.dart';
import '../../widget/take_away_screen/billing_item_tile.dart';
import '../../widget/take_away_screen/billing_table_heading.dart';
import '../../widget/take_away_screen/category_drop_down.dart';
import '../../widget/take_away_screen/clear_all_bill_widget.dart';
import '../../widget/take_away_screen/take_away_billing_alerts.dart';
import '../../widget/totel_price_txt.dart';
import '../../widget/white_button_with_icon.dart';



class OnlineBookingBillingScreen extends StatefulWidget {
  const OnlineBookingBillingScreen({Key? key}) : super(key: key);

  @override
  State<OnlineBookingBillingScreen> createState() => _OnlineBookingBillingScreenState();
}

class _OnlineBookingBillingScreenState extends State<OnlineBookingBillingScreen> {


  @override
  Widget build(BuildContext context) {


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
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  size: 24.sp,
                                ),
                                onPressed: () {
                                  if (!Get.find<OnlineBookingBillingController>().billingItems.isEmpty) {
                                    OnlineBookingBillingAlert.askConfirm(context);

                                  } else {
                                    Get.back();
                                  }
                                },
                                splashRadius: 24.sp,
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
                        SearchBarInBillingScreen(onChanged: (value){ctrl.reciveSearchValue(value);}),
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
                                child: ProgressBtnController(
                                  function: () async {

                                  },
                                  text: 'Order',
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
