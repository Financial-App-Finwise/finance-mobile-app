import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/widgets/custom_progess_bar.dart';
import 'package:flutter/material.dart';

class BudgetCard extends StatelessWidget {
  final Widget screen;
  final String title;
  final Color color;
  final int transaction;
  final int remain;
  final int total;
  final int spent;

  const BudgetCard({
    super.key,
    required this.screen,
    this.title = 'title',
    this.color = Colors.black,
    this.transaction = 0,
    this.remain = 0,
    this.total = 0,
    this.spent = 0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => screen,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ColorConstant.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: color, borderRadius: BorderRadius.circular(4)),
                  child: Icon(
                    Icons.car_rental_outlined,
                    color: ColorConstant.white,
                  ),
                ),
                const SizedBox(
                  width: 11,
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF000000),
                  ),
                ),
              ],
            ),
            const Divider(
              color: Color(0xFFF2F2F2),
            ),
            // _card(),
          ],
        ),
      ),
    );
  }

  Widget _card() {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstant.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    '$transaction',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF191B29),
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(
                    'transactions',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: ColorConstant.mainText,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    '\$$remain',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF191B29),
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(
                    'left',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: ColorConstant.mainText,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          CustomProgressBar(
            value: ((spent * 10) / total) / 10,
            color: color,
          ),
          const SizedBox(
            height: 6,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    '\$$spent',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF191B29),
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(
                    'spent',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: ColorConstant.mainText,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    'out of',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF333652),
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(
                    '\$$total',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF191B29),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
