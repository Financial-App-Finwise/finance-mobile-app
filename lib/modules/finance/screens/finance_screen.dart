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
import 'package:finwise/core/widgets/circular_progress/linear_progress_dots.dart';
import 'package:finwise/core/widgets/custom_refresh_indicator.dart';
import 'package:finwise/core/widgets/duration_drop_down/duration_drop_down.dart';
import 'package:finwise/core/widgets/duration_drop_down/models/duration_drop_down_item_model.dart';
import 'package:finwise/core/widgets/buttons/general_bottom_button.dart';
import 'package:finwise/core/widgets/empty_data_widget.dart';
import 'package:finwise/core/widgets/filter_bars/headers/models/filter_bar_header_item_model.dart';
import 'package:finwise/core/widgets/filter_bars/headers/widgets/general_filter_bar_header/general_filter_bar_header.dart';
import 'package:finwise/core/layouts/general_sticky_header_layout.dart';
import 'package:finwise/core/widgets/rounded_container.dart';
import 'package:finwise/core/widgets/transaction_item.dart';
import 'package:finwise/core/widgets/view_more_text_button.dart';
import 'package:finwise/modules/finance/stores/finance_store.dart';
import 'package:finwise/modules/transaction/models/transaction_model.dart';
import 'package:finwise/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class FinanceScreen extends StatefulWidget {
  const FinanceScreen({super.key});

  @override
  State<FinanceScreen> createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {
  late FinanceStore store = context.read<FinanceStore>();

  @override
  void initState() {
    super.initState();
    store.isIncome = 1;
  }

  @override
  void dispose() {
    store.dispose(); //test
    super.dispose();
  }

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
                    '\$${store.dollarAccount.totalbalance}',
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
          await store.read();
        },
        child: Stack(
          children: [
            SingleChildScrollView(
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
            Visibility(
              visible: false,
              child: Container(
                height: 100,
                color: Colors.amber,
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildBarChart() {
    return RoundedContainer(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // check if it's loading
              Visibility(
                visible: store.isLoadingBarChart,
                child: const LinearProgressDots(),
              ),
              const Expanded(child: SizedBox()),
              _buildGeneralPeriodButton(
                selectedValue: store.period,
                onChange: (value) async {
                  // save previous value, to aviod UI error in the bar chart
                  store.previousBarData =
                      ObservableMap.of(store.filteredFinance.data.total);

                  // change the period
                  store.period = value;

                  // initialize the map item value
                  store.initialize(store.queryParemeter);

                  // if the filteredFinance is empty, read to get data
                  if (store.filteredFinance.data.items.isEmpty) {
                    await store.read(
                      isIncome: true,
                      setLoading: () =>
                          store.loadingBarChart = LoadingStatusEnum.loading,
                    );
                  }
                },
              ),
            ],
          ),
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
              : IncomeExpenseBarChart(
                  data: store.filteredFinance.data.total.isEmpty
                      ? store.previousBarData
                      : store.filteredFinance.data.total),
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

  Widget _buildIncomeExpenseFilter() {
    return Column(
      children: [
        GeneralFilterBarHeader(
          items: [
            FilterBarHeaderItem(title: 'Income', value: true),
            FilterBarHeaderItem(title: 'Expense', value: false),
          ],
          currentValue: store.isIncome == 1,
          onTap: (value) async {
            store.isIncome = value ? 1 : 0;
            if (store.filteredFinance.data.items.isEmpty) {
              // save previous value, to aviod UI error in the bar chart
              // store.previousBarData =
              //     ObservableMap.of(store.filteredFinance.data.total);

              // // change the period
              // store.period = value;

              // initialize the map item value
              store.initialize(store.queryParemeter);

              // if the filteredFinance is empty, read to get data
              if (store.filteredFinance.data.items.isEmpty) {
                await store.read(
                  setLoading: () =>
                      store.loadingPieChart = LoadingStatusEnum.loading,
                );
              }
            }
          },
        ),
        _buildIncomeExpensePieChart(isIncome: store.isIncome == 1),
        _buildTransactionItems(isIncome: store.isIncome == 1),
      ],
    );
  }

  Widget _buildIncomeExpensePieChart({bool isIncome = true}) {
    return RoundedContainer(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Visibility(
                visible: store.loadingPieChart == LoadingStatusEnum.loading,
                child: const LinearProgressDots(),
              ),
              const Expanded(child: SizedBox()),
              _buildGeneralPeriodButton(
                selectedValue: 'this_month',
                onChange: (value) async {
                  store.period = value;
                  
                  if (store.previousBarData.isEmpty) {
                    store.loadingPieChart = LoadingStatusEnum.loading;
                  }
                  store.period = value;
                  // avoid null
                  store.initialize(store.queryParemeter);
                  await store.read(isIncome: isIncome);
                },
              ),
            ],
          ),
          const SizedBox(height: 30),
          store.finance.data.topCategories.isEmpty
              ? EmptyDataWidget(
                  icon: IconHelper.getSVGDefault(SVGName.emptyPieChart),
                  buttonLabel: 'Add Transaction',
                  description:
                      'You have no ${isIncome ? 'income' : 'expense'} transaction history yet.',
                  onButtonTap: () =>
                      Navigator.pushNamed(context, RouteName.transactionAdd),
                )
              : IncomeExpensePieChart(
                  data: getIncomeExpenseList(
                      store.filteredFinance.data.topCategories
                          .map(
                            (e) => {
                              'category': e.category.name,
                              'amount': e.amount,
                            },
                          )
                          .toList()),
                  color:
                      isIncome ? ColorConstant.income : ColorConstant.expense,
                ),
        ],
      ),
    );
  }

// -------------------- Transactions --------------------
  Widget _buildTransactionItems({bool isIncome = true}) {
    List<TransactionData> todayTransactions =
        store.filteredFinance.data.allTransactions.today;

    List<TransactionData> yesterdayTransactions =
        store.filteredFinance.data.allTransactions.yesterday;

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
          transactions: todayTransactions,
        ),
        const SizedBox(height: 16),
        _buildTransactionItemsDays(
          day: 'Yesterday',
          isIncome: isIncome,
          transactions: yesterdayTransactions,
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
          child: transactions.isEmpty
              ? EmptyDataWidget(
                  icon: IconHelper.getSVGDefault(SVGName.emptyPieChart),
                  buttonLabel: 'Add Transaction',
                  description:
                      'You have no ${isIncome ? 'income' : 'expense'} transaction history yet.',
                  onButtonTap: () =>
                      Navigator.pushNamed(context, RouteName.transactionAdd),
                )
              : ListView.separated(
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
                      color: isIncome
                          ? ColorConstant.income
                          : ColorConstant.expense,
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
