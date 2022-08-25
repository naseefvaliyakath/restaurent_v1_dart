import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:restowrent_v_two/app_constans/app_colors.dart';
import 'package:restowrent_v_two/screens/kitchen_mode/kitchen_mode_main/controller/kitchen_mode_main_controller.dart';

import '../../model/kitchen_order_response/kitchen_order.dart';
import '../big_text.dart';

class KitchenOrderPopupAlert extends StatelessWidget {
  final KitchenOrder kitchenOrder;
  const KitchenOrderPopupAlert({
    Key? key, required this.kitchenOrder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<KitchenModeMainController>(builder: (ctrl) {
      return InkWell(
        onTap: () {
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(4, 6),
                  blurRadius: 4,
                  color: Colors.black.withOpacity(0.3),
                )
              ],
              border: Border.all(color: Colors.deepOrange, width: 3.sp)),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(3.sp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BigText(text: '!! ALERT !!',),
                        10.verticalSpace,
                        FittedBox(
                          child: Text(
                            kitchenOrder.fdOrderType,
                            softWrap: false,
                            style: TextStyle(
                              fontSize: 21.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.fade,
                          ),
                        ),
                        5.verticalSpace,
                        FittedBox(
                          child: Text(
                            kitchenOrder.fdOrderStatus,
                            softWrap: false,
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.fade,
                          ),
                        ),
                        5.verticalSpace,
                        FittedBox(
                          child: Text(
                            'ID : ${kitchenOrder.Kot_id}',
                            softWrap: false,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.mainColor_2,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.fade,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 10.sp,
                            ),
                            Text(
                              '5 Min',
                              style: TextStyle(fontSize: 10.sp),
                            )
                          ],
                        )
                      ],
                    ),
                    5.verticalSpace,
                    Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                      FittedBox(
                        child: Text(
                          kitchenOrder.fdOrder?.first.name ?? '',
                          softWrap: false,
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: AppColors.mainColor,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      5.verticalSpace,
                      FittedBox(
                        child: Text(
                          'Total Items : ${kitchenOrder.fdOrder?.length ?? 0}',
                          softWrap: false,
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      5.verticalSpace,
                      FittedBox(
                        child: Text(
                          '26-04-2020',
                          softWrap: false,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.black.withOpacity(0.3),
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      5.verticalSpace,
                    ]),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
