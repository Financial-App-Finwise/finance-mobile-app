import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:finwise/core/helpers/ui_helper.dart';
import 'package:flutter/material.dart';

class UpcomingBillCard extends StatelessWidget {
  final String name;
  final int amount;
  final String date;

  const UpcomingBillCard({
    super.key,
    required this.name,
    required this.amount,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
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
                UIHelper.getDateFormat(date, 'dd MMM, yyyy'),
                style: const TextStyle(
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
                name,
                style: const TextStyle(
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
                style: const TextStyle(
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
