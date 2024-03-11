import 'package:dots_indicator/dots_indicator.dart';
import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/constants/text_style_constants/financial_text_style_constant.dart';
import 'package:finwise/core/constants/text_style_constants/general_text_style_constant.dart';
import 'package:finwise/core/constants/text_style_constants/home_text_style_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:finwise/core/enums/loading_status_enum.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/helpers/text_style_helper.dart';
import 'package:finwise/core/helpers/ui_helper.dart';
import 'package:finwise/core/models/income_expense_model/income_expense_model.dart';
import 'package:finwise/core/widgets/charts/empty_bar_chart.dart';
import 'package:finwise/core/widgets/charts/income_expense_barchart.dart';
import 'package:finwise/core/widgets/charts/income_expense_pie_chart.dart';
import 'package:finwise/core/widgets/circular_progress/circular_progress_two_arches.dart';
import 'package:finwise/core/widgets/custom_refresh_indicator.dart';
import 'package:finwise/core/widgets/duration_drop_down/duration_drop_down.dart';
import 'package:finwise/core/widgets/duration_drop_down/models/duration_drop_down_item_model.dart';
import 'package:finwise/core/widgets/buttons/general_bottom_button.dart';
import 'package:finwise/core/widgets/general_filter_bar/general_filter_bar.dart';
import 'package:finwise/core/layouts/general_sticky_header_layout.dart';
import 'package:finwise/core/widgets/rounded_container.dart';
import 'package:finwise/core/widgets/transaction_item.dart';
import 'package:finwise/core/widgets/view_more_text_button.dart';
import 'package:finwise/modules/finance/stores/finance_store.dart';
import 'package:finwise/modules/transaction/models/transaction_model.dart';
import 'package:finwise/route.dart';
import 'package:finwise/test/test_3_dots.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class FinanceScreen extends StatefulWidget {
  const FinanceScreen({super.key});

  @override
  State<FinanceScreen> createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {
  late FinanceStore store = context.read<FinanceStore>();

  // @override
  // void initState() {
  //   super.initState();
  //   Future.delayed(Duration.zero, () async {
  //     // await _readAll();
  //     // await context.read<FinanceStore>().read();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
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
    return Observer(builder: (context) {
      return ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          Row(
            children: [
              IconHelper.getSVG(
                SVGName.piggyBank,
                color: ColorConstant.secondary,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Total Balance',
                      style: FiancialTextStyle.totalBalanceTitle),
                  const SizedBox(height: 4),
                  Text(
                    '\$${context.watch<FinanceStore>().dollarAccount.totalbalance}',
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
                Navigator.of(context).pushNamed(RouteName.financeEdit),
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
    });
  }

  Widget _buildContent() {
    return Observer(builder: (context) {
      return CustomRefreshIndicator(
        onRefresh: () async {
          await context.read<FinanceStore>().read();
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
    });
  }

  Widget _buildBarChart() {
    return RoundedContainer(
      child: Column(
        children: [
          Row(children: [
            Visibility(
              visible: store.barChartLoading == LoadingStatusEnum.loading,
              child: LinearProgressWithDots(),
            ),
            const Expanded(child: SizedBox()),
            _buildGeneralPeriodButton(
              selectedValue: store.period,
              onChange: (value) async {
                store.period = value;
                await store.read();
              },
            ),
          ]),
          const SizedBox(height: 24),
          store.finance.data.total.isEmpty
              ? Column(
                  children: [
                    const EmptyBarChart(),
                    const SizedBox(height: 8),
                    Text(
                      'You have no payment history yet.',
                      style: TextStyleHelper.getw500size(16,
                          color: ColorConstant.black),
                    ),
                    const SizedBox(height: 8),
                    GeneralBottomButton(
                      onButtonTap: () => Navigator.pushNamed(
                        context,
                        RouteName.transactionAdd,
                      ),
                      buttonLabel: 'Add Transaction',
                    ),
                  ],
                )
              : IncomeExpenseBarChart(data: store.finance.data.total),
        ],
      ),
    );
  }

  Widget _buildGeneralPeriodButton({
    selectedValue = '',
    required void Function(dynamic) onChange,
  }) {
    return DurationDropDown(
      items: [
        DurationDropDownItem(title: 'This Month', value: 'this_month'),
        DurationDropDownItem(title: 'This Week', value: 'this_week'),
        DurationDropDownItem(title: 'Last Month', value: 'last_month'),
        DurationDropDownItem(title: 'Last 3 Months', value: 'last_3_months'),
        DurationDropDownItem(title: 'Last 6 Months', value: 'last_6_months'),
      ],
      selectedValue: selectedValue,
      onChange: onChange,
    );
  }

  Widget _buildIncomeExpense() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildFinanceItem(
          text: 'Income',
          amount: '\$${store.finance.data.totalIncomes}',
          icon: IconHelper.getSVG(SVGName.earn, color: ColorConstant.income),
          color: ColorConstant.income,
        ),
        _buildFinanceItem(
          text: 'Expense',
          amount: '\$${store.finance.data.totalExpenses}',
          icon:
              IconHelper.getSVG(SVGName.expense, color: ColorConstant.expense),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(child: SizedBox()),
              _buildGeneralPeriodButton(
                  selectedValue: 'this_month', onChange: (value) {}),
            ],
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

// -------------------- Transactions --------------------
  Widget _buildTransactionItems({bool isIncome = true}) {
    print('${store.finance.data.allTransactions.toJson()}');
    List<TransactionData> todayIncomeTransactions =
        store.incomeFinance.data.allTransactions.today;
    List<TransactionData> yesterdayIncomeTransactions =
        store.incomeFinance.data.allTransactions.yesterday;
    List<TransactionData> todayExpenseTransactions =
        store.expenseFinance.data.allTransactions.today;
    List<TransactionData> yesterdayExpenseTransactions =
        store.expenseFinance.data.allTransactions.yesterday;

    return Column(
      children: [
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('All Transactions', style: GeneralTextStyle.getHeader()),
            ViewMoreTextButton(
              onPressed: () =>
                  Navigator.pushNamed(context, RouteName.transaction),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildTransactionItemsDays(
          isIncome: isIncome,
          transactions:
              isIncome ? todayIncomeTransactions : todayExpenseTransactions,
        ),
        const SizedBox(height: 16),
        _buildTransactionItemsDays(
          day: 'Yesterday',
          isIncome: isIncome,
          transactions: isIncome
              ? yesterdayIncomeTransactions
              : yesterdayExpenseTransactions,
        ),
      ],
    );
  }

  Widget _buildTransactionItemsDays({
    String? day,
    bool isIncome = true,
    List<TransactionData> transactions = const [],
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
            itemCount: transactions.length,
            itemBuilder: ((context, index) {
              return TransactionItem(
                transactionData: transactions[index],
                date: UIHelper.getDateFormat(
                    transactions[index].date, 'dd MMM, yyyy'),
                icon: isIncome
                    ? IconConstant.getEarn()
                    : IconConstant.getExpense(),
                color: isIncome ? ColorConstant.income : ColorConstant.expense,
              );
            }),
            separatorBuilder: (context, index) =>
                const Divider(color: ColorConstant.divider),
          ),
        ),
      ],
    );
  }
}
