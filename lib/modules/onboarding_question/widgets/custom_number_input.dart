import 'package:finwise/core/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomNumberInput extends StatefulWidget {
  final String label;
  String hintText;
  final TextEditingController controller;
  final void Function(String)? onChange;
  final bool? isMoney;

  CustomNumberInput({
    Key? key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.isMoney,
    this.onChange,
  }) : super(key: key);

  @override
  _CustomNumberInputState createState() => _CustomNumberInputState();
}

class _CustomNumberInputState extends State<CustomNumberInput> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
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
        TextField(
          controller: widget.controller,
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
            prefixText: widget.isMoney == null
                ? ''
                : widget.isMoney!
                    ? '\$'
                    : '',
            alignLabelWithHint: true,
            hintText: widget.hintText,
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
            fillColor: ColorConstant.white,
          ),
          focusNode: _focusNode,
          onTap: () {
            setState(() {
              widget.hintText = '';
            });
          },
          onChanged: widget.onChange,
        ),
      ],
    );
  }
}
