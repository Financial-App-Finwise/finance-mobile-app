import 'package:finwise/core/constants/color_constant.dart';
import 'package:flutter/material.dart';

class CustomSliderInput extends StatelessWidget {
  final double inputValue;
  final void Function(double) changeInput;

  const CustomSliderInput({
    super.key,
    required this.inputValue,
    required this.changeInput,
  });

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: inputValue,
      min: 0,
      max: 100,
      divisions: 10,
      label: inputValue.round().toString(),
      onChanged: changeInput,
      activeColor: ColorConstant.secondary,
      inactiveColor: ColorConstant.secondary.withOpacity(0.5),
      thumbColor: ColorConstant.white,
    );
  }
}
