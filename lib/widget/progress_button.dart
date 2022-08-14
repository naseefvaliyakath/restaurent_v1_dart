import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ProgressButton extends StatelessWidget {
  final Function onTap;
  final String text;
  final String btnCtrlName;
  final Color color;
  final ctrl;

  const ProgressButton(
      {Key? key, required this.text, required this.color, required this.ctrl, required this.onTap, required this.btnCtrlName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedLoadingButton(
        successIcon: Icons.check_circle_outline,
        failedIcon: Icons.error_outline,
        color: color,
        successColor: Colors.green,
        completionDuration: const Duration(milliseconds: 0),
        duration: const Duration(milliseconds: 100),
        controller: btnCtrlName == 'settle'
            ? ctrl.btnControllerSettle
            : btnCtrlName == 'kot'
                ? ctrl.btnControllerKot
                : btnCtrlName == 'hold'
                    ? ctrl.btnControllerHold
                    : btnCtrlName == 'CancelOrder'
                        ? ctrl.btnControllerCancellKOtOrder
                        : btnCtrlName == 'kotUpdate'
                            ? ctrl.btnControllerUpdateKot
                            : btnCtrlName == 'createTable'
                                ? ctrl.btnControllerCreateTable
                                : btnCtrlName == 'CancelOrderInTable'
                                    ? ctrl.btnControllerCancelKotOrderInTable
                                    : ctrl.btnControllerSettle,
        onPressed: () async {
          await onTap();
        },
        child: Text(
          text,
          softWrap: false,
          overflow: TextOverflow.clip,
          maxLines: 1,
          style: TextStyle(color: Colors.white, fontSize: 16.sp),
        ));
  }
}
