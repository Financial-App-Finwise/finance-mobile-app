import 'package:finwise/core/constants/color_constant.dart';
import 'package:flutter/material.dart';

class TipText extends StatelessWidget {
  final String title;
  final String description;
  const TipText({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: Color(0xFF25CBEB1A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              '☝️',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    letterSpacing: 1,
                    height: 1.8,
                    color: ColorConstant.black,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  description,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    height: 1.8,
                    letterSpacing: 1,
                    color: ColorConstant.black,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
