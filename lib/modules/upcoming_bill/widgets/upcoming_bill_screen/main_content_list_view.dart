import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:finwise/core/widgets/filter_bar.dart';
import 'package:flutter/material.dart';

class MainContentListView extends StatelessWidget {
  final int totalUpcomingBill;
  final String category;
  final double amount;

  const MainContentListView({
    super.key,
    required this.totalUpcomingBill,
    required this.category,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 77,
        bottom: 16,
      ),
      child: Column(
        children: [
          _totalBudget(),
          const SizedBox(
            height: 16,
          ),
          const FilterBar(
            filterTitles: [
              'All',
              'Tomorrow',
              'Jan 3',
              'Custom',
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          _upcomingBillCard(),
          const SizedBox(
            height: 16,
          ),
          _upcomingBillCard(),
          const SizedBox(
            height: 16,
          ),
          _upcomingBillCard(),
          const SizedBox(
            height: 16,
          ),
          _upcomingBillCard(),
        ],
      ),
    );
  }

  // Total budget
  Widget _totalBudget() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Row(
          children: [
            SizedBox(
              height: 36,
              width: 36,
              child: IconConstant.getUpcomingBill(
                color: const Color(0xFFC64608),
              ),
            ),

            const SizedBox(
              width: 12,
            ),
            // Text
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Total upcoming bill',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF333652),
                  ),
                ),
                const SizedBox(
                  height: 1,
                ),
                Text(
                  '$totalUpcomingBill',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                    color: ColorConstant.overbudget,
                  ),
                ),
              ],
            ),
          ],
        ),
      ]),
    );
  }

  Widget _upcomingBillCard() {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: ColorConstant.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ColorConstant.overbudgetIcon,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: IconConstant.internet,
              ),
              const SizedBox(
                width: 11,
              ),
              Text(
                "Today",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  letterSpacing: 1,
                  color: ColorConstant.black,
                ),
              ),
            ],
          ),
          const Divider(
            color: Color(0xFFF2F2F2),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  letterSpacing: 0.75,
                  color: ColorConstant.mainText,
                ),
              ),
              const SizedBox(
                height: 1,
              ),
              Text(
                '\$$amount',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                  letterSpacing: 1,
                  color: ColorConstant.black,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
