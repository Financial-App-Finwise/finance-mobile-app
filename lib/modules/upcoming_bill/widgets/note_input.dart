import 'package:finwise/core/constants/color_constant.dart';
import 'package:flutter/material.dart';

class NoteInput extends StatelessWidget {
  final TextEditingController controller;

  const NoteInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100, // Height of the input field
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: ColorConstant.white,
      ),
      child: TextField(
        controller: controller,
        maxLines: null,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          letterSpacing: 0.75,
          color: ColorConstant.mainText,
        ),
        decoration: const InputDecoration(
          labelText: "Note (Optional)",
          labelStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12,
            letterSpacing: 0.75,
            color: ColorConstant.thin,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
