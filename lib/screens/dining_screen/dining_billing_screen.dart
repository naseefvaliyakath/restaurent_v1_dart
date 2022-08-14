import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:restowrent_v_two/screens/dining_screen/controller/dining_billing_controller.dart';
import 'package:restowrent_v_two/screens/order_view_screen/order_view%20_screen.dart';
import 'package:restowrent_v_two/screens/table_manage_screen/table_manage_screen.dart';
import '../../app_constans/app_colors.dart';
import '../../routes/route_helper.dart';
import '../../widget/app_alerts.dart';
import '../../widget/app_min_button.dart';
import '../../widget/big_text.dart';
import '../../widget/billing_food_card.dart';
import '../../widget/billing_food_err_card.dart';
import '../../widget/dining_screen/dining_billing_alerts.dart';
import '../../widget/heading_rich_text.dart';
import '../../widget/notification_icon.dart';
import '../../widget/progress_btn_controle.dart';
import '../../widget/progress_button.dart';
import '../../widget/search_bar_in_billing_screen.dart';
import '../../widget/billing_item_tile.dart';
import '../../widget/snack_bar.dart';
import '../../widget/take_away_screen/billing_table_heading.dart';
import '../../widget/take_away_screen/category_drop_down.dart';
import '../../widget/take_away_screen/clear_all_bill_widget.dart';
import '../../widget/take_away_screen/take_away_billing_alerts.dart';
import '../../widget/totel_price_txt.dart';
import '../../widget/white_button_with_icon.dart';
import '../create_table_screen/binding/create_table_binding.dart';

class DiningBillingScreen extends StatefulWidget {
  const DiningBillingScreen({Key? key}) : super(key: key);

  @override
  State<DiningBillingScreen> createState() => _DiningBillingScreenState();
}

