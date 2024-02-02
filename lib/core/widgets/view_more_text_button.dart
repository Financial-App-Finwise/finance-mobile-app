import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/home_text_style_constant.dart';
import 'package:flutter/material.dart';

class ViewMoreTextButton extends StatefulWidget {
  ViewMoreTextButton({
    super.key,
    required this.onPressed,
  });

  final void Function() onPressed;

  @override
  State<ViewMoreTextButton> createState() => _ViewMoreTextButtonState();
}

class _ViewMoreTextButtonState extends State<ViewMoreTextButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(vertical: 0, horizontal: 8),
        ),
      ),
      child: Row(
        children: [
          Text('View More', style: HomeTextStyleConstant.headerBoldLink),
          SizedBox(width: 6),
          Icon(
            Icons.arrow_forward,
            color: ColorConstant.totalIcon,
          ),
        ],
      ),
    );
  }
}
