import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:flutter/material.dart';

class SmartGoalOverview extends StatelessWidget {
  final String achieved;
  final String saved;
  final String leftToSave;
  final String targetAmount;

  const SmartGoalOverview({
    super.key,
    required this.achieved,
    required this.saved,
    required this.leftToSave,
    required this.targetAmount,
  });

  @override
  Widget build(BuildContext context) {
    return _budgetOverviewCard();
  }

  // smart goal overview card
  Widget _budgetOverviewCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          // border: Border.all(color: Color(0xffE9EAF1)),
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: _budgetOverviewCardSection(
                    IconConstant.getAward(color: ColorConstant.income),
                    'Achieved',
                    achieved,
                    ColorConstant.black,
                  ),
                ),
                const SizedBox(width: 4),
                const VerticalDivider(color: Color(0xFFF2F2F2)),
                const SizedBox(width: 4),
                Expanded(
                  child: _budgetOverviewCardSection(
                    IconConstant.getSave(color: ColorConstant.income),
                    'Saved',
                    saved,
                    ColorConstant.black,
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Color(0xFFF2F2F2)),
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: _budgetOverviewCardSection(
                    IconConstant.getHourGlass(color: ColorConstant.income),
                    'Left to Save',
                    leftToSave,
                    ColorConstant.black,
                  ),
                ),
                const SizedBox(width: 4),
                const VerticalDivider(color: Color(0xFFF2F2F2)),
                const SizedBox(width: 4),
                Expanded(
                  child: _budgetOverviewCardSection(
                    IconConstant.getTargetAmount(color: ColorConstant.income),
                    'Target Amount',
                    targetAmount,
                    ColorConstant.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // smart goal overview section
  Widget _budgetOverviewCardSection(
    Widget icon,
    String category,
    String amount,
    Color textColor,
  ) {
    return Container(
      alignment: Alignment.center,
      child: Row(
        children: [
          icon,
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  category,
                  maxLines: 2,
                  softWrap: true,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF333652),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '\$$amount',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
