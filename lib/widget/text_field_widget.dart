import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_constans/app_colors.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final int maxLIne;
  final double borderRadius;
  final double? width;
  final double? hintSize;
  final bool readonly;
  final Function onChange;
  final bool? isDens;
  final bool autoFocus;
  final TextInputType keybordType;

   const TextFieldWidget(
      {Key? key,
      required this.textEditingController,
      required this.hintText,
      this.maxLIne = 1,
      this.readonly = false,
      required this.borderRadius, this.isDens = false, this.width, this.hintSize, this.autoFocus = false,
      this.keybordType = TextInputType.text, required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.maxFinite,
      child: TextField(
        keyboardType: keybordType,
        controller: textEditingController,
        maxLines: maxLIne,
        readOnly: readonly,
        autofocus: autoFocus,
        onChanged: (value){
          onChange(value);
        },
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle:  TextStyle(color: AppColors.textGrey,fontSize: hintSize ?? 18.w,),
          filled: true,
          isDense: isDens,
          fillColor: AppColors.textHolder,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: Colors.white, width: 1.sp)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: Colors.white, width: 1.sp)),
        ),
      ),
    );
  }
}
