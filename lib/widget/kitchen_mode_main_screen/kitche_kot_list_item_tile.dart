import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:restowrent_v_two/screens/kitchen_mode/kitchen_mode_main/controller/kitchen_mode_main_controller.dart';
import 'package:restowrent_v_two/widget/kitchen_mode_main_screen/progress_btn_for_kot_tile.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../app_constans/app_colors.dart';
import '../app_min_button.dart';
import '../progress_button.dart';

class KitchenKotItemTile extends StatefulWidget {
  final int index;
  final int slNumber;
  final int kotId;
  final String itemName;
  final int qnt;
  final double price;
  final String kitchenNote;
  final String ordStatus;
  final Function onLongTap;

  const KitchenKotItemTile(
      {Key? key,
      required this.slNumber,
      required this.itemName,
      required this.qnt,
      required this.price,
      required this.kitchenNote,
      required this.kotId,
      required this.onLongTap,
      this.index = 0,
      required this.ordStatus})
      : super(key: key);

  @override
  State<KitchenKotItemTile> createState() => _KitchenKotItemTileState();
}

class _KitchenKotItemTileState extends State<KitchenKotItemTile> {
  bool isTapped = false;
  RoundedLoadingButtonController btnControllerProgressUpdateSingleKotSts = RoundedLoadingButtonController();
  RoundedLoadingButtonController btnControllerReadyUpdateSingleKotSts = RoundedLoadingButtonController();
  RoundedLoadingButtonController btnControllerPendingUpdateSingleKotSts = RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<KitchenModeMainController>(builder: (ctrl) {
      return InkWell(
        onLongPress: () {
          widget.onLongTap();
        },
        //to close keybord in search fiels
        onTap: () {
          setState(() {
            isTapped = !isTapped;
          });
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: (widget.index % 2 == 0) ? AppColors.textHolder : const Color(0xffd2e3ee),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(5.r), topRight: Radius.circular(5.r))),
              height: 50.sp,
              width: 1.sw * 0.9,
              padding: EdgeInsets.symmetric(vertical: 3.sp, horizontal: 2.sp),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 1.sw * 0.08,
                      padding: EdgeInsets.only(left: 5.sp),
                      child: FittedBox(
                        alignment: Alignment.centerLeft,
                        fit: BoxFit.scaleDown,
                        child: Text(
                          widget.slNumber.toString(),
                          maxLines: 1,
                          style: TextStyle(fontSize: 23.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    VerticalDivider(
                      color: Colors.black,
                      thickness: 1.sp,
                    ),
                    SizedBox(
                      width: 1.sw * 0.485,
                      child: FittedBox(
                        alignment: Alignment.centerLeft,
                        fit: BoxFit.scaleDown,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.itemName,
                              maxLines: 1,
                              style: TextStyle(fontSize: 23.sp, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              widget.kitchenNote,
                              maxLines: 1,
                              style: TextStyle(fontSize: 18.sp, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    VerticalDivider(
                      color: Colors.black,
                      thickness: 1.sp,
                    ),
                    SizedBox(
                      width: 1.sw * 0.065,
                      child: FittedBox(
                        alignment: Alignment.centerLeft,
                        fit: BoxFit.fitWidth,
                        child: Text(
                          widget.qnt.toString(),
                          maxLines: 1,
                          style: TextStyle(fontSize: 23.sp),
                        ),
                      ),
                    ),
                    VerticalDivider(
                      color: Colors.black,
                      thickness: 1.sp,
                    ),
                    SizedBox(
                      width: 1.sw * 0.08,
                      child: FittedBox(
                        alignment: Alignment.centerLeft,
                        fit: BoxFit.scaleDown,
                        child: Text(
                          widget.ordStatus,
                          style: TextStyle(
                              fontSize: 23.sp,
                              color: widget.ordStatus == 'ready'
                                  ? Colors.green
                                  : widget.ordStatus == 'pending'
                                      ? AppColors.mainColor_2 : widget.ordStatus == 'progress'
                                  ? Colors.indigo
                                      : Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            AnimatedContainer(
              decoration: BoxDecoration(
                  color: (widget.index % 2 == 0) ? AppColors.textHolder : const Color(0xffd2e3ee),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5.r), bottomRight: Radius.circular(5.r))),
              height: isTapped ? 33.sp : 0,
              width: 1.sw * 0.9,
              padding: EdgeInsets.symmetric(vertical: 3.sp, horizontal: 2.sp),
              margin: EdgeInsets.only(bottom: 2.sp),
              duration: const Duration(milliseconds: 300),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: SizedBox(
                      height: 20.sp,
                      child: ProgressBtnForKotTile(
                        text: 'Progress',
                        btnCtrl: btnControllerProgressUpdateSingleKotSts,
                        bgColor: Colors.indigo,
                        onTap: () async {
                          await ctrl.updateSingleOrderStatus(
                            context: context,
                            kotId: widget.kotId,
                            fdOrderIndex: widget.index,
                            fdOrderSingleStatus: 'progress',
                            btnControllerUpdateSingleKotSts: btnControllerProgressUpdateSingleKotSts,
                          );
                        },
                      ),
                    ),
                  ),
                  3.horizontalSpace,
                  Flexible(
                    child: SizedBox(
                      height: 20.sp,
                      child: ProgressBtnForKotTile(
                        text: 'Ready',
                        btnCtrl: btnControllerReadyUpdateSingleKotSts,
                        bgColor: Colors.pinkAccent,
                        onTap: () async {
                          await ctrl.updateSingleOrderStatus(
                            context: context,
                            kotId: widget.kotId,
                            fdOrderIndex: widget.index,
                            fdOrderSingleStatus: 'ready',
                            btnControllerUpdateSingleKotSts: btnControllerReadyUpdateSingleKotSts,
                          );
                        },
                      ),
                    ),
                  ),
                  3.horizontalSpace,
                  Flexible(
                    child: SizedBox(
                      height: 20.sp,
                      child: ProgressBtnForKotTile(
                        text: 'Pending',
                        btnCtrl: btnControllerPendingUpdateSingleKotSts,
                        bgColor: Colors.teal,
                        onTap: () async {
                          await ctrl.updateSingleOrderStatus(
                            context: context,
                            kotId: widget.kotId,
                            fdOrderIndex: widget.index,
                            fdOrderSingleStatus: 'pending',
                            btnControllerUpdateSingleKotSts: btnControllerPendingUpdateSingleKotSts,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
