import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restowrent_v_two/screens/table_manage_screen/controller/table_manage_controller.dart';
import 'package:restowrent_v_two/widget/mid_text.dart';
import 'package:restowrent_v_two/widget/order_view_screen/view_order_list_item_tile.dart';
import 'package:get/get.dart';
import '../app_min_button.dart';
import '../big_text.dart';
import '../order_view_screen/view_order_list_item_heading.dart';
import '../progress_button.dart';

class ViewOrderInTaleContent extends StatelessWidget {
  final int kotId;
  final int tbChrIndexInDb;

  const ViewOrderInTaleContent({Key? key, required this.kotId, required this.tbChrIndexInDb}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TableManageController>(builder: (ctrl) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 5.sp),
        width: 0.8.sw,
        child: MediaQuery.removePadding(
          removeBottom: true,
          removeTop: true,
          context: context,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MidText(text: 'KOT ID : $kotId'),
              5.verticalSpace,
              ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return const ViewOrderListItemHeading();
                },
                itemCount: 1,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 1.sh * 0.7),
                child: SizedBox(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ViewOrderListItemTile(
                        index: index,
                        slNumber: index + 1,
                        itemName: ctrl.singleKitchenOrder.fdOrder?[index].name ?? 'Error',
                        qnt: ctrl.singleKitchenOrder.fdOrder?[index].qnt ?? 0,
                        kitchenNote: ctrl.singleKitchenOrder.fdOrder?[index].ktNote ?? 'Error',
                        price: ctrl.singleKitchenOrder.fdOrder?[index].price.toDouble() ?? 0,
                        onLongTap: () {},
                      );
                    },
                    itemCount: ctrl.singleKitchenOrder.fdOrder?.length ?? 0,
                  ),
                ),
              ),
              10.verticalSpace,
              Align(
                alignment: Alignment.center,
                  child: BigText(text: 'Total Price : ${ctrl.singleKitchenOrder.totelPrice}',size: 20.sp)),
              10.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 30.h,
                    width: 1.sw * 0.25,
                    child: AppMIniButton(
                      bgColor: Colors.cyan,
                      text: 'Ring',
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                    width: 1.sw * 0.25,
                    child: AppMIniButton(
                      bgColor: Colors.green,
                      text: 'Edit',
                      onTap: () {
                        Navigator.pop(context); //this not add then page note kill
                        //otherwaiys will throw error
                        ctrl.updateKotOrder(kotId: kotId);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                    width: 1.sw * 0.25,
                    child: AppMIniButton(
                      bgColor: Colors.teal,
                      text: 'Shift',
                      onTap: () {
                        ctrl.updateShiftedMode(true);
                        ctrl.getTheDetailsOfShiftingChair(kotId: kotId, tbChrIndexInDb: tbChrIndexInDb);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
              8.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 30.h,
                    width: 1.sw * 0.25,
                    child: AppMIniButton(
                      bgColor: Colors.blueAccent,
                      text: 'Shift',
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                    width: 1.sw * 0.25,
                    child: AppMIniButton(
                      bgColor: Colors.purpleAccent,
                      text: 'Link Chair',
                      onTap: () {
                        ctrl.getKotOrderListFromKotId(kotId);
                        ctrl.updateLinkChairMode(true);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                    width: 1.sw * 0.25,
                    child: ProgressButton(
                      btnCtrlName: 'CancelOrderInTable',
                      text: 'Cancel',
                      ctrl: ctrl,
                      color: const Color(0xffef2f28),
                      onTap: () async {
                        await ctrl.deleteKotOrder(kotId);
                        Future.delayed(const Duration(seconds: 1), () {
                          Navigator.pop(context);
                        });
                      },
                    ),
                  ),
                ],
              ),
              8.verticalSpace,
            ],
          ),
        ),
      );
    });
  }
}
