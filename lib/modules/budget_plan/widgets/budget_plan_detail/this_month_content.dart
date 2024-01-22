import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/widgets/progress_card.dart';
import 'package:flutter/material.dart';

class ThisMonthContent extends StatelessWidget {
  final int transaction;
  final int total;
  final int remain;
  final int spent;

  const ThisMonthContent({
    super.key,
    required this.transaction,
    required this.total,
    required this.remain,
    required this.spent,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'This Month',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF191B29),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
          color: const Color(0xFFFFFFFF),
          padding: const EdgeInsets.all(16),
          child: ProgressCard(
              color: ColorConstant.expense,
              transaction: transaction,
              remain: remain,
              total: total,
              spent: spent),
        ),
      ],
    );
  }
}
