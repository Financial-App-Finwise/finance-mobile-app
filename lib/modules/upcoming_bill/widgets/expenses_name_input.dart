import 'package:finwise/core/constants/color_constant.dart';
import 'package:flutter/material.dart';

class ExpenseNameInput extends StatelessWidget {
  final TextEditingController controller;

  const ExpenseNameInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        letterSpacing: 0.75,
        color: ColorConstant.mainText,
      ),
      decoration: InputDecoration(
          hintText: "Expense name (Optional)",
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
