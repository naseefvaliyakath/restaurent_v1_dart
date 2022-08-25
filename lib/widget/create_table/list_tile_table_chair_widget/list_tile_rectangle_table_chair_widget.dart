import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:restowrent_v_two/model/kitchen_order_response/kot_tableChairSet.dart';
import 'package:restowrent_v_two/model/table_chair_set/table_chair_set.dart';
import 'package:restowrent_v_two/screens/create_table_screen/controller/create_table_controller.dart';
import 'package:restowrent_v_two/screens/table_manage_screen/controller/table_manage_controller.dart';
import 'package:restowrent_v_two/widget/create_table/table_rectangle.dart';
import '../../../model/kitchen_order_response/kitchen_order.dart';
import '../../app_alerts.dart';
import '../../snack_bar.dart';
import '../chair_widget.dart';
import '../chair_widget_with_onTap.dart';

class ListTileRectangleTableChairWidget extends StatelessWidget {
  final int tableIndex;

  final int leftChairCount;
  final int rightChairCount;
  final int topChairCount;
  final int bottomChairCount;

  final Function onChairTap;
  final TableManageController ctrl;
  final TableChairSet tbChr;

  const ListTileRectangleTableChairWidget({
    Key? key,
    required this.tableIndex,
    required this.leftChairCount,
    required this.rightChairCount,
    required this.topChairCount,
    required this.bottomChairCount,
    required this.onChairTap,
    required this.ctrl,
    required this.tbChr,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.65.sw,
      width: 0.45.sw,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              offset: const Offset(4, 6),
              blurRadius: 4,
              color: Colors.black.withOpacity(0.3),
            )
          ],
          border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1.sp)),
      child: Container(
        padding: EdgeInsets.all(5.sp),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Stack(
          children: <Widget>[
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Stack(
                  children: [
                    //table
                    Center(
                      child: TableRectangle(
                        onLongTap: () {
                          bool isAnyOrderInTable = false;
                          for (var element in ctrl.kotTableChairSetList) {
                            if (element.tableId == tbChr.tableId) {
                              isAnyOrderInTable = true;
                              break;
                            }
                          }

                          deleteAlert(
                              context: context,
                              onTap: () async {
                                ctrl.deleteTable(tbChr.tableId, isAnyOrderInTable);
                              });
                        },
                        onTap: () {},
                        text: 'TABLE $tableIndex',
                        width: constraints.maxWidth - 100.w,
                        height: constraints.maxHeight - 100.w,
                      ),
                    ),

                    //left side
                    Positioned(
                      top: 50.h,
                      child: SizedBox(
                        width: 40.w,
                        height: constraints.maxHeight - 100.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List<Widget>.generate(leftChairCount, (index) {
                            bool isChairHasOrder = false;
                            int kotId = -1;
                            int tbChrIndexInDb = -1;
                            bool isMultipleOrderInKOt = false;
                            int colorCodeFromDb = 111;
                            //in kotTbSet contain all kotTableChairSet details ({Kot_id:1,tableId:2,position:L'}) not for one Kot
                            List<KotTableChairSet> kotTbSet = ctrl.kotTableChairSetList;
                            //this contain all kot order
                            List<KitchenOrder>? kotBillingItems = ctrl.kotBillingItems ?? [];

                            for (var element in kotTbSet) {
                              //check this tale is in kotTable list
                              if (element.tableId == tbChr.tableId) {
                                //then check this position is in kotTable list
                                if (element.position == 'L') {
                                  //then check index of chair is index of order
                                  if (element.chrIndex == index) {
                                    isChairHasOrder = true;
                                    //kot id will send to chair widget to orderView
                                    kotId = element.Kot_id;
                                    //this is index of chair in kotOrder
                                    tbChrIndexInDb = element.tbChrIndexInDb;

                                    //ckhecking in this kotId multiple chair is shared
                                    for (var element in kotBillingItems) {
                                      if (element.Kot_id == kotId) {
                                        if (element.kotTableChairSet!.length > 1) {
                                          isMultipleOrderInKOt = true;
                                          colorCodeFromDb = element.orderColor;
                                        }
                                      }
                                    }

                                    //brake and out from the loop if one chair is fount
                                    break;
                                  } else {
                                    isChairHasOrder = false;
                                    kotId = -1;
                                  }
                                } else {
                                  isChairHasOrder = false;
                                  kotId = -1;
                                }
                              } else {
                                isChairHasOrder = false;
                                kotId = -1;
                              }
                            }

                            // print('isMultipleOrderInKOt $isMultipleOrderInKOt color $colorCodeFromDb');
                            return ChairWidgetWithOnTap(
                              //check if shifted mode and the chair has kotOrder then it will hide
                              color: !isChairHasOrder
                                  ? Colors.green
                                  //if its in shifted mode kotChair will gray color
                                  : isChairHasOrder && (ctrl.chairShiftMode || ctrl.linkChairMode)
                                      ? Colors.grey
                                      : isMultipleOrderInKOt
                                          ? Colors.primaries[colorCodeFromDb]
                                          : Colors.deepOrange,
                              text: 'C ${index + 1}',
                              onTap: () async {
                                //check if clicked  in kotChair
                                isChairHasOrder && (ctrl.chairShiftMode || ctrl.linkChairMode)
                                    ? AppSnackBar.errorSnackBar('Chair already in use!', 'Pleas select other Chair !')
                                    : await onChairTap('L', index, kotId, tbChrIndexInDb);
                              },
                            );
                          }).toList(growable: true),
                        ),
                      ),
                    ),
                    //right side
                    Positioned(
                      top: 50.h,
                      right: 0,
                      child: SizedBox(
                        width: 40.w,
                        height: constraints.maxHeight - 100.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List<Widget>.generate(leftChairCount, (index) {
                            bool isChairHasOrder = false;
                            int kotId = -1;
                            int tbChrIndexInDb = -1;
                            bool isMultipleOrderInKOt = false;
                            int colorCodeFromDb = 111;
                            //in kotTbSet contain all kotTableChairSet details ({Kot_id:1,tableId:2,position:L'}) not for one Kot
                            List<KotTableChairSet> kotTbSet = ctrl.kotTableChairSetList;
                            //this contain all kot order
                            List<KitchenOrder>? kotBillingItems = ctrl.kotBillingItems ?? [];

                            for (var element in kotTbSet) {
                              //check this tale is in kotTable list
                              if (element.tableId == tbChr.tableId) {
                                //then check this position is in kotTable list
                                if (element.position == 'R') {
                                  //then check index of chair is index of order
                                  if (element.chrIndex == index) {
                                    isChairHasOrder = true;
                                    //kot id will send to chair widget to orderView
                                    kotId = element.Kot_id;
                                    //this is index of chair in kotOrder
                                    tbChrIndexInDb = element.tbChrIndexInDb;

                                    //ckhecking in this kotId multiple chair is shared
                                    for (var element in kotBillingItems) {
                                      if (element.Kot_id == kotId) {
                                        if (element.kotTableChairSet!.length > 1) {
                                          isMultipleOrderInKOt = true;
                                          colorCodeFromDb = element.orderColor;
                                        }
                                      }
                                    }

                                    //brake and out from the loop if one chair is fount
                                    break;
                                  } else {
                                    isChairHasOrder = false;
                                    kotId = -1;
                                  }
                                } else {
                                  isChairHasOrder = false;
                                  kotId = -1;
                                }
                              } else {
                                isChairHasOrder = false;
                                kotId = -1;
                              }
                            }

                            // print('isMultipleOrderInKOt $isMultipleOrderInKOt color $colorCodeFromDb');
                            return ChairWidgetWithOnTap(
                              //check if shifted mode and the chair has kotOrder then it will hide
                              color: !isChairHasOrder
                                  ? Colors.green
                                  //if its in shifted mode kotChair will gray color
                                  : isChairHasOrder && (ctrl.chairShiftMode || ctrl.linkChairMode)
                                      ? Colors.grey
                                      : isMultipleOrderInKOt
                                          ? Colors.primaries[colorCodeFromDb]
                                          : Colors.deepOrange,
                              text: 'C ${index + 1}',
                              onTap: () async {
                                //check if clicked  in kotChair
                                isChairHasOrder && (ctrl.chairShiftMode || ctrl.linkChairMode)
                                    ? AppSnackBar.errorSnackBar('Chair already in use!', 'Pleas select other Chair !')
                                    : await onChairTap('R', index, kotId, tbChrIndexInDb);
                              },
                            );
                          }).toList(growable: true),
                        ),
                      ),
                    ),
                    //top side
                    Positioned(
                      top: 0,
                      left: 50.w,
                      child: SizedBox(
                        width: constraints.maxWidth - 100.w,
                        height: 40.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List<Widget>.generate(leftChairCount, (index) {
                            bool isChairHasOrder = false;
                            int kotId = -1;
                            int tbChrIndexInDb = -1;
                            bool isMultipleOrderInKOt = false;
                            int colorCodeFromDb = 111;
                            //in kotTbSet contain all kotTableChairSet details ({Kot_id:1,tableId:2,position:L'}) not for one Kot
                            List<KotTableChairSet> kotTbSet = ctrl.kotTableChairSetList;
                            //this contain all kot order
                            List<KitchenOrder>? kotBillingItems = ctrl.kotBillingItems ?? [];

                            for (var element in kotTbSet) {
                              //check this tale is in kotTable list
                              if (element.tableId == tbChr.tableId) {
                                //then check this position is in kotTable list
                                if (element.position == 'T') {
                                  //then check index of chair is index of order
                                  if (element.chrIndex == index) {
                                    isChairHasOrder = true;
                                    //kot id will send to chair widget to orderView
                                    kotId = element.Kot_id;
                                    //this is index of chair in kotOrder
                                    tbChrIndexInDb = element.tbChrIndexInDb;

                                    //ckhecking in this kotId multiple chair is shared
                                    for (var element in kotBillingItems) {
                                      if (element.Kot_id == kotId) {
                                        if (element.kotTableChairSet!.length > 1) {
                                          isMultipleOrderInKOt = true;
                                          colorCodeFromDb = element.orderColor;
                                        }
                                      }
                                    }

                                    //brake and out from the loop if one chair is fount
                                    break;
                                  } else {
                                    isChairHasOrder = false;
                                    kotId = -1;
                                  }
                                } else {
                                  isChairHasOrder = false;
                                  kotId = -1;
                                }
                              } else {
                                isChairHasOrder = false;
                                kotId = -1;
                              }
                            }

                            // print('isMultipleOrderInKOt $isMultipleOrderInKOt color $colorCodeFromDb');
                            return ChairWidgetWithOnTap(
                              //check if shifted mode and the chair has kotOrder then it will hide
                              color: !isChairHasOrder
                                  ? Colors.green
                                  //if its in shifted mode kotChair will gray color
                                  : isChairHasOrder && (ctrl.chairShiftMode || ctrl.linkChairMode)
                                      ? Colors.grey
                                      : isMultipleOrderInKOt
                                          ? Colors.primaries[colorCodeFromDb]
                                          : Colors.deepOrange,
                              text: 'C ${index + 1}',
                              onTap: () async {
                                //check if clicked  in kotChair
                                isChairHasOrder && (ctrl.chairShiftMode || ctrl.linkChairMode)
                                    ? AppSnackBar.errorSnackBar('Chair already in use!', 'Pleas select other Chair !')
                                    : await onChairTap('T', index, kotId, tbChrIndexInDb);
                              },
                            );
                          }).toList(growable: true),
                        ),
                      ),
                    ),
                    //bottom side
                    Positioned(
                      bottom: 0,
                      left: 50.w,
                      child: SizedBox(
                        width: constraints.maxWidth - 100.w,
                        height: 40.w,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List<Widget>.generate(leftChairCount, (index) {
                              bool isChairHasOrder = false;
                              int kotId = -1;
                              int tbChrIndexInDb = -1;
                              bool isMultipleOrderInKOt = false;
                              int colorCodeFromDb = 111;
                              //in kotTbSet contain all kotTableChairSet details ({Kot_id:1,tableId:2,position:L'}) not for one Kot
                              List<KotTableChairSet> kotTbSet = ctrl.kotTableChairSetList;
                              //this contain all kot order
                              List<KitchenOrder>? kotBillingItems = ctrl.kotBillingItems ?? [];

                              for (var element in kotTbSet) {
                                //check this tale is in kotTable list
                                if (element.tableId == tbChr.tableId) {
                                  //then check this position is in kotTable list
                                  if (element.position == 'B') {
                                    //then check index of chair is index of order
                                    if (element.chrIndex == index) {
                                      isChairHasOrder = true;
                                      //kot id will send to chair widget to orderView
                                      kotId = element.Kot_id;
                                      //this is index of chair in kotOrder
                                      tbChrIndexInDb = element.tbChrIndexInDb;

                                      //ckhecking in this kotId multiple chair is shared
                                      for (var element in kotBillingItems) {
                                        if (element.Kot_id == kotId) {
                                          if (element.kotTableChairSet!.length > 1) {
                                            isMultipleOrderInKOt = true;
                                            colorCodeFromDb = element.orderColor;
                                          }
                                        }
                                      }

                                      //brake and out from the loop if one chair is fount
                                      break;
                                    } else {
                                      isChairHasOrder = false;
                                      kotId = -1;
                                    }
                                  } else {
                                    isChairHasOrder = false;
                                    kotId = -1;
                                  }
                                } else {
                                  isChairHasOrder = false;
                                  kotId = -1;
                                }
                              }

                              // print('isMultipleOrderInKOt $isMultipleOrderInKOt color $colorCodeFromDb');
                              return ChairWidgetWithOnTap(
                                //check if shifted mode and the chair has kotOrder then it will hide
                                color: !isChairHasOrder
                                    ? Colors.green
                                    //if its in shifted mode kotChair will gray color
                                    : isChairHasOrder && (ctrl.chairShiftMode || ctrl.linkChairMode)
                                        ? Colors.grey
                                        : isMultipleOrderInKOt
                                            ? Colors.primaries[colorCodeFromDb]
                                            : Colors.deepOrange,
                                text: 'C ${index + 1}',
                                onTap: () async {
                                  //check if clicked  in kotChair
                                  isChairHasOrder && (ctrl.chairShiftMode || ctrl.linkChairMode)
                                      ? AppSnackBar.errorSnackBar('Chair already in use!', 'Pleas select other Chair !')
                                      : await onChairTap('B', index, kotId, tbChrIndexInDb);
                                },
                              );
                            }).toList(growable: true)),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
