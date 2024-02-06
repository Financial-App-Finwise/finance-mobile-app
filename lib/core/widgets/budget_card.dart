import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/text_style_constants/home_text_style_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:finwise/core/widgets/custom_progess_bar.dart';
import 'package:flutter/material.dart';
import 'package:simple_progress_indicators/simple_progress_indicators.dart';

class BudgetCard extends StatelessWidget {
  final Widget screen;
  final String title;
  final Widget? icon;
  final Color color;
  final Widget? topLeft;
  final Widget? topRight;
  final Widget? bottomLeft;
  final Widget? bottomRight;

  final int transaction;
  final int remain;
  final int total;
  final int spent;

  const BudgetCard({
    super.key,
    required this.screen,
    this.icon,
    this.title = 'title',
    this.color = Colors.black,
    this.topLeft,
    this.topRight,
    this.bottomLeft,
    this.bottomRight,
    this.transaction = 0,
    this.remain = 0,
    this.total = 1,
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
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ColorConstant.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xffE9EAF1)),
        ),
        child: IntrinsicWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: IconConstant.getSchoolBus(),
                  ),
                  const SizedBox(width: 11),
                  Text(
                    title,
                    style: HomeTextStyleConstant.budgetCardTitle,
                  ),
                ],
              ),
              const Divider(color: Color(0xFFF2F2F2)),
              _buildProgress(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgress() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                topLeft ?? SizedBox(),
                topRight ?? SizedBox(),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Center(
            child: ProgressBar(
              value:
                  spent <= total ? (total <= 0 ? 0 : spent / total) : 1,
              //specify only one: color or gradient
              //color:Colors.red,
              backgroundColor: Color(0xffEDF2F7),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xffFBA6A6), ColorConstant.expense],
              ),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              bottomLeft ?? SizedBox(),
              bottomRight ?? SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
