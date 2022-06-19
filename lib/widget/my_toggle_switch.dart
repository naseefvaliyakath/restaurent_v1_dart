import 'package:flutter/cupertino.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../app_constans/app_colors.dart';

class MyToggleSwich extends StatelessWidget {
  final Function onToggle;
  final bool value;

  const MyToggleSwich({Key? key, required this.onToggle, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      inactiveText: 'Full',
      activeText: 'Loos',
      inactiveColor: AppColors.mainColor_2,
      height: 28.0,
      width: 70,
      valueFontSize: 12.0,
      toggleSize: 20.0,
      value: value,
      borderRadius: 50.0,
      padding: 5,
      showOnOff: true,
      onToggle: (val) {
        onToggle(val);
      },
    );
  }
}
