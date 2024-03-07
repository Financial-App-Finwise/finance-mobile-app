import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/modules/onboarding_question/models/spending_model.dart';
import 'package:flutter/material.dart';

class TimePeroidInput extends StatelessWidget {
  final void Function(String) changeType;
  final String selectedType;

  const TimePeroidInput({
    super.key,
    required this.changeType,
    required this.selectedType,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xD3D5E480),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              _button('Daily', selectedType == 'Daily'),
              _button('Weekly', selectedType == 'Weekly'),
              _button('Monthly', selectedType == 'Monthly'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _button(String name, bool isSelected) {
    return InkWell(
      onTap: () {
        changeType(name);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 6,
          horizontal: 6,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: isSelected ? ColorConstant.white : Colors.transparent),
        child: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            letterSpacing: 1,
            color: ColorConstant.black,
          ),
        ),
      ),
    );
  }
}
