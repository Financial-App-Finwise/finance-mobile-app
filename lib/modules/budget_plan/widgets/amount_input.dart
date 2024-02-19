import 'package:finwise/core/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AmountInput extends StatelessWidget {
  final TextEditingController controller;

  const AmountInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
      ],
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        letterSpacing: 0.75,
        color: ColorConstant.mainText,
      ),
      decoration: InputDecoration(
          alignLabelWithHint: true,
          label: const Text(
            'Amount',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              letterSpacing: 0.75,
              color: ColorConstant.mainText,
            ),
          ),
          prefixText: '\$',
          prefixStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            letterSpacing: 0.75,
            color: ColorConstant.mainText,
          ),
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            letterSpacing: 0.75,
            color: ColorConstant.thin,
          ),
          contentPadding: const EdgeInsets.all(20),
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          filled: true,
          fillColor: ColorConstant.white),
    );
  }
}
