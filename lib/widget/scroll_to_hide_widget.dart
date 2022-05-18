import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScroollToHide extends StatefulWidget {
  final Widget child;
  final ScrollController controller;
  final Duration durations;

  const ScroollToHide(

      {Key? key,
      required this.child,
      required this.controller,
      this.durations = const Duration(milliseconds: 200)})
      : super(key: key);

  @override
  State<ScroollToHide> createState() => _ScroollToHideState();
}

class _ScroollToHideState extends State<ScroollToHide> {
  bool isVisible = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.controller.addListener(listner);

  }

  @override
  void dispose() {
    // TODO: implement dispose
    widget.controller.removeListener(listner);
    super.dispose();
  }

  void listner() {
    final direction = widget.controller.position.userScrollDirection;
    print('dddd');
    if (direction == ScrollDirection.forward) {
      show();
    } else if (direction == ScrollDirection.reverse) {
      hide();
    }
    print(direction.toString());
/*    if(widget.controller.position.pixels >= 200){
      hide();
    }
    else{
      show();
    }*/
  }

  void show() {
    if (!isVisible) {
      setState(() {
        isVisible = true;
      });
    }
  }

  void hide() {
    if (isVisible) {
      setState(() {
        isVisible = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    listner();
    return AnimatedContainer(
      duration: widget.durations,
      height: isVisible ? kBottomNavigationBarHeight : 0,
      child: Wrap(
        children: [widget.child],
      ),
    );
  }
}
