import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:restowrent_v_two/routes/route_helper.dart';
import 'package:restowrent_v_two/screens/today_food_screen/controller/today_food_controller.dart';
import 'package:restowrent_v_two/widget/loading_page.dart';
import 'package:restowrent_v_two/widget/two_button-bottom_sheet.dart';
import '../../widget/err_food_card.dart';
import '../../widget/food_card.dart';
import '../../widget/food_search_bar.dart';
import '../../widget/food_sort_round_icon.dart';
import '../../widget/heading_rich_text.dart';
import '../../widget/round_border_icon_button.dart';


class TodayFoodScreen extends StatelessWidget {
  const TodayFoodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TodayFoodController>(
      builder: (ctrl) {
        return RefreshIndicator(
          onRefresh: () async {
            await ctrl.getTodayFoods();
          },
          child: ctrl.isloading2
              ? const MyLoading()
              : SafeArea(
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    primary: false,
                    slivers: <Widget>[
                      SliverAppBar(
                        floating: true,
                        snap: true,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //heading
                            const HeadingRichText(name: 'Today Food'),
                            //add food and all food icon icon
                            Row(
                              children: [
                                //add food screen btn
                                RoundBorderIconButton(
                                  name: 'Add food',
                                  icon: FontAwesomeIcons.utensils,
                                  onTap: () {
                                    Get.toNamed(RouteHelper.getAddFoodScreen());
                                  },
                                ),
                                10.horizontalSpace,
                                //all food scrn btn
                                RoundBorderIconButton(
                                  name: 'All food',
                                  icon: FontAwesomeIcons.borderAll,
                                  onTap: () {
                                    Get.toNamed(RouteHelper.getAllFoodScreen());
                                  },
                                ),
                              ],
                            )
                          ],
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
                                const FoodSortRoundIcon()
                              ],
                            ),
                          ),
                        ),
                        backgroundColor: const Color(0xfffafafa),
                      ),
                      SliverPadding(
                        padding: EdgeInsets.all(20.sp),
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
                                    return const ErrFoodCard();
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
                                            b1Name: 'Remove From Today Food',
                                            b2Name: 'Close',
                                            b1Function: () async {
                                              Navigator.pop(context);
                                              ctrl.removeFromToday(ctrl.foods![index].fdId, 'no');
                                            },
                                            b2Function: () {
                                              Navigator.pop(context);
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
      },
    );
  }
}
