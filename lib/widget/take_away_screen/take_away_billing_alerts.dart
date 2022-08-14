import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../app_constans/app_colors.dart';
import '../../screens/take_away_billing screen/controller/take_away_controller.dart';
import '../app_min_button.dart';
import '../big_text.dart';
import '../delete_biiling_alert_edit_food_dody.dart';
import '../dialog_button.dart';
import '../food_billing_alert_body.dart';
import '../mid_text.dart';
import '../myDialogBody.dart';
import '../text_field_widget.dart';
import 'billing_alert_food.dart';

class TakeAwayBillingAlert {
  static foodBillingAlert(
    context, {
    required img,
    required fdId,
    required name,
    required price,
  }) async {
    //ktNote textField controller
    TextEditingController ktNoteController = TextEditingController();

    // set price to controller variable
    await Get.find<TakeAwayController>().updatePriceFirstTime(price);

    // set quantity zero
    await Get.find<TakeAwayController>().setQntToZero();

    AwesomeDialog(
      customHeader: BillingAlertFood(
        img: img,
      ),
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.INFO,
      body: GetBuilder<TakeAwayController>(builder: (ctrl) {
        return FoodBillingAlertBody(
          name: name,
          count: ctrl.count,
          addFoodToBill: () {
            ctrl.addFoodToBill(
              fdId ?? 0,
              name ?? '',
              ctrl.count,
              ctrl.price,
              ktNoteController.text,
            );
            Navigator.pop(context);
          },
          ktTextCtrl: ktNoteController,
          qntIncrement: () {
            ctrl.incrementQnt();
          },
          qntDecrement: () {
            ctrl.decrimentQnt();
          },
          priceIncrement: () {
            ctrl.incrementPrice();
          },
          priceDecrement: () {
            ctrl.decrimentPrice();
          },
          price: ctrl.price,
        );
      }),
    ).show();
  }

  static deleteItemFromBillAlert(context, index) async {
    // ktNote textfiels controller
    TextEditingController ktNoteController = TextEditingController();
    // on first time if kitchen note then update from bill list
    ktNoteController.text = Get.find<TakeAwayController>().billingItems[index]['ktNote'];
    //set edit options hide first time
    await Get.find<TakeAwayController>().setIsVisibleEditBillItemFales();
    //update price from list of bills
    await Get.find<TakeAwayController>().updatePriceFirstTime(Get.find<TakeAwayController>().billingItems[index]['price']);
    //update qnt from list of bills
    await Get.find<TakeAwayController>().updateQntFirstTime((Get.find<TakeAwayController>().billingItems[index]['qnt']));

    AwesomeDialog(
      context: context,
      dialogType: DialogType.QUESTION,
      headerAnimationLoop: false,
      animType: AnimType.BOTTOMSLIDE,
      body: GetBuilder<TakeAwayController>(builder: (ctrl) {
        return Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.sp),
              child: MidText(
                text: '',
              ),
            ),
            10.verticalSpace,
            Visibility(
              visible: ctrl.isVisibleEditBillItem,
              child: DeleteBillingAlertEditBillBody(
                ktTextCtrl: ktNoteController,
                priceDecrement: () {
                  ctrl.decrimentPrice();
                },
                priceIncrement: () {
                  ctrl.incrementPrice();
                },
                qntIncrement: () {
                  ctrl.incrementQnt();
                },
                qntDecrement: () {
                  ctrl.decrimentQnt();
                },
                price: ctrl.price,
                count: ctrl.count,
              ),
            ),
          ],
        );
      }),
      buttonsTextStyle: const TextStyle(color: Colors.black,),
      showCloseIcon: true,
      btnCancel: GetBuilder<TakeAwayController>(builder: (ctrl) {
        return DialogButton(
          icon: Icons.delete,
          onPressd: () async {
            Navigator.pop(context);
            await ctrl.removeFoodFromBill(index);
          },
          text: 'Delete',
          bgColor: Colors.redAccent,
        );
      }),
      btnOk: GetBuilder<TakeAwayController>(builder: (ctrl) {
        return DialogButton(
          icon: ctrl.isVisibleEditBillItem ? Icons.update : Icons.edit,
          onPressd: () {
            if (!ctrl.isVisibleEditBillItem) {
              ctrl.setIsVisibleEditBillItem(true);
            } else {
              ctrl.updateFodToBill(index, ctrl.count, ctrl.price, ktNoteController.text);
              Navigator.pop(context);
            }
          },
          text: ctrl.isVisibleEditBillItem ? 'Update' : 'Edit',
          bgColor: Colors.green,
        );
      }),
    ).show();
  }

  // confirmation for save bill data before close
  static void askConfirm(context) {
    MyDialogBody.myConfirmDialogBody(
      context: context,
      title: 'Hold the items ?',
      desc: 'Do you Want to hold the  item entered ?',
      btnCancelText: 'No',
      btnOkText: 'Yes',
      onTapOK: () async {
        await Get.find<TakeAwayController>().saveBillInHive();
        Navigator.pop(context);
        Navigator.pop(context, true);
      },
      onTapCancel: () async {
        await Get.find<TakeAwayController>().clearBillInHive();
        Navigator.pop(context);
        Navigator.pop(context, true);
      },
    );
    /*AwesomeDialog(
      context: context,
      dialogType: DialogType.QUESTION,
      headerAnimationLoop: false,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Hold the items ?',
      desc: 'Do you Want to hold the  item entered ?',
      buttonsTextStyle:TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 18.sp),
      showCloseIcon: true,
      btnCancelOnPress: () async {
        await Get.find<TakeAwayController>().clearBillInHive();
        Navigator.pop(context, true);
      },
      btnCancelText: ' No',
      btnOkOnPress: () async {
        await Get.find<TakeAwayController>().saveBillInHive();
        Navigator.pop(context, true);
      },
      btnOkText: ' Yes',
    ).show();*/
  }
}
