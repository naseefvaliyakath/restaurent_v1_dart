import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:restowrent_v_two/screens/all_food_screen/controller/all_food_controller.dart';
import 'package:restowrent_v_two/screens/today_food_screen/controller/today_food_controller.dart';

import '../../routes/route_helper.dart';
import '../../widget/app_alerts.dart';
import '../../widget/err_food_card.dart';
import '../../widget/food_card.dart';
import '../../widget/food_sort_round_icon.dart';
import '../../widget/loading_page.dart';
import '../../widget/food_search_bar.dart';
import '../../widget/two_button-bottom_sheet.dart';

class AllFoodScreen extends StatelessWidget {
  const AllFoodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Get.find<TodayFoodController>().getTodayFoods();
        return true;
      },
      child: Scaffold(
        body: GetBuilder<AllFoodController>(builder: (ctrl) {
          return RefreshIndicator(
            onRefresh: () async {
              await ctrl.getAllFoods();
            },
            child: ctrl.isloading2
                ? const MyLoading()
                : SafeArea(
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
                          titleTextStyle: TextStyle(fontSize: 26.sp, color: Colors.black, fontWeight: FontWeight.w600),
                          actions: [
                            Badge(
                              badgeColor: Colors.red,
                              child: Container(
                                  margin: EdgeInsets.only(right: 10.w),
                                  child: Icon(
                                    FontAwesomeIcons.bell,
                                    size: 24.sp,
                                  )),
                            ),
                          ],
                          leading: IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              size: 24.sp,
                            ),
                            onPressed: () {
                              //to refresh today food
                              Get.find<TodayFoodController>().getTodayFoods();
                              Get.back();
                            },
                            splashRadius: 24.sp,
                          ),
                          bottom: PreferredSize(
                            preferredSize: Size.fromHeight(60.h),
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.0.w, right: 10.w),
                              child: Row(
                                children: [
                                  FoodSearchBar(
                                    onChanged: (value) {
                                      ctrl.reciveSearchValue(value);
                                    },
                                  ),
                                  FoodSortRoundIcon()
                                ],
                              ),
                            ),
                          ),
                          backgroundColor: const Color(0xfffafafa),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.all(20),
                          sliver: ctrl.isLoading
                              ? SliverGrid(
                                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200.0.sp,
                                    mainAxisSpacing: 18.sp,
                                    crossAxisSpacing: 18.sp,
                                    childAspectRatio: 2 / 2.8,
                                  ),
                                  delegate: SliverChildBuilderDelegate(
                                    (BuildContext context, int index) {
                                      return ErrFoodCard();
                                    },
                                    childCount: 6,
                                  ),
                                )
                              : SliverGrid(
                                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200.0.sp,
                                    mainAxisSpacing: 18.sp,
                                    crossAxisSpacing: 18.sp,
                                    childAspectRatio: 2 / 2.8,
                                  ),
                                  delegate: SliverChildBuilderDelegate(
                                    (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          TwoBtnBottomSheet.bottomSheet(
                                              b1Name: 'Add To Today Food',
                                              b2Name: 'Edit Food',
                                              b1Function: () {
                                                Navigator.pop(context);
                                                ctrl.addToToday(ctrl.foods![index].fdId, 'yes');
                                              },
                                              b2Function: () {
                                                Navigator.pop(context);
                                                Get.offAndToNamed(
                                                  RouteHelper.updateFoodScreen,
                                                  arguments: {
                                                    'fdName': ctrl.foods?[index].fdName ?? '',
                                                    'fdCategory': ctrl.foods?[index].fdCategory ?? '',
                                                    'fdFullPrice': ctrl.foods?[index].fdFullPrice ?? 0,
                                                    'fdThreeBiTwoPrsPrice': ctrl.foods?[index].fdThreeBiTwoPrsPrice ?? 0,
                                                    'fdHalfPrice': ctrl.foods?[index].fdHalfPrice ?? 0,
                                                    'fdQtrPrice': ctrl.foods?[index].fdQtrPrice ?? 0,
                                                    'fdIsLoos': ctrl.foods?[index].fdIsLoos ?? 'no',
                                                    'cookTime': ctrl.foods?[index].cookTime ?? 0,
                                                    'fdShopId': ctrl.foods?[index].fdShopId ?? 0,
                                                    'fdImg': ctrl.foods![index].fdImg,
                                                    'fdIsToday': ctrl.foods?[index].fdIsToday ?? 'no',
                                                    'id': ctrl.foods?[index].fdId ?? 0,
                                                  },
                                                );
                                              });
                                        },
                                        onLongPress: () {
                                          deleteAlert(
                                              context: context,
                                              onTap: () {
                                                Get.find<AllFoodController>().deleteFood(ctrl.foods![index].fdId);
                                              });
                                        },
                                        child: FoodCard(
                                          img: ctrl.foods![index].fdImg == 'no_data'
                                              ? 'https://mobizate.com/uploads/sample.jpg'
                                              : ctrl.foods![index].fdImg,
                                          name: ctrl.foods?[index].fdName ?? '',
                                          price: ctrl.foods?[index].fdFullPrice ?? 0,
                                          today: ctrl.foods?[index].fdIsToday ?? 'no',
                                        ),
                                      );
                                    },
                                    childCount: ctrl.foods?.length ?? 0,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
          );
        }),
      ),
    );
  }
}
