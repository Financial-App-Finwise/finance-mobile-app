import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
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
        fontSize: 20,
        letterSpacing: 1,
        color: ColorConstant.expenseIcon,
      ),
      decoration: InputDecoration(
          hintText: "Total Amount",
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            letterSpacing: 1,
            color: Color(0xFFA4A7C6),
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 6,
            ),
            child: IconHelper.getSVG(
              SVGName.dollarSquare,
              color: ColorConstant.expenseIcon,
            ),
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 24,
            minHeight: 24,
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
