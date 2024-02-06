import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/text_style_constants/home_text_style_constant.dart';
import 'package:flutter/material.dart';

class ViewMoreTextButton extends StatelessWidget {
  const ViewMoreTextButton({
    super.key,
    required this.onPressed,
  });

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
        ),
      ),
      child: const Row(
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
