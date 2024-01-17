import 'package:finwise/core/constants/text_style_constant.dart';
import 'package:flutter/material.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({
    super.key,
    required this.controller,
    this.hintText = '',
    required this.prefixIcon,
    this.obscureText = false,
    this.onChanged,
  });

  final TextEditingController controller;
  final String hintText;
  final Widget prefixIcon;
  final bool obscureText;
  final void Function(String)? onChanged;

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Color(0xffF2F3F7),
      ),
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        style: AuthScreenTextStyle.formText,
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: AuthScreenTextStyle.formHint,
          prefixIcon: Container(
            margin: EdgeInsets.all(16),
            child: widget.prefixIcon,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
        obscureText: widget.obscureText,
        validator: (value) {
          // TODO
          if (value!.isEmpty) {
            return 'Please enter...';
          }
        },
        onChanged: widget.onChanged,
      ),
    );
  }
}
