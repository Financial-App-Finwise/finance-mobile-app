import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/text_style_constants/general_text_style_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SmartGoalFormItem extends StatefulWidget {
  late final String label;
  late final bool isNumber;
  final TextEditingController? controller;
  late final bool readOnly;
  late final Color color;
  final String? Function(String?)? validator;

  SmartGoalFormItem({
    super.key,
    this.label = '',
    this.isNumber = false,
    this.controller,
    this.readOnly = false,
    this.color = Colors.white,
    this.validator,
  });

  @override
  State<SmartGoalFormItem> createState() => _SmartGoalFormItemState();
}

class _SmartGoalFormItemState extends State<SmartGoalFormItem> {
  @override
  Widget build(BuildContext context) {
    return _buildFormItem();
  }

  Widget _buildFormItem() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            readOnly: widget.readOnly,
            controller: widget.controller,
            keyboardType: widget.isNumber ? TextInputType.number : null,
            inputFormatters: widget.isNumber
                ? [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,2}')),
                  ]
                : null,
            style: GeneralTextStyle.getSize(14),
            decoration: InputDecoration(
              filled: true,
              fillColor: widget.color,
              // enabledBorder: OutlineInputBorder(
              //   borderSide: BorderSide.none,
              //   // borderRadius: BorderRadius.circular(12),
              // ),
              prefix: widget.isNumber ? const Text('\$') : const SizedBox(),
              isDense: true,
              // border: OutlineInputBorder(
              //   borderSide: BorderSide.none,
              //   borderRadius: BorderRadius.circular(12),
              // ),
              border: InputBorder.none,
              // hintText: '0',
              label: Text(widget.label),
              floatingLabelStyle:
                  GeneralTextStyle.getSize(14, color: ColorConstant.thin),
              labelStyle:
                  GeneralTextStyle.getSize(12, color: ColorConstant.thin),
              contentPadding: EdgeInsets.zero,
            ),
            validator: widget.validator,
          ),
        ],
      ),
    );
  }
}
