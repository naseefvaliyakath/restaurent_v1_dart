import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restowrent_v_two/app_constans/app_colors.dart';
import 'package:restowrent_v_two/model/kitchen_order_response/kitchen_order.dart';
import 'package:restowrent_v_two/screens/kitchen_mode/kitchen_mode_main/controller/kitchen_mode_main_controller.dart';
import 'package:restowrent_v_two/widget/mid_text.dart';
import 'package:get/get.dart';
import '../app_min_button.dart';
import '../progress_button.dart';
import 'kitche_kot_list_item_tile.dart';
import 'kitchen_kot_list_item_heading.dart';

class KitchenKotViewAlertContent extends StatelessWidget {
  final KitchenOrder kotItem;
  final int tbChrIndexInDb;

  const KitchenKotViewAlertContent({Key? key, required this.kotItem, required this.tbChrIndexInDb}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<KitchenModeMainController>(builder: (ctrl) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 5.sp),
        width: 0.95.sw,
        child: MediaQuery.removePadding(
          removeBottom: true,
          removeTop: true,
          context: context,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MidText(text: 'KOT ID : ${kotItem.Kot_id}'),
              5.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MidText(text: 'TYPE : ${kotItem.fdOrderType.toUpperCase()}',size: 15.sp,),
                  MidText(text: 'STATUS : ${kotItem.fdOrderStatus.toUpperCase()}',size: 15.sp,),
                ],
              ),
              10.verticalSpace,

              Row(
                children: const [
                  Expanded(child: KitchenKotListItemHeading()),
                ],
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 1.sh * 0.7),
                child: SizedBox(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return KitchenKotItemTile(
                        index: index,
                        slNumber: index + 1,
                        kotId:  kotItem.Kot_id,
                        itemName: kotItem.fdOrder?[index].name ?? '',
                        qnt: kotItem.fdOrder?[index].qnt ?? 0,
                        kitchenNote: kotItem.fdOrder?[index].ktNote ?? '',
                        price: kotItem.fdOrder?[index].price.toDouble() ?? 0.0,
                        ordStatus: kotItem.fdOrder?[index].ordStatus ?? 'pending',
                        onLongTap: () {},
                      );
                    },
                    itemCount: kotItem.fdOrder?.length ?? 0,
                  ),
                ),
              ),
              15.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: SizedBox(
                      height: 40.h,
                      child: ProgressButton(
                        ctrl: ctrl,
                        btnCtrlName: 'updateFullProgressOrdStatus',
                        color: Colors.blueAccent,
                        text: 'Progress',
                        onTap: () async {
                         await ctrl.updateFullOrderStatus(kotId: kotItem.Kot_id, fdOrderStatus: 'progress', context: context);
                        },
                      ),
                    ),
                  ),
                  3.horizontalSpace,
                  Flexible(
                    child: SizedBox(
                      height: 40.h,
                      child: ProgressButton(
                        ctrl: ctrl,
                        btnCtrlName: 'updateFullReadyOrdStatus',
                        color: Colors.green,
                        text: 'Ready',
                        onTap: () async {
                          await ctrl.updateFullOrderStatus(kotId: kotItem.Kot_id, fdOrderStatus: 'ready', context: context);
                        },
                      ),
                    ),
                  ),
                  3.horizontalSpace,
                  Flexible(
                    child: SizedBox(
                      height: 40.h,
                      child: ProgressButton(
                        ctrl: ctrl,
                        btnCtrlName: 'updateFullPendingOrdStatus',
                        color: AppColors.mainColor_2,
                        text: 'Pending',
                        onTap: () async {
                          await ctrl.updateFullOrderStatus(kotId: kotItem.Kot_id, fdOrderStatus: 'pending', context: context);
                        },
                      ),
                    ),
                  ),
                  3.horizontalSpace,
                  Flexible(
                    child: SizedBox(
                      height: 40.h,
                      child: ProgressButton(
                        ctrl: ctrl,
                        btnCtrlName: 'updateFullRejectOrdStatus',
                        color: Colors.red,
                        text: 'Reject',
                        onTap: () async {
                          await ctrl.updateFullOrderStatus(kotId: kotItem.Kot_id, fdOrderStatus: 'reject', context: context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              15.verticalSpace,
            ],
          ),
        ),
      );
    });
  }
}
