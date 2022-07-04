import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_round_mini_btn.dart';
import 'kot_bill_widget.dart';

void showKotBillAlert({required String type, required List<dynamic> billingItems}){
  Get.defaultDialog(
      title: '',
      backgroundColor: Colors.transparent,
      titleStyle: const TextStyle(color: Colors.white),
      middleTextStyle: TextStyle(color: Colors.white),
      radius: 30,
      confirm: AppRoundMiniBtn(text: 'Print',color: Colors.green, onTap: (){}),
      cancel: AppRoundMiniBtn(text: 'Close',color: Colors.red, onTap: (){Get.back();}),
      content:  KotBillWidget(type: type, billingItems:billingItems ,));
}