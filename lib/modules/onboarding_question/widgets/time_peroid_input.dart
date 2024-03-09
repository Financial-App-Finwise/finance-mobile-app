import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/modules/onboarding_question/models/spending_model.dart';
import 'package:flutter/material.dart';

class TimePeroidInput extends StatefulWidget {
  final void Function(SpendingModel) changeType;
  final SpendingModel selectedType;

  const TimePeroidInput({
    super.key,
    required this.changeType,
    required this.selectedType,
  });

  @override
  State<TimePeroidInput> createState() => _TimePeroidInputState();
}

class _TimePeroidInputState extends State<TimePeroidInput> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xFFD3D5E4).withOpacity(0.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              _button(
                  SpendingModel(
                    type: 'Daily',
                    controller: widget.selectedType.controller,
                  ),
                  widget.selectedType.type == 'Daily'),
              _button(
                  SpendingModel(
                    type: 'Weekly',
                    controller: widget.selectedType.controller,
                  ),
                  widget.selectedType.type == 'Weekly'),
              _button(
                  SpendingModel(
                    type: 'Monthly',
                    controller: widget.selectedType.controller,
                  ),
                  widget.selectedType.type == 'Monthly'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _button(SpendingModel model, bool isSelected) {
    return InkWell(
      onTap: () {
        setState(() {
          widget.changeType(model);
        });
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
          model.type,
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
