import 'package:finwise/core/constants/color_constant.dart';
import 'package:flutter/material.dart';

class TipText extends StatelessWidget {
  final String title;
  final String description;
  final String? icon;

  const TipText({
    super.key,
    required this.title,
    required this.description,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF25CBEB).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              icon ?? '☝️',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
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
