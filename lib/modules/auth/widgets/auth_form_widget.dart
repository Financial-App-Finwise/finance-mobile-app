import 'package:finwise/core/constants/auth_text_style_constant.dart';
import 'package:finwise/core/constants/color_constant.dart';
import 'package:flutter/material.dart';

class FormWidget extends StatefulWidget {
  FormWidget({
    super.key,
    // this.backgroundColor
    required this.controller,
    this.hintText = '',
    required this.prefixIcon,
    this.obscureText = false,
    this.onChanged,
    this.validator,
    this.onEditingComplete,
  });

  // final Color backgroundColor;
  final TextEditingController controller;
  final String hintText;
  final Widget prefixIcon;
  bool obscureText;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final void Function()? onEditingComplete;

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  late bool _isPassword = widget.obscureText;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: ColorConstant.backgroundColor,
      ),
      child: TextFormField(
        
        textAlignVertical: TextAlignVertical.center,
        style: AuthScreenTextStyle.formText,
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: AuthScreenTextStyle.formHint,
          prefixIcon: Container(
            margin: const EdgeInsets.all(16),
            child: widget.prefixIcon,
          ),
          suffix: _isPassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      widget.obscureText = !widget.obscureText;
                    });
                  },
                  icon: Icon(
                    widget.obscureText
                        ? Icons.visibility
                        : Icons.visibility_off,
                        size: 10,
                  ),
                )
              : SizedBox(),
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
        obscureText: widget.obscureText,
        validator: widget.validator,
        onChanged: widget.onChanged,
        onEditingComplete: widget.onEditingComplete,
      ),
    );
  }
}
