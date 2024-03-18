import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/text_style_constants/home_text_style_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/enums/loading_status_enum.dart';
import 'package:finwise/core/enums/smart_goal_status_enum.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/helpers/text_style_helper.dart';
import 'package:finwise/core/helpers/ui_helper.dart';
import 'package:finwise/core/models/income_expense_model/income_expense_model.dart';
import 'package:finwise/core/widgets/budget_card.dart';
import 'package:finwise/core/widgets/budget_overview.dart';
import 'package:finwise/core/widgets/charts/income_expense_barchart.dart';
import 'package:finwise/core/widgets/charts/income_expense_pie_chart.dart';
import 'package:finwise/core/widgets/circular_progress/linear_progress_dots.dart';
import 'package:finwise/core/widgets/custom_refresh_indicator.dart';
import 'package:finwise/core/widgets/duration_drop_down/duration_drop_down.dart';
import 'package:finwise/core/widgets/duration_drop_down/models/duration_drop_down_item_model.dart';
import 'package:finwise/core/widgets/empty_data_widget.dart';
import 'package:finwise/core/widgets/rounded_container.dart';
import 'package:finwise/core/widgets/small_rounded_square.dart';
import 'package:finwise/core/widgets/transaction_item.dart';
import 'package:finwise/core/widgets/view_more_text_button.dart';
import 'package:finwise/modules/auth/stores/auth_store.dart';
import 'package:finwise/modules/budget_plan/models/budget_plan_model.dart';
import 'package:finwise/modules/budget_plan/store/budget_plan_store.dart';
import 'package:finwise/modules/data_science/stores/insight_store.dart';
import 'package:finwise/modules/finance/stores/finance_store.dart';
import 'package:finwise/modules/data_science/screens/insight_screen.dart';
import 'package:finwise/modules/smart_goal/stores/smart_goal_store.dart';
import 'package:finwise/modules/transaction/models/transaction_model.dart';
import 'package:finwise/modules/upcoming_bill/models/upcoming_bill_model.dart';
import 'package:finwise/modules/upcoming_bill/stores/upcoming_bill_store.dart';
import 'package:finwise/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final ScrollController? scrollController;

  const HomeScreen({super.key, this.scrollController});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  // -------------------- Required Store --------------------
  late final AuthStore _authStore = context.read<AuthStore>();
  late final BudgetPlanStore _budgetPlanStore = context.read<BudgetPlanStore>();
  late final FinanceStore _financeStore = context.read<FinanceStore>();
  late final InsightStore _insightStore = context.read<InsightStore>();
  late final SmartGoalStore _smartGoalStore = context.read<SmartGoalStore>();
  late final UpcomingBillStore _upcomingBillStore =
      context.read<UpcomingBillStore>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await _readAll();
    });
  }

  // -------------------- Read all Necessary Data --------------------
  Future _readAll() async {
    _insightStore.loadWebPage();
    await _budgetPlanStore.read();
    await _financeStore.read(updateFinance: true);
    await _financeStore.read(isIncome: false);
    await _smartGoalStore.read(status: SmartGoalStatusEnum.inProgress);
    await _upcomingBillStore.read();
  }

  @override
  void deactivate() {
    debugPrint('--> START: home screen deactivate');
    debugPrint('<-- END: home screen deactivate');
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    debugPrint('--> START: build home screen');
    return Scaffold(
      body: _buildBody(),
      backgroundColor: ColorConstant.backgroundColor,
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: Container(
        alignment: Alignment.topRight,
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: CustomRefreshIndicator(
          onRefresh: () async => await _readAll(),
          child: Observer(builder: (context) {
            return SingleChildScrollView(
              controller: widget.scrollController,
              child: Column(
                children: [
                  ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      _buildProfile(),
                      _buildFinance(),
                      _buildMainFeatures(),
                      _buildSpendingIncome(),
                      _buildTopSpending(),
                      _buildBudgetPlan(),
                      _buildTotalSpend(),
                      _buildTotalEarn(),
                      _buildUpcomingBill(),
                      const SizedBox(height: 48),
                    ],
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  // -------------------- User Profile --------------------
  Widget _buildProfile() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox.fromSize(
                size: const Size(56, 56),
                child: CircleAvatar(
                    child: IconHelper.getSVGDefault(SVGName.avatar)),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Welcome Back,',
                      style: HomeTextStyleConstant.welcome),
                  Text(_authStore.user!.userData.name,
                      style: HomeTextStyleConstant.profileName),
                ],
              ),
            ],
          ),
          InkWell(
            onTap: () {},
            child: IconHelper.getSVG(SVGName.notification),
          ),
        ],
      ),
    );
  }

  // -------------------- General --------------------
  Widget _buildGeneralTitle(String text) {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 12),
      child: Text(text, style: HomeTextStyleConstant.header),
    );
  }

  Widget _buildGeneralContentHeading({
    String title = 'title',
    String amount = 'amount',
    Color color = Colors.black,
    Widget? icon,
    String selectedValue = '',
    bool periodButtonVisible = true,
    required void Function(dynamic) onChanged,
  }) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              icon ?? const SizedBox(),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: HomeTextStyleConstant.medium),
                    Text(
                      amount,
                      style: TextStyleHelper.getw600size(
                        24,
                        color: color,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(width: 12),
        Visibility(
          visible: periodButtonVisible,
          child: DurationDropDown(
            items: [
              DurationDropDownItem(title: 'This Month', value: 'this_month'),
              DurationDropDownItem(title: 'This Week', value: 'this_week'),
              DurationDropDownItem(title: 'Last Month', value: 'last_month'),
              DurationDropDownItem(
                  title: 'Last 3 Months', value: 'last_3_months'),
              DurationDropDownItem(
                  title: 'Last 4 Months', value: 'last_4_months'),
            ],
            selectedValue: selectedValue,
            onChange: onChanged,
          ),
        )
      ],
    );
  }

  // -------------------- Finance --------------------
  Widget _buildFinance() {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, RouteName.finance),
      child: Container(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            // ---------- Title ----------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('My Finance', style: HomeTextStyleConstant.header),
                ViewMoreTextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, RouteName.finance))
              ],
            ),
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    ColorConstant.primary,
                    ColorConstant.secondary,
                  ],
                  stops: [0, 1],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.zero,
              child: TextButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => InsightScreen(),
                  ),
                ),
                child: const Text(
                  'Get Insights',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // ---------- Content ----------
            RoundedContainer(
              child: Column(
                children: [
                  // ---------- Total balance ----------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: _buildFinanceItem(
                          text: 'Total Balance',
                          amount:
                              '\$${_financeStore.dollarAccount.totalbalance}',
                          color: ColorConstant.primary,
                          icon: IconHelper.getSVG(
                            SVGName.piggyBank,
                            color: ColorConstant.secondary,
                          ),
                        ),
                      ),
                      // ---------- Dropdown Button ----------
                      DurationDropDown(
                        items: [
                          DurationDropDownItem(
                              title: 'This Month', value: 'this_month'),
                          DurationDropDownItem(
                              title: 'This Week', value: 'this_week'),
                          DurationDropDownItem(
                              title: 'Last Month', value: 'last_month'),
                          DurationDropDownItem(
                              title: 'Last 3 Months', value: 'last_3_months'),
                          DurationDropDownItem(
                              title: 'Last 6 Months', value: 'last_6_months'),
                        ],
                        selectedValue: 'this_month',
                        onChange: (value) {},
                      ),
                    ],
                  ),
                  // ---------- Divider ----------
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: const Divider(color: Color(0xfff2f2f2)),
                  ),
                  // ---------- Income and Expense Sections ----------
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        Expanded(
                          // ---------- Income Section ----------
                          child: _buildFinanceItem(
                            text: 'Income',
                            amount:
                                '\$${_financeStore.finance.data.totalIncomes}',
                            color: ColorConstant.income,
                            icon: IconHelper.getSVG(
                              SVGName.earn,
                              color: ColorConstant.incomeIcon,
                            ),
                          ),
                        ),
                        // ---------- Vertical Divider ----------
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child:
                              const VerticalDivider(color: Color(0xfff2f2f2)),
                        ),
                        // ---------- Expense Section ----------
                        Expanded(
                          child: _buildFinanceItem(
                            text: 'Expense',
                            amount:
                                '\$${_financeStore.finance.data.totalExpenses}',
                            color: ColorConstant.expense,
                            icon: IconHelper.getSVG(
                              SVGName.expense,
                              color: ColorConstant.expenseIcon,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinanceItem({
    String text = '',
    String amount = '',
    Widget? icon,
    Color color = Colors.black,
  }) {
    return Row(
      children: [
        icon ?? const SizedBox(),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(text, style: HomeTextStyleConstant.medium),
            Text(
              amount,
              style: TextStyleHelper.getw600size(24, color: color),
            ),
          ],
        ),
      ],
    );
  }

  // -------------------- Other Features --------------------
  Widget _buildMainFeatures() {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          // ---------- Title ----------
          const Text('Other Features', style: HomeTextStyleConstant.header),
          const SizedBox(height: 12),
          Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                // ---------- My Budget ----------
                _buildFeatureItem(
                  text: 'My Budget',
                  amount: '${_budgetPlanStore.budgetPlan.data.totalBudget}',
                  icon:
                      IconHelper.getSVG(SVGName.myBudget, color: Colors.white),
                  onPressed: () =>
                      Navigator.pushNamed(context, RouteName.budgetPlan),
                ),
                const SizedBox(width: 12),
                // ---------- Upcoming Bill ----------
                _buildFeatureItem(
                  text: 'Upcoming Bill',
                  amount: '3',
                  icon: IconHelper.getSVG(SVGName.upcomingBill,
                      color: Colors.white),
                  onPressed: () =>
                      Navigator.pushNamed(context, RouteName.upcomingBill),
                ),
                const SizedBox(width: 12),
                // ---------- Smart Goal ----------
                _buildFeatureItem(
                  text: 'Smart Goal',
                  amount: ' ${_smartGoalStore.meta.total}',
                  icon:
                      IconHelper.getSVG(SVGName.smartGoal, color: Colors.white),
                  onPressed: () =>
                      Navigator.pushNamed(context, RouteName.smartGoal),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem({
    String text = '',
    String amount = '',
    Widget? icon,
    void Function()? onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [ColorConstant.primary, ColorConstant.secondary],
          stops: [0, 0.8],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)))),
        child: Container(
          width: 165.5,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style: HomeTextStyleConstant.medium
                          .copyWith(color: Colors.white),
                    ),
                    Text(
                      amount,
                      style:
                          TextStyleHelper.getw600size(24, color: Colors.white),
                    ),
                  ],
                ),
              ),
              icon ?? const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  // -------------------- Spending Income --------------------
  Widget _buildSpendingIncome() {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildGeneralTitle('Spending and Income'),
          RoundedContainer(
            child: Column(
              children: [
                Row(children: [
                  // check if it's loading
                  Visibility(
                    visible: _financeStore.isLoadingBarChart,
                    child: const LinearProgressDots(),
                  ),
                  const Expanded(child: SizedBox()),
                  // ---------- Dropdown Button ----------
                  DurationDropDown(
                    items: [
                      DurationDropDownItem(
                          title: 'This Month', value: 'this_month'),
                      // DurationDropDownItem(
                      //     title: 'This Week', value: 'this_week'),
                      DurationDropDownItem(
                          title: 'Last Month', value: 'last_month'),
                      DurationDropDownItem(
                          title: 'Last 3 Months', value: 'last_3_months'),
                      DurationDropDownItem(
                          title: 'Last 4 Months', value: 'last_4_months'),
                    ],
                    selectedValue: _financeStore.period,
                    onChange: (value) async {
                      // save previous value, to aviod UI error in the bar chart
                      _financeStore.previousBarData = ObservableMap.of(
                          _financeStore.filteredFinance.data.total);

                      // change the period
                      _financeStore.period = value;

                      // initialize the map item value
                      _financeStore.initialize(_financeStore.queryParemeter);

                      // if the filteredFinance is empty, read to get data
                      if (_financeStore.filteredFinance.data.items.isEmpty) {
                        await _financeStore.read(
                          isIncome: true,
                          setLoading: () => _financeStore.loadingBarChart =
                              LoadingStatusEnum.loading,
                        );
                      }
                    },
                  )
                ]),
                const SizedBox(height: 24),
                _financeStore.finance.data.total.isEmpty
                    ? Column(
                        children: [
                          EmptyDataWidget(
                            icon:
                                IconHelper.getSVGDefault(SVGName.emptyBarChart),
                            iconSize: const Size(140, 140),
                            buttonLabel: 'Add Transaction',
                            description: 'You have no payment history yet.',
                            onButtonTap: () => Navigator.pushNamed(
                                context, RouteName.transactionAdd),
                          ),
                        ],
                      )
                    : IncomeExpenseBarChart(
                        data: _financeStore.filteredFinance.data.total.isEmpty
                            ? _financeStore.previousBarData
                            : _financeStore.filteredFinance.data.total),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // -------------------- Top Spending --------------------
  Widget _buildTopSpending() {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildGeneralTitle('Top Spending Categories'),
          RoundedContainer(
            child: Column(
              children: [
                _buildGeneralContentHeading(
                  title: 'Totally Spent',
                  periodButtonVisible: false,
                  amount:
                      '\$${_financeStore.expenseFinance.data.totalExpenses}',
                  color: ColorConstant.expense,
                  icon: IconHelper.getSVG(
                    SVGName.expense,
                    color: ColorConstant.expenseIcon,
                  ),
                  selectedValue: 'this_month',
                  onChanged: (value) async {
                    _financeStore.period = value;
                    await _financeStore.read(isIncome: false);
                  },
                ),
                const SizedBox(height: 30),
                _financeStore.finance.data.topCategories.isEmpty
                    ? EmptyDataWidget(
                        icon: IconHelper.getSVGDefault(SVGName.emptyPieChart),
                        buttonLabel: 'Add Transaction',
                        description:
                            'You have no expense transaction history yet.',
                        onButtonTap: () => Navigator.pushNamed(
                            context, RouteName.transactionAdd),
                      )
                    : IncomeExpensePieChart(
                        data: getIncomeExpenseList(
                            _financeStore.expenseFinance.data.topCategories
                                .map(
                                  (e) => {
                                    'category': e.category.name,
                                    'amount': e.amount,
                                  },
                                )
                                .toList()),
                        color: ColorConstant.expense,
                      ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // -------------------- Budget Plan --------------------
  Widget _buildBudgetPlan() {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, RouteName.budgetPlan),
      child: Container(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGeneralTitle('My Budget Plan'),
            RoundedContainer(
              child: Column(
                children: [
                  _buildBudgetPlanHeader(),
                  const Divider(color: ColorConstant.divider),
                  const SizedBox(height: 16),
                  _budgetPlanStore.budgetPlan.data.budgetPlans.isEmpty
                      ? EmptyDataWidget(
                          icon: IconHelper.getSVG(
                            SVGName.myBudget,
                            color: ColorConstant.colorA4A7C6,
                          ),
                          description:
                              'You have no budget plan for this month.',
                          buttonLabel: 'Add Budget Plan',
                          onButtonTap: () =>
                              Navigator.pushNamed(context, RouteName.addBudget),
                        )
                      : Column(
                          children: [
                            _buildBudgetOverview(),
                            _buildBudgetPlanCards(),
                          ],
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBudgetPlanHeader() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      _buildBudgetPlanDate(),
      Visibility(
        visible: _budgetPlanStore.budgetPlan.data.budgetPlans.isNotEmpty,
        child: _buildAddButton(),
      ),
    ]);
  }

  Widget _buildBudgetPlanDate() {
    return Container(
      padding: const EdgeInsets.all(2.0),
      child: _buildDatePicker(),
    );
  }

  Widget _buildAddButton() {
    return ElevatedButton(
      onPressed: () => Navigator.pushNamed(context, RouteName.addBudget),
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        backgroundColor: MaterialStateProperty.all(ColorConstant.secondary),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        ),
      ),
      child: const Row(
        children: [
          Icon(Icons.add, color: Colors.white),
          SizedBox(width: 8),
          Text('Add New', style: HomeTextStyleConstant.smallAddButton),
        ],
      ),
    );
  }

  Widget _buildBudgetOverview() {
    final data = _budgetPlanStore.budgetPlan.data;
    return BudgetOverview(
      totalBudget: data.totalBudget,
      available: data.available,
      spend: data.spent,
      overBudget: data.overBudget,
      plannedBudget: data.plannedBudget,
    );
  }

  Widget _buildBudgetPlanCards() {
    List<BudgetPlanData> budgetPlans =
        _budgetPlanStore.budgetPlan.data.budgetPlans;
    budgetPlans =
        budgetPlans.length > 3 ? budgetPlans.sublist(0, 3) : budgetPlans;

    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: budgetPlans
              .map((e) => Row(
                    children: [
                      _buildBudgetCardItem(e),
                      const SizedBox(width: 12)
                    ],
                  ))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildBudgetCardItem(BudgetPlanData item) {
    return BudgetCard(
      onTap: () {
        Navigator.pushNamed(
          context,
          RouteName.budgetPlanDetail,
          arguments: item,
        );
      },
      title: item.name,
      color: ColorConstant.expense,
      topLeft: Row(
        children: [
          Text('\$${item.remainingAmount}',
              style: HomeTextStyleConstant.budgetCardTitle),
          const SizedBox(width: 6),
          const Text('Left', style: HomeTextStyleConstant.medium),
        ],
      ),
      topRight: Row(
        children: [
          const Text('out of', style: HomeTextStyleConstant.medium),
          const SizedBox(width: 6),
          Text('\$${item.amount}',
              style: HomeTextStyleConstant.budgetCardTitle),
        ],
      ),
      bottomLeft: const Text('Today', style: HomeTextStyleConstant.medium),
      bottomRight: Text(
          '${UIHelper.getDateFormat(item.createdAt, 'dd MMM, yyyy')}',
          style: HomeTextStyleConstant.medium),
      total: 10,
      spent: 5,
    );
  }

  // -------------------- Totally Spent --------------------
  Widget _buildTotalSpend() {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildGeneralTitle('Totally Spent'),
              ViewMoreTextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, RouteName.transaction))
            ],
          ),
          RoundedContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildGeneralContentHeading(
                  title: 'Totally Spent',
                  amount: '\$${_financeStore.finance.data.totalExpenses}',
                  color: ColorConstant.expense,
                  icon: IconHelper.getSVG(
                    SVGName.expense,
                    color: ColorConstant.expenseIcon,
                  ),
                  selectedValue: 'this_month',
                  onChanged: (value) {},
                ),
                const Divider(color: ColorConstant.divider),
                const SizedBox(height: 16),
                const Text('Recent Transactions',
                    style: HomeTextStyleConstant.medium),
                const SizedBox(height: 12),
                _financeStore.expenseFinance.data.allTransactions.today.isEmpty
                    ? EmptyDataWidget(
                        icon: IconHelper.getSVG(
                          SVGName.transaction,
                          color: ColorConstant.colorA4A7C6,
                        ),
                        description:
                            'You currently have no spending transaction history.',
                        buttonLabel: 'Add Transaction',
                        onButtonTap: () => Navigator.pushNamed(
                              context,
                              RouteName.transactionAdd,
                            ))
                    : _buildTransactions(
                        color: ColorConstant.expense,
                        transactions: _financeStore
                            .expenseFinance.data.allTransactions.today,
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // -------------------- Totally Earned ---------------------
  Widget _buildTotalEarn() {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildGeneralTitle('Totally Earned'),
          RoundedContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildGeneralContentHeading(
                  title: 'Totally Earned',
                  amount: '\$${_financeStore.finance.data.totalIncomes}',
                  color: ColorConstant.income,
                  icon: IconHelper.getSVG(
                    SVGName.earn,
                    color: ColorConstant.incomeIcon,
                  ),
                  selectedValue: 'this_month',
                  onChanged: (value) {},
                ),
                const Divider(color: ColorConstant.divider),
                const SizedBox(height: 16),
                const Text('Recent Transactions',
                    style: HomeTextStyleConstant.medium),
                const SizedBox(height: 12),
                _financeStore.incomeFinance.data.allTransactions.today.isEmpty
                    ? EmptyDataWidget(
                        icon: IconHelper.getSVG(
                          SVGName.transaction,
                          color: ColorConstant.colorA4A7C6,
                        ),
                        description:
                            'You currently have no earning transaction history.',
                        buttonLabel: 'Add Transaction',
                        onButtonTap: () => Navigator.pushNamed(
                              context,
                              RouteName.transactionAdd,
                            ))
                    : _buildTransactions(
                        color: ColorConstant.income,
                        transactions: _financeStore
                            .incomeFinance.data.allTransactions.today,
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // -------------------- Transactions --------------------
  Widget _buildTransactions({
    Color color = Colors.black,
    List<TransactionData> transactions = const [],
  }) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.pushNamed(context, RouteName.transaction);
          },
          child: TransactionItem(
              transactionData: transactions[index],
              date: UIHelper.getDateFormat(
                  transactions[index].date, 'dd MMM, yyyy'),
              color: color,
              icon: IconHelper.getSVG(
                transactions[index].isIncome ? SVGName.earn : SVGName.expense,
                color: Colors.white,
              )),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(color: ColorConstant.divider);
      },
    );
  }

  // -------------------- Upcoming Bill --------------------
  Widget _buildUpcomingBill() {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, RouteName.upcomingBill),
      child: Container(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGeneralTitle('Upcoming Bill'),
            RoundedContainer(
              child: Column(
                children: [
                  _buildGeneralContentHeading(
                    title: 'Total',
                    amount: '4',
                    color: ColorConstant.bill,
                    icon: IconHelper.getSVG(
                      SVGName.upcomingBill,
                      color: ColorConstant.billIcon,
                    ),
                    selectedValue: 'this_month',
                    onChanged: (value) {},
                  ),
                  const Divider(color: ColorConstant.divider),
                  const SizedBox(height: 16),
                  _upcomingBillStore.upcomingBill.data.isEmpty
                      ? EmptyDataWidget(
                          icon: IconHelper.getSVG(
                            SVGName.transaction,
                            color: ColorConstant.colorA4A7C6,
                          ),
                          description:
                              'You have no upcoming bill for this month.',
                          buttonLabel: 'Add Upcoming Bill',
                          onButtonTap: () => Navigator.pushNamed(
                                context,
                                RouteName.addUpcomingBill,
                              ))
                      : _buildUpcomingBills(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingBills() {
    List<UpcomingBillData> upcomingBills = _upcomingBillStore.upcomingBill.data;
    upcomingBills =
        upcomingBills.length > 3 ? upcomingBills.sublist(0, 3) : upcomingBills;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: upcomingBills
            .map((item) =>
                Row(children: [_buildBillItem(item), const SizedBox(width: 8)]))
            .toList(),
      ),
    );
  }

  Widget _buildBillItem(UpcomingBillData item) {
    return Container(
      width: 200,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: ColorConstant.divider),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextButton(
        // onPressed: () => Navigator.pushNamed(
        //   context,
        //   RouteName.upcomingBillDetail,
        //   arguments: item,
        // ),
        onPressed: null,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(vertical: 12, horizontal: 16)),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SmallRoundedSquare(
                  color: ColorConstant.bill,
                  icon: IconHelper.getSVG(
                    SVGName.internet,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 12),
                Text(UIHelper.getDateFormat(item.date, 'dd MMM, yyyy'),
                    style: HomeTextStyleConstant.budgetCardTitle),
              ],
            ),
            const SizedBox(height: 8),
            const Divider(color: ColorConstant.divider),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name, style: HomeTextStyleConstant.medium),
                const SizedBox(height: 2),
                Text('\$${item.amount}',
                    style: TextStyleHelper.getw600size(24,
                        color: ColorConstant.black)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // -------------------- General --------------------
  DateTime currentDate = DateTime.now();

  List<String> monthNames = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  Widget _buildDatePicker() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              currentDate = subtractMonth(currentDate);
            });
          },
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  const SizedBox(width: 6),
                  IconHelper.getSVG(SVGName.arrowLeft),
                  const SizedBox(width: 12),
                ],
              )),
        ),
        Text(
          '${monthNames[currentDate.month - 1]} ${currentDate.year}',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            letterSpacing: 1,
            color: ColorConstant.black,
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              currentDate = addMonth(currentDate);
            });
          },
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  const SizedBox(width: 12),
                  IconHelper.getSVG(SVGName.arrowRight),
                  const SizedBox(width: 6),
                ],
              )),
        ),
      ],
    );
  }

  DateTime subtractMonth(DateTime date) {
    // Calculate the number of days in the previous month
    int daysInPreviousMonth = DateTime(date.year, date.month, 0).day;

    // Subtract the days in the previous month from the current date
    return date.subtract(Duration(days: daysInPreviousMonth));
  }

  DateTime addMonth(DateTime date) {
    // Calculate the number of days in the current month
    int daysInCurrentMonth = DateTime(date.year, date.month + 1, 0).day;

    // Add the days in the current month to the current date
    return date.add(Duration(days: daysInCurrentMonth));
  }
}
