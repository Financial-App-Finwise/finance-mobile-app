import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/text_style_constants/general_text_style_constant.dart';
import 'package:flutter/material.dart';

class GeneralOutlineButton extends StatelessWidget {
  const GeneralOutlineButton({
    super.key,
    this.buttonLabel = 'Button',
    this.onButtonTap,
    this.labelColor = ColorConstant.secondary,
    this.allowPressing = true,
  });

  final String buttonLabel;
  final void Function()? onButtonTap;
  final Color labelColor;
  final bool allowPressing;

  @override
  Widget build(BuildContext context) {
    return _buildButton();
  }

  Widget _buildButton() {
    return TextButton(
      onPressed: onButtonTap,
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        padding:
            MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 16)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            side: BorderSide(color: labelColor),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        child: Text(
          buttonLabel,
          style: GeneralTextStyle.getSize(16, color: labelColor)
              .copyWith(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
