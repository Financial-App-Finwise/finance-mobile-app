import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/helpers/text_style_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TransactionAmountTextField extends StatefulWidget {
  final TextEditingController controller;
  final Color color;
  final bool readOnly;
  final void Function(String)? onChanged;

  const TransactionAmountTextField({
    super.key,
    required this.controller,
    this.color = ColorConstant.income,
    this.readOnly = false,
    this.onChanged,
  });

  @override
  State<TransactionAmountTextField> createState() =>
      _TransactionAmountTextFieldState();
}

class _TransactionAmountTextFieldState
    extends State<TransactionAmountTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      readOnly: widget.readOnly,
      controller: widget.controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
      ],
      decoration: InputDecoration(
        isDense: true,
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: IconHelper.getSVG(
            SVGName.dollarSquare,
            color: widget.color,
          ),
        ),
        prefixIconConstraints: const BoxConstraints(maxHeight: 20),
        hintText: 'Total Amount',
        hintStyle: const TextStyle(
          color: ColorConstant.colorA4A7C6,
          fontSize: 20,
          fontWeight: FontWeight.w500,
          letterSpacing: 1,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 20),
      ),
      textAlignVertical: TextAlignVertical.top,
      textAlign: TextAlign.start,
      style: TextStyleHelper.getw500size(20, color: widget.color),
    );
  }
}