class _DiningBillingScreenState extends State<DiningBillingScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Get.find<DiningBillingController>().isNavigateFromKotUpdate == true) {
          return true;
        } else {
          if (Get.find<DiningBillingController>().billingItems.isNotEmpty) {
            DiningBillingAlert.askConfirm(context);
            return false;
          } else {
            return true;
          }
        }
      },
      child: GestureDetector(
        onTap: () {
          //to close key bord on outside touch
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          body: GetBuilder<DiningBillingController>(builder: (ctrl) {
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
                                  if (Get.find<DiningBillingController>().isNavigateFromKotUpdate == true) {
                                    Get.back();
                                  } else {
                                    if (Get.find<DiningBillingController>().billingItems.isNotEmpty) {
                                      DiningBillingAlert.askConfirm(context);
                                    } else {
                                      Get.back();
                                    }
                                  }
                                },
                                splashRadius: 24.sp,
                              ),
                              15.horizontalSpace,
                              const HeadingRichText(name: 'Dining billing'),
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
                        SearchBarInBillingScreen(
                          onChanged: (value) {
                            ctrl.reciveSearchValue(value);
                          },
                        ),
                        //category
                        const CategoryDropDown()
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
                                      //if settled button clicked cant add new item
                                      if (ctrl.isClickedSettle.value) {
                                        AppSnackBar.errorSnackBar('This bill is already settled', 'Click new order !');
                                      } else {
                                        DiningBillingAlert.foodBillingAlert(
                                          context,
                                          price: ctrl.foods?[index].fdFullPrice ?? 0,
                                          img: ctrl.foods![index].fdImg == 'no_data'
                                              ? 'https://mobizate.com/uploads/sample.jpg'
                                              : ctrl.foods![index].fdImg,
                                          name: ctrl.foods?[index].fdName ?? '',
                                          fdId: ctrl.foods?[index].fdId ?? 0,
                                        );
                                      }
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
                          text: ctrl.selectedTableName,
                          icon: Icons.edit,
                          onTap: () {
                            //checking if any item is added  befor select table
                            if (ctrl.billingItems.isNotEmpty) {
                              ctrl.saveBillInHive();
                              Get.offNamed(RouteHelper.getTableManageScreen());
                            } else {
                              Get.offNamed(RouteHelper.getTableManageScreen());
                            }
                          },
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
                      height: 0.52.sh,
                      child: Column(
                        children: [
                          // table hedings
                          const BillingTableHeading(),
                          6.verticalSpace,
                          SizedBox(
                            child: ListView.builder(
                              shrinkWrap:true,
                              itemBuilder: (context, index) {
                                return BillingItemTile(
                                  index: index,
                                  slNumber: index + 1,
                                  itemName: ctrl.billingItems[index]['name'],
                                  qnt: ctrl.billingItems[index]['qnt'],
                                  kitchenNote: ctrl.billingItems[index]['ktNote'],
                                  price: ctrl.billingItems[index]['price'],
                                  onLongTap: () {
                                    DiningBillingAlert.deleteItemFromBillAlert(context, index);
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
                    ctrl.isNavigateFromKotUpdate
                        ? Container(
                            width: double.maxFinite,
                            padding: EdgeInsets.symmetric(vertical: 3.h),
                            height: 40.h,
                            child: IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Flexible(
                                    child: ProgressButton(
                                      btnCtrlName: 'kotUpdate',
                                      text: 'Update KOT Order',
                                      ctrl: ctrl,
                                      color: Colors.green,
                                      onTap: () async {
                                        ctrl.updateKotOrder();
                                      },
                                    ),
                                  ),
                                  3.horizontalSpace,
                                  Flexible(
                                    child: AppMIniButton(
                                      bgColor: Colors.redAccent,
                                      text: 'Cancel Update',
                                      onTap: () {
                                        if (ctrl.from == 'tableManage') {
                                          Get.offNamed(RouteHelper.getTableManageScreen());
                                        } else {
                                          Get.offNamed(RouteHelper.getOrderViewScreen());
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ))
                        : Container(
                            width: double.maxFinite,
                            padding: EdgeInsets.symmetric(vertical: 3.h),
                            height: 40.h,
                            child: IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Flexible(
                                    child: ProgressButton(
                                      btnCtrlName: 'kot',
                                      text: 'Order',
                                      ctrl: ctrl,
                                      color: Colors.green,
                                      onTap: () async {
                                        //if settled button clicked cant send order
                                        if (ctrl.isClickedSettle.value) {
                                          AppSnackBar.errorSnackBar('This bill is already settled', 'Click new order !');
                                          ctrl.btnControllerKot.error();
                                          await Future.delayed(const Duration(milliseconds: 500), () {
                                            ctrl.btnControllerKot.reset();
                                          });
                                        } else {
                                          //check table is selected
                                          if (ctrl.tableId == -1) {
                                            AppSnackBar.errorSnackBar('Select Table', 'Pleas select a table');
                                            ctrl.btnControllerKot.error();
                                            await Future.delayed(const Duration(milliseconds: 500), () {
                                              ctrl.btnControllerKot.reset();
                                            });
                                          } else {
                                            await ctrl.sendKotOrder();

                                          }
                                        }
                                      },
                                    ),
                                  ),
                                  3.horizontalSpace,
                                  Flexible(
                                    child: AppMIniButton(
                                      bgColor: const Color(0xffee588f),
                                      text: 'Settle',
                                      onTap: () {
                                        ctrl.settleBillingCash(context, ctrl);
                                      },
                                    ),
                                  ),
                                  3.horizontalSpace,
                                  Flexible(
                                    child: ProgressButton(
                                      btnCtrlName: 'hold',
                                      text: 'Hold',
                                      ctrl: ctrl,
                                      color: AppColors.mainColor_2,
                                      onTap: () async {
                                        ctrl.addHoldBillItem();
                                      },
                                    ),
                                  ),
                                  3.horizontalSpace,
                                  Flexible(
                                    child: AppMIniButton(
                                      bgColor: AppColors.mainColor,
                                      text: 'KOT',
                                      onTap: () {
                                        ctrl.kotDialogBox(context);
                                      },
                                    ),
                                  ),
                                  3.horizontalSpace,
                                  Flexible(
                                    child: AppMIniButton(
                                      bgColor: AppColors.mainColor,
                                      text: 'New Order',
                                      onTap: () {
                                        ctrl.enableNewOrder();
                                      },
                                    ),
                                  ),
                                  3.horizontalSpace,
                                  Flexible(
                                    child: AppMIniButton(
                                      bgColor: Color(0xff62c5ce),
                                      text: 'All Order',
                                      onTap: () {
                                        Get.offNamed(RouteHelper.getOrderViewScreen());
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
