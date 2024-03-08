import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/text_style_constants/general_text_style_constant.dart';
import 'package:flutter/material.dart';

class GeneralBottomButton extends StatelessWidget {
  const GeneralBottomButton({
    super.key,
    this.buttonLabel = 'Button',
    this.onButtonTap,
    this.backgroundColor = ColorConstant.secondary,
  });

  final String buttonLabel;
  final void Function()? onButtonTap;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return _buildButton();
  }

  Widget _buildButton() {
    return ElevatedButton(
      onPressed: onButtonTap,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 16)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        child: Text(
          buttonLabel,
          style: GeneralTextStyle.getSize(16, color: Colors.white)
              .copyWith(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
