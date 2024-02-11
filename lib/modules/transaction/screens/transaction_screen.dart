import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/text_style_constants/general_text_style_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:finwise/core/widgets/general_filter_bar/general_filter_bar.dart';
import 'package:finwise/core/widgets/general_filter_bar/rect_filter_bar.dart';
import 'package:finwise/core/widgets/general_simple_header_layout.dart';
import 'package:finwise/core/widgets/rounded_container.dart';
import 'package:finwise/core/widgets/transaction_item.dart';
import 'package:flutter/material.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return GeneralSimpleHeaderLayout(
      title: 'All transactions',
      description:
          'Explore a detailed breakdown of your financial transactions.',
      gradient: const LinearGradient(
        colors: [
          ColorConstant.secondary,
          ColorConstant.primary,
        ],
        stops: [0, 1],
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 8),
            RectFilterBar(
              filterTitles: const [
                'All',
                'Income',
                'Expense',
              ],
              topSpace: 0,
              fontSize: 16,
            ),
            const SizedBox(height: 16),
            GeneralFilterBar(
              filterTitles: const [
                'All',
                'Recently',
                'Earliest',
                'Lowest',
                'Highest',
              ],
              children: [
                _buildFilteredTransactions(),
                const SizedBox(),
                const SizedBox(),
                const SizedBox(),
                const SizedBox(),
              ],
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildFilteredTransactions() {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (context, index) {
        return InkWell(
          // onTap: () {
          //   Navigator.pushNamed(context, RouteName.smartGoalDetail);
          // },
          child: _buildTransactionItemsDays(),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 8);
      },
    );
  }

  // Widget _buildTransactionItems({bool isIncome = true}) {
  //   return Column(
  //     children: [
  //       SizedBox(height: 12),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Text('All Transactions', style: GeneralTextStyle.getHeader()),
  //           ViewMoreTextButton(
  //             onPressed: () {
  //               // go to transaction screens
  //               Navigator.pushNamed(context, RouteName.transaction);
  //             },
  //           ),
  //         ],
  //       ),
  //       SizedBox(height: 12),
  //       _buildTransactionItemsDays(isIncome: isIncome),
  //       SizedBox(height: 16),
  //       _buildTransactionItemsDays(day: 'Yesterday', isIncome: isIncome),
  //     ],
  //   );
  // }

  Widget _buildTransactionItemsDays({
    String? day,
    bool isIncome = true,
  }) {
    return Column(
      children: [
        Row(children: [
          Text(day ?? 'Today', style: GeneralTextStyle.getSize(14)),
          const SizedBox(width: 12),
          const Expanded(child: Divider(color: ColorConstant.divider))
        ]),
        const SizedBox(height: 12),
        RoundedContainer(
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 2,
            itemBuilder: ((context, index) {
              return TransactionItem(
                icon: isIncome
                    ? IconConstant.getEarn()
                    : IconConstant.getExpense(),
                color: isIncome ? ColorConstant.income : ColorConstant.expense,
              );
            }),
            separatorBuilder: (context, index) {
              return const Divider(color: ColorConstant.divider);
            },
          ),
        ),
      ],
    );
  }
}
