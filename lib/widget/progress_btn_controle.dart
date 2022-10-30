import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:get/get.dart';

enum ButtonState { init, loading, done }

class ProgressBtnController extends StatefulWidget {
  final Function function;
  final String text;
  final  ctrl;

  const ProgressBtnController({Key? key, required this.function, required this.text, required this.ctrl }) : super(key: key);

  @override
  State<ProgressBtnController> createState() => _ProgressBtnControllerState();
}

class _ProgressBtnControllerState extends State<ProgressBtnController> {
  ButtonState state = ButtonState.init;
  bool isAnimating = true;

  @override
  Widget build(BuildContext context) {
    final isStretched = isAnimating || state == ButtonState.init;
    final isDone = state == ButtonState.done;

    return AnimatedContainer(
        width: state == ButtonState.init ? 150.w : 45.w,
        //width: 150.w,
        height: 40.sp,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
        onEnd: () => setState(() => isAnimating = !isAnimating),
        child: isStretched
            ? GFButton(
          onPressed: () async {
            setState(() => state = ButtonState.loading);
            await widget.function();
            setState(() => state = ButtonState.done);
            await Future.delayed(const Duration(milliseconds: 1000));
            setState(() => state = ButtonState.init);
          },
          textStyle: TextStyle(fontSize: 14.sp),
          shape: GFButtonShape.pills,
          color: Colors.green,
          elevation: 4,
          child: FittedBox(
            child: Text(
              widget.text,
              softWrap: false,
              overflow: TextOverflow.clip,
              maxLines: 1,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        )
            : Obx(() {
          return Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.ctrl.socketError.value ? Colors.red : Colors.green,
            ),
            child: isDone
                ? Icon(
              widget.ctrl.socketError.value ? Icons.close : Icons.done,
              size: 30.sp,
              color: Colors.white,
            )
                : Center(
                child: Container(
                    padding: EdgeInsets.all(3.sp),
                    width: 30.sp,
                    height: 30.sp,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                    ))),
          );
        })

    );
  }
}
