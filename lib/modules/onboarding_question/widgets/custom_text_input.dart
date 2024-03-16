import 'package:finwise/core/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextInput extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  int? textLimit;
  void Function(String)? onChange;

  CustomTextInput(
      {super.key,
      required this.label,
      required this.hintText,
      required this.controller,
      this.textLimit,
      this.onChange});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            letterSpacing: 1,
            color: ColorConstant.black,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        textInput(),
      ],
    );
  }

  Widget textInput() {
    return TextField(
      onChanged: onChange,
      controller: controller,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        letterSpacing: 0.75,
        color: ColorConstant.mainText,
      ),
      decoration: InputDecoration(
          alignLabelWithHint: true,
          hintText: hintText,
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
