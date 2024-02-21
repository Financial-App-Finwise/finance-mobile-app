import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/constants/text_style_constants/financial_text_style_constant.dart';
import 'package:finwise/core/constants/text_style_constants/general_text_style_constant.dart';
import 'package:finwise/core/constants/text_style_constants/home_text_style_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/models/income_expense_model/income_expense_model.dart';
import 'package:finwise/core/widgets/charts/income_expense_barchart.dart';
import 'package:finwise/core/widgets/charts/income_expense_pie_chart.dart';
import 'package:finwise/core/widgets/duration_drop_down/duration_drop_down.dart';
import 'package:finwise/core/widgets/general_filter_bar/general_filter_bar.dart';
import 'package:finwise/core/widgets/general_sticky_header_layout.dart';
import 'package:finwise/core/widgets/rounded_container.dart';
import 'package:finwise/core/widgets/transaction_item.dart';
import 'package:finwise/core/widgets/view_more_text_button.dart';
import 'package:finwise/route.dart';
import 'package:flutter/material.dart';

class FinanceScreen extends StatefulWidget {
  const FinanceScreen({super.key});

  @override
  State<FinanceScreen> createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return GeneralStickyHeaderLayout(
      title: 'My Finance',
      description:
          'Effortlessly manage your finance with a powerful simple tool in FinWise',
      gradient: const LinearGradient(
        colors: [
          ColorConstant.secondary,
          ColorConstant.primary,
        ],
        stops: [0, 1],
      ),
      centerContent: _buildCenterContent(),
      mainContent: _buildContent(),
      centerContentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }

  Widget _buildCenterContent() {
    return ListView(
      shrinkWrap: true,
      children: [
        Row(
          children: [
            IconHelper.getSVG(
              SVGName.piggyBank,
              color: ColorConstant.secondary,
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total Balance',
                    style: FiancialTextStyle.totalBalanceTitle),
                SizedBox(height: 4),
                Text(
                  '\$9645.50',
                  style: FiancialTextStyle.totalBalance,
                ),
              ],
            ),
          ],
        ),
        const Divider(color: ColorConstant.divider),
        // SizedBox(height: 10),
        TextButton(
          onPressed: () =>
              Navigator.of(context).pushNamed(RouteName.financeUpdate),
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            ),
          ),
          child: const Text(
            'Update your balance',
            style: FiancialTextStyle.updateBalance,
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return RefreshIndicator(
      onRefresh: () async {},
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                const SizedBox(height: 20),
                _buildBarChart(),
                const SizedBox(height: 12),
                _buildIncomeExpense(),
                const SizedBox(height: 16),
                _buildIncomeExpenseFilter(),
                const SizedBox(height: 48),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBarChart() {
    return IncomeExpenseBarChart();
  }

  Widget _buildIncomeExpense() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildFinanceItem(
          text: 'Income',
          amount: '\$200.6K',
          icon: IconConstant.earn,
          color: ColorConstant.income,
        ),
        _buildFinanceItem(
          text: 'Expense',
          amount: '\$200.6K',
          icon: IconConstant.expense,
          color: ColorConstant.expense,
        ),
      ],
    );
  }

  Widget _buildFinanceItem({
    String text = '',
    String amount = '',
    Widget? icon,
    Color color = Colors.black,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          icon ?? const SizedBox(),
          const SizedBox(width: 12),
          Column(
            children: [
              Text(text, style: HomeTextStyleConstant.medium),
              Text(amount,
                  style: HomeTextStyleConstant.numberFocus(color: color)),
            ],
          ),
        ],
      ),
    );
  }

  // int _incomeIndex = 0;

  Widget _buildIncomeExpenseFilter() {
    return Column(
      children: [
        GeneralFilterBar(
          filterTitles: const ['Income', 'Expense'],
          children: [
            Column(
              children: [
                _buildIncomeExpensePieChart(),
                const SizedBox(),
                _buildTransactionItems(),
              ],
            ),
            Column(
              children: [
                _buildIncomeExpensePieChart(isIncome: false),
                const SizedBox(),
                _buildTransactionItems(isIncome: false),
              ],
            ),
          ],
        ),
      ],
    );
  }

  List<Map<String, dynamic>> json = [
    {'category': 'Transportation', 'amount': 40},
    {'category': 'Groceries', 'amount': 30},
    {'category': 'Utilitties', 'amount': 20},
    {'category': 'Entertainment', 'amount': 10},
  ];

  Widget _buildIncomeExpensePieChart({bool isIncome = true}) {
    return RoundedContainer(
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [SizedBox(), DurationDropDown()],
          ),
          const SizedBox(height: 30),
          IncomeExpensePieChart(
            data: getIncomeExpenseList(json),
            color: isIncome ? ColorConstant.income : ColorConstant.expense,
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItems({bool isIncome = true}) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('All Transactions', style: GeneralTextStyle.getHeader()),
            ViewMoreTextButton(
              onPressed: () {
                // go to transaction screens
                Navigator.pushNamed(context, RouteName.transaction);
              },
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildTransactionItemsDays(isIncome: isIncome),
        const SizedBox(height: 16),
        _buildTransactionItemsDays(day: 'Yesterday', isIncome: isIncome),
      ],
    );
  }

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
