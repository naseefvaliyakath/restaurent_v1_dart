import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restowrent_v_two/widget/text_field_widget.dart';
import '../app_constans/app_colors.dart';
import 'app_min_button.dart';
import 'big_text.dart';

class FoodBillingAlertBody extends StatelessWidget {
  final String name;
  final Function qntDecrement;
  final Function qntIncrement;
  final Function priceDecrement;
  final Function priceIncrement;
  final int count;
  final double price;
  final TextEditingController ktTextCtrl;
  final Function addFoodToBill;

  const FoodBillingAlertBody({Key? key, required this.name, required this.qntDecrement, required this.qntIncrement, required this.priceDecrement, required this.priceIncrement, required this.count, required this.price, required this.ktTextCtrl, required this.addFoodToBill}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            name,
            style: TextStyle(fontSize: 20.sp, color: AppColors.titleColor, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          10.verticalSpace,
          //price and qnt btn
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: Wrap(direction: Axis.vertical, crossAxisAlignment: WrapCrossAlignment.center, children: [
                  BigText(
                    text: 'QUANTITY',
                    size: 15.sp,
                  ),
                  Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        10.horizontalSpace,
                        IconButton(
                          icon: const Icon(
                            Icons.remove_circle,
                          ),
                          onPressed: () {
                            qntDecrement;
                          },
                          iconSize: 24.w,
                          color: Colors.black54,
                        ),
                        5.horizontalSpace,
                        BigText(
                          text: count.toString(),
                          size: 15.w,
                          color: AppColors.titleColor,
                        ),
                        5.horizontalSpace,
                        IconButton(
                          icon: const Icon(
                            Icons.add_circle,
                          ),
                          onPressed: () {
                            qntIncrement();
                          },
                          iconSize: 24.w,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
              Flexible(
                child: Wrap(direction: Axis.vertical, crossAxisAlignment: WrapCrossAlignment.center, children: [
                  BigText(
                    text: 'PRICE',
                    size: 15.sp,
                  ),
                  Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        10.horizontalSpace,
                        IconButton(
                          icon: const Icon(
                            Icons.remove_circle,
                          ),
                          onPressed: () {
                            priceDecrement();
                          },
                          iconSize: 24.w,
                          color: Colors.black54,
                        ),
                        5.horizontalSpace,
                        BigText(
                          text: price.toString(),
                          size: 15.w,
                          color: AppColors.titleColor,
                        ),
                        5.horizontalSpace,
                        IconButton(
                          icon: const Icon(
                            Icons.add_circle,
                          ),
                          onPressed: () {
                            priceIncrement();
                          },
                          iconSize: 24.w,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          ),
          10.verticalSpace,
          //kitchen text
          TextFieldWidget(
            borderRadius: 10.r,
            hintText: 'Add Kitchen Text',
            textEditingController: ktTextCtrl,
            maxLIne: 2, onChange: (_) {},
          ),
          10.verticalSpace,
          AppMIniButton(text: 'Add Item', bgColor: AppColors.mainColor,
              onTap: (){
                addFoodToBill();
          })
          ,
          5.verticalSpace,
        ],
      ),
    );
  }
}
