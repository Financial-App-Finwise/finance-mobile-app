import 'package:finwise/core/constants/color_constant.dart';
import 'package:flutter/material.dart';

class SwitchInput extends StatefulWidget {
  const SwitchInput({super.key});

  @override
  State<SwitchInput> createState() => _SwitchInputState();
}

class _SwitchInputState extends State<SwitchInput> {
  bool _isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: _isSwitched,
      onChanged: (value) {
        setState(
          () {
            _isSwitched = value;
          },
        );
      },
      activeColor: ColorConstant.primary,
      inactiveThumbColor: ColorConstant.white,
      inactiveTrackColor: const Color(0xFFD3D5E4),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      splashRadius: 0,
    );
  }
}
