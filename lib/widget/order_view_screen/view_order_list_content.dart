import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restowrent_v_two/widget/order_view_screen/view_order_list_item_heading.dart';
import 'package:restowrent_v_two/widget/order_view_screen/view_order_list_item_tile.dart';

import '../../screens/order_view_screen/controller/order_view_controller.dart';
import '../app_min_button.dart';

class ViewOrderListContent extends StatelessWidget {
  final OrderViewController ctrl;
  final int kotInt;
  const ViewOrderListContent({Key? key, required this.ctrl, required this.kotInt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.sp),
      width: 0.8.sw,
      child: MediaQuery.removePadding(
        removeBottom :true,
        removeTop: true,
        context: context,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return const ViewOrderListItemHeading();
              },
              itemCount: 1,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 1.sh*0.7
              ),
              child: SizedBox(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ViewOrderListItemTile(
                      index: index,
                      slNumber: index + 1,
                      itemName: ctrl.kotBillingItems?[kotInt].fdOrder?[index].name ?? 'Error',
                      qnt: ctrl.kotBillingItems?[kotInt].fdOrder?[index].qnt ?? 0,
                      kitchenNote: ctrl.kotBillingItems?[kotInt].fdOrder?[index].ktNote ?? 'Error',
                      price: ctrl.kotBillingItems?[kotInt].fdOrder?[index].price.toDouble() ?? 0,
                      onLongTap: () {},
                    );
                  },
                  itemCount: ctrl.kotBillingItems?[kotInt].fdOrder?.length ?? 0,
                ),
              ),
            ),
            10.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 30.h,
                  width: 1.sw*0.4,
                  child: AppMIniButton(
                    bgColor: Colors.redAccent,
                    text: 'Close Window',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            5.verticalSpace,
          ],
        ),
      ),
    );
  }
}
