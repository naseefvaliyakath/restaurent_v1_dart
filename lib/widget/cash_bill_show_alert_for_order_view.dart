import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';
import 'package:restowrent_v_two/model/settled_order_response/settled_order.dart';

import '../model/kitchen_order_response/kitchen_order.dart';
import 'app_round_mini_btn.dart';
import 'big_text.dart';
import 'cash_bill_widget_for_order_view.dart';
import 'kot_bill_widget.dart';

void cashBillAlertForOrderViewPage({
  required SettledOrder singleOrder,
  required List<dynamic> billingItems,
  required context,

}) {
  try {
    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
          insetPadding: const EdgeInsets.all(0),
          titlePadding: const EdgeInsets.all(0),
          contentPadding: const EdgeInsets.all(0),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            AppRoundMiniBtn(
              text: 'Print',
              color: Colors.green,
              onTap: () {},
            ),
            AppRoundMiniBtn(
                text: 'Close',
                color: Colors.redAccent,
                onTap: () {
                  Navigator.pop(context);
                })
          ],
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CashBillWidgetForOrderViewPage(
                billingItems: billingItems,
                singleOrder: singleOrder,

              ),
            ],
          ),
        );
      },
      animationType: DialogTransitionType.scale,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 900),
    );
  } catch (e) {
    rethrow;
  }
}
