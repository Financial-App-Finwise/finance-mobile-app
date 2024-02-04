import 'package:finwise/core/constants/auth_text_style_constant.dart';
import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/general_text_style_constant.dart';
import 'package:flutter/material.dart';

class GeneralBottomButton extends StatefulWidget {
  GeneralBottomButton({
    super.key,
    this.buttonLabel = 'Button',
    this.onButtonTap,
  });

  final String buttonLabel;
  final void Function()? onButtonTap;

  @override
  State<GeneralBottomButton> createState() => _GeneralBottomButtonState();
}

class _GeneralBottomButtonState extends State<GeneralBottomButton> {
  @override
  Widget build(BuildContext context) {
    return _buildButton();
  }

  Widget _buildButton() {
    return ElevatedButton(
      onPressed: widget.onButtonTap,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(ColorConstant.secondary),
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 16)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        child: Text(
          widget.buttonLabel,
          style: GeneralTextStyle.getSize(16, color: Colors.white)
              .copyWith(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
