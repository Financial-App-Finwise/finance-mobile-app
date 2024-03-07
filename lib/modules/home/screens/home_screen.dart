import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/text_style_constants/home_text_style_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/enums/smart_goal_status_enum.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/helpers/text_style_helper.dart';
import 'package:finwise/core/helpers/ui_helper.dart';
import 'package:finwise/core/models/income_expense_model/income_expense_model.dart';
import 'package:finwise/core/widgets/budget_card.dart';
import 'package:finwise/core/widgets/budget_overview.dart';
import 'package:finwise/core/widgets/charts/empty_bar_chart.dart';
import 'package:finwise/core/widgets/charts/income_expense_barchart.dart';
import 'package:finwise/core/widgets/charts/income_expense_pie_chart.dart';
import 'package:finwise/core/widgets/duration_drop_down/duration_drop_down.dart';
import 'package:finwise/core/widgets/duration_drop_down/models/duration_drop_down_item_model.dart';
import 'package:finwise/core/widgets/empty_data_widget.dart';
import 'package:finwise/core/widgets/general_bottom_button.dart';
import 'package:finwise/core/widgets/rounded_container.dart';
import 'package:finwise/core/widgets/transaction_item.dart';
import 'package:finwise/core/widgets/view_more_text_button.dart';
import 'package:finwise/modules/auth/stores/auth_store.dart';
import 'package:finwise/modules/budget_plan/models/budget_plan_model.dart';
import 'package:finwise/modules/budget_plan/store/budget_plan_store.dart';
import 'package:finwise/modules/finance/stores/finance_store.dart';
import 'package:finwise/modules/smart_goal/stores/smart_goal_store.dart';
import 'package:finwise/modules/transaction/models/transaction_model.dart';
import 'package:finwise/modules/upcoming_bill/models/upcoming_bill_model.dart';
import 'package:finwise/modules/upcoming_bill/stores/upcoming_bill_store.dart';
import 'package:finwise/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late final BudgetPlanStore _budgetPlanStore = context.read<BudgetPlanStore>();
  late final FinanceStore _financeStore = context.read<FinanceStore>();
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

  Future _readAll() async {
    await _budgetPlanStore.read();
    await _financeStore.read();
    await _smartGoalStore.read(status: SmartGoalStatusEnum.inProgress);
    await _upcomingBillStore.read();
  }

  @override
  void deactivate() {
    debugPrint('--> START: home screen deactivate');
    debugPrint('<-- END: home screen deactivate');
    super.deactivate();
  }

  late AuthStore authStore = context.read<AuthStore>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    debugPrint('--> START: build home screen');
    return Scaffold(
      // appBar: _buildAppBar(),
      body: _buildBody(),
      backgroundColor: ColorConstant.backgroundColor,
      // backgroundColor: Colors.blue,
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: Container(
        alignment: Alignment.topRight,
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: RefreshIndicator(
          onRefresh: () async => await _readAll(),
          child: Observer(builder: (context) {
            return SingleChildScrollView(
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

  // ---------- user profile ----------
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
                child: CircleAvatar(child: IconConstant.avatar),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome Back,', style: HomeTextStyleConstant.welcome),
                  Text(authStore.user!.userData.name,
                      style: HomeTextStyleConstant.profileName),
                ],
              ),
            ],
          ),
          InkWell(
            onTap: () {},
            child: IconConstant.notification,
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
                    Text(amount,
                        style: HomeTextStyleConstant.numberFocus(color: color)),
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(width: 12),
        DurationDropDown(
          items: [
            DurationDropDownItem(title: 'This Month', value: 'this_month'),
            DurationDropDownItem(title: 'This Week', value: 'this_week'),
            DurationDropDownItem(title: 'Last Month', value: 'last_month'),
            DurationDropDownItem(
                title: 'Last 3 Months', value: 'last_3_months'),
            DurationDropDownItem(
                title: 'Last 6 Months', value: 'last_6_months'),
          ],
          selectedValue: selectedValue,
          onChange: onChanged,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('My Finance', style: HomeTextStyleConstant.header),
                ViewMoreTextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, RouteName.finance))
              ],
            ),
            const SizedBox(height: 12),
            // build content
            RoundedContainer(
              child: Column(
                children: [
                  // Total balance
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // color: Colors.amber,
                        child: _buildFinanceItem(
                          text: 'Total Balance',
                          amount:
                              '\$${_financeStore.dollarAccount.totalbalance}',
                          color: ColorConstant.primary,
                          icon: IconConstant.piggyBank,
                        ),
                      ),
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
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: const Divider(color: Color(0xfff2f2f2)),
                  ),
                  // Income and Expense
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildFinanceItem(
                            text: 'Income',
                            amount:
                                '\$${_financeStore.finance.data.totalIncomes}',
                            color: ColorConstant.income,
                            icon: IconConstant.earn,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child:
                              const VerticalDivider(color: Color(0xfff2f2f2)),
                        ),
                        Expanded(
                          child: _buildFinanceItem(
                            text: 'Expense',
                            amount:
                                '\$${_financeStore.finance.data.totalExpenses}',
                            color: ColorConstant.expense,
                            icon: IconConstant.expense,
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

  // ---------- other features ----------
  Widget _buildMainFeatures() {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            'Other Features',
            style: HomeTextStyleConstant.header,
          ),
          const SizedBox(height: 12),
          Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                _buildFeatureItem(
                    text: 'My Budget',
                    amount: '3',
                    icon: IconConstant.myBudget(),
                    onPressed: () {
                      Navigator.pushNamed(context, RouteName.budgetPlan);
                    }),
                const SizedBox(width: 12),
                _buildFeatureItem(
                    text: 'Upcoming Bill',
                    amount: '3',
                    icon: IconConstant.getUpcomingBill(),
                    onPressed: () {
                      Navigator.pushNamed(context, RouteName.upcomingBill);
                    }),
                const SizedBox(width: 12),
                _buildFeatureItem(
                    text: 'Smart Goal',
                    amount: ' ${_smartGoalStore.smartGoal.meta.total}',
                    icon: IconConstant.getSmartGoal(color: Colors.white),
                    onPressed: () {
                      Navigator.pushNamed(context, RouteName.smartGoal);
                    }),
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
                      style: HomeTextStyleConstant.numberFocus(
                          color: Colors.white),
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

  // ----- spending income -----
  Widget _buildSpendingIncome() {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildGeneralTitle('Spending and Income'),
          RoundedContainer(
            child: _financeStore.finance.data.total.isEmpty
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
                        onButtonTap: () {},
                        buttonLabel: 'Add Transaction',
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Row(children: [
                        const Expanded(child: SizedBox()),

                        // DurationDropDown(),
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
                          selectedValue: _financeStore.period,
                          onChange: (value) async {
                            _financeStore.period = value;
                            await _financeStore.read();
                          },
                        )
                      ]),
                      const SizedBox(height: 24),
                      IncomeExpenseBarChart(
                        data: _financeStore.finance.data.total,
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  // ----- top spending -----
  Widget _buildTopSpending() {
    List values = [40.0, 20.0, 30.0, 10.0];
    values.sort((a, b) => b.compareTo(a));

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
                  amount: '\$356',
                  color: ColorConstant.expense,
                  icon: IconConstant.expense,
                  selectedValue: 'this_month',
                  onChanged: (value) {},
                ),
                const SizedBox(height: 30),
                IncomeExpensePieChart(
                  color: ColorConstant.expense,
                  data: [
                    IncomeExpense(category: 'Transportation', amount: 40),
                    IncomeExpense(category: 'Groceries', amount: 40),
                    IncomeExpense(category: 'Utilities', amount: 40),
                    IncomeExpense(category: 'Entertainment', amount: 40),
                  ],
                ),
                // const SizedBox(height: 30),
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
      // color: Colors.green,
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
      bottomLeft: Text('Today', style: HomeTextStyleConstant.medium),
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
                  icon: IconConstant.expense,
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
                              RouteName.transactionCreate,
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
                  icon: IconConstant.earn,
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
                              RouteName.transactionCreate,
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
                SVGName.schoolBus,
                color: Colors.white,
              )),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(color: ColorConstant.divider);
      },
    );
  }

  Widget _buildSmallRoundedSquare({Color color = Colors.black}) {
    return Container(
      width: 32,
      height: 32,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: IconConstant.getSchoolBus(),
    );
  }

  // ---------- upcoming bill ----------
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
                    title: 'Total Upcoming Bills',
                    amount: '4',
                    color: ColorConstant.bill,
                    icon:
                        IconConstant.getUpcomingBill(color: ColorConstant.bill),
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
        onPressed: () => Navigator.pushNamed(
          context,
          RouteName.upcomingBillDetail,
          arguments: item,
        ),
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
                _buildSmallRoundedSquare(color: ColorConstant.bill),
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

  // ---------- General ----------
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
              // color: Colors.amber,
              child: Row(
                children: [
                  const SizedBox(width: 6),
                  IconConstant.arrowLeft,
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
              // color: Colors.amber,
              child: Row(
                children: [
                  const SizedBox(width: 12),
                  IconConstant.arrowRight,
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
