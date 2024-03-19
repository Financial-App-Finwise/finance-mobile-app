import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/helpers/text_style_helper.dart';
import 'package:flutter/material.dart';

class TransactionNoteTextField extends StatefulWidget {
  final TextEditingController controller;

  const TransactionNoteTextField({
    super.key,
    required this.controller,
  });

  @override
  State<TransactionNoteTextField> createState() =>
      _TransactionNoteTextFieldState();
}

class _TransactionNoteTextFieldState extends State<TransactionNoteTextField> {
  late final _noteController = widget.controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _noteController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        labelText: 'Note (Optional)',
        floatingLabelStyle:
            TextStyleHelper.getw400size(14, color: ColorConstant.thin),
        labelStyle: TextStyleHelper.getw400size(14, color: ColorConstant.thin),
        alignLabelWithHint: true,
      ),
      maxLines: 3,
    );
  }
}
