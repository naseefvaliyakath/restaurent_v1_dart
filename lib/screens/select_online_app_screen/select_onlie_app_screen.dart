import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:restowrent_v_two/routes/route_helper.dart';
import 'package:restowrent_v_two/screens/select_online_app_screen/controller/select_online_app_controller.dart';
import 'package:restowrent_v_two/widget/app_alerts.dart';
import '../../widget/err_food_card.dart';
import '../../widget/heading_rich_text.dart';
import '../../widget/notification_icon.dart';
import '../../widget/online_booking_screen/add_new_online_app_card.dart';
import '../../widget/online_booking_screen/onlene_app_card.dart';

class SelectOnlineAppScreen extends StatelessWidget {
  const SelectOnlineAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SelectOnlineAppController>(builder: (ctrl) {
        return SafeArea(
          child: CustomScrollView(
            primary: false,
            slivers: <Widget>[
              SliverAppBar(
                floating: true,
                snap: true,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    size: 24.sp,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  splashRadius: 24.sp,
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    //heading
                    HeadingRichText(name: 'Select Online Apps'),
                    //notification icon
                    NotificationIcon(),
                  ],
                ),
                backgroundColor: const Color(0xfffafafa),
              ),
              SliverPadding(
                padding: EdgeInsets.all(20.sp),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200.0.sp,
                    mainAxisSpacing: 18.sp,
                    crossAxisSpacing: 18.sp,
                    childAspectRatio: 2 / 2.5,
                  ),
                  //if empty showing add online app card
                  delegate: ctrl.onlineApp!.isEmpty
                      ? SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return InkWell(
                                onTap: () {
                                  addNewOnlineAppAlert(context: context);
                                },
                                child: const AddNewOnlineAppCard());
                          },
                          childCount: 1,
                        )
                      : SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            if (index < ctrl.onlineApp!.length) {
                              return InkWell(
                                onTap: () {
                                  Get.toNamed(RouteHelper.getOnlineBookingBillingScreen(), arguments: {'holdItem': []});
                                },
                                onLongPress: () {
                                  deleteAlert(context: context, onTap: () async {
                                    ctrl.deleteOnlineApp(ctrl.onlineApp?[index].onlineApp_id ?? -1);
                                  });

                                },
                                child: OnlineAppCard(
                                  text: ctrl.onlineApp?[index].appName ?? 'https://mobizate.com/uploads/sample_2.png',
                                  img: ctrl.onlineApp?[index].appImg ?? 'https://mobizate.com/uploads/sample_2.png',
                                ),
                              );
                            } else {
                              return InkWell(
                                  onTap: () {
                                    addNewOnlineAppAlert(context: context);
                                  },
                                  child: const AddNewOnlineAppCard());
                            }
                          },
                          childCount: ctrl.onlineApp!.isEmpty ? 0 : ctrl.onlineApp!.length + 1,
                        ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
