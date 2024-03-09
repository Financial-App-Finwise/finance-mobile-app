import 'package:dio/dio.dart';
import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/modules/onboarding_question/stores/onboarding_question_store.dart';
import 'package:finwise/modules/onboarding_question/widgets/onboarding_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class MoneyOption extends StatefulWidget {
  final void Function(int) setMoney;

  const MoneyOption({super.key, required this.setMoney});

  @override
  State<MoneyOption> createState() => _MoneyOptionState();
}

class _MoneyOptionState extends State<MoneyOption> {
  Map<String, int> moneyOption = {
    '\$1k': 1000,
    '\$5k': 5000,
    '\$10k': 10000,
    '\$50k': 50000,
    '\$100k': 100000,
    '\$1M': 1000000,
    '\$5M': 5000000,
    '\$10M': 10000000,
    '\$50M': 50000000,
    '\$100M': 100000000,
    '\$500M': 500000000,
    '\$1B': 1000000000,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              height: 28,
              width: 28,
              child: IconHelper.getSVGDefault(
                SVGName.pandaFinancialSnapshot,
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            const Text(
              'or select one option below ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                height: 1.5,
                letterSpacing: 1,
                color: ColorConstant.black,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          width: double.infinity,
          child: Wrap(
            alignment: WrapAlignment.start,
            spacing: 12,
            runSpacing: 12,
            children: [
              for (var entry in moneyOption.entries)
                _amountButton(
                  entry.key,
                  entry.value,
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _amountButton(String text, int value) {
    return Observer(builder: (context) {
      int storeValue =
          context.read<OnboardingQuestionStore>().saveForGoalMoneyOption;

      return InkWell(
        onTap: () {
          widget.setMoney(value);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 12,
          ),
          decoration: storeValue != value
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xFFD3D5E4).withOpacity(0.3))
              : BoxDecoration(
                  color: const Color(0xFFECFDFF).withOpacity(0.5),
                  border: Border.all(
                    color: ColorConstant.secondary,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              letterSpacing: 0.75,
              color: ColorConstant.black,
            ),
          ),
        ),
      );
    });
  }
}
