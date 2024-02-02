import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/general_text_style_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:finwise/core/widgets/general_filter_bar.dart';
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
      gradient: LinearGradient(
        colors: [
          ColorConstant.secondary,
          ColorConstant.primary,
        ],
        stops: [0, 1],
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: _buildRectangle('All', isFocused: true)),
                Expanded(child: _buildRectangle('Income')),
                Expanded(child: _buildRectangle('Expense')),
              ],
            ),
            SizedBox(height: 16),
            GeneralFilterBar(
              filterTitles: [
                'All',
                'Recently',
                'Earliest',
                'Lowest',
                'Highest',
              ],
              children: [
                _buildFilteredTransactions(),
                SizedBox(),
                SizedBox(),
                SizedBox(),
                SizedBox(),
              ],
            ),
            SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildRectangle(String text, {bool isFocused = false}) {
    return TextButton(
      onPressed: () {},
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
      ),
      child: Container(
        padding: EdgeInsets.all(8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color:
                  isFocused ? ColorConstant.primary : ColorConstant.colorE9EAF1,
            ),
          ),
        ),
        child: Text(text,
            style: GeneralTextStyle.getSize(
              16,
              color: isFocused ? ColorConstant.primary : ColorConstant.mainText,
            )),
      ),
    );
  }

  Widget _buildFilteredTransactions() {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
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
        return SizedBox(height: 8);
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
          SizedBox(width: 12),
          Expanded(child: Divider(color: ColorConstant.divider))
        ]),
        SizedBox(height: 12),
        RoundedContainer(
          child: ListView.separated(
            physics: NeverScrollableScrollPhysics(),
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
              return Divider(color: ColorConstant.divider);
            },
          ),
        ),
      ],
    );
  }
}
