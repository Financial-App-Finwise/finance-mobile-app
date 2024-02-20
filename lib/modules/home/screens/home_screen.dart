import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/text_style_constants/home_text_style_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/helpers/text_style_helper.dart';
import 'package:finwise/core/models/income_expense_model/income_expense_model.dart';
import 'package:finwise/core/widgets/budget_card.dart';
import 'package:finwise/core/widgets/budget_overview.dart';
import 'package:finwise/core/widgets/duration_drop_down/duration_drop_down.dart';
import 'package:finwise/core/widgets/general_date_picker.dart';
import 'package:finwise/core/widgets/income_expense_barchart.dart';
import 'package:finwise/core/widgets/income_expense_pie_chart.dart';
import 'package:finwise/core/widgets/rounded_container.dart';
import 'package:finwise/core/widgets/transaction_item.dart';
import 'package:finwise/core/widgets/view_more_text_button.dart';
import 'package:finwise/modules/auth/stores/auth_store.dart';
import 'package:finwise/modules/budget_plan/screens/budget_plan_detail_screen.dart';
import 'package:finwise/route.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
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

  // @override
  // void initState() {
  //   super.initState();
  // }

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
        child: SingleChildScrollView(
          child: ListView(
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

  /// TODO
  /// if there is no data, indicate that the user has no data
  /// and needs to add transaction

  // Widget _buildNoDataDisplay() {
  //   return Container();
  // }

  // Widget _buildEmptyBarChart() {
  //   return Container();
  // }

  // Widget _buildEmptyPieChart() {
  //   return Container();
  // }

  // ---------- general ----------
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
    String buttonText = 'button',
    void Function()? onButtonPressed,
  }) {
    return Row(
      children: [
        Expanded(
          child: Row(children: [
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
          ]),
        ),
        const SizedBox(width: 12),
        const DurationDropDown(),
      ],
    );
  }

  // ---------- finance ----------
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
                          amount: '\$1000',
                          color: ColorConstant.primary,
                          icon: IconConstant.piggyBank,
                        ),
                      ),
                      const DurationDropDown(),
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
                            amount: '\$100',
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
                            amount: '\$50',
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
                    amount: '3',
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
          IncomeExpenseBarChart(),
        ],
      ),
    );
  }

  // ----- top spending -----
  Widget _buildTopSpending() {
    List values = [40.0, 20.0, 30.0, 10.0];
    values.sort((a, b) => b.compareTo(a));
    List opacities = [1.0, 0.75, 0.50, 0.25];
    return Container(
      // color: Colors.blue[100],
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
                  buttonText: 'This month',
                  onButtonPressed: () {},
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

  // pie chart section
  // bool _showMorePieChartInfo = false;
  // int _touchedIndex = -1;

  Widget _buildPieChart(values, opacities) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: SizedBox.fromSize(
        size: const Size(140, 140),
        child: PieChart(
          PieChartData(
            pieTouchData: PieTouchData(
              // enabled: true,
              longPressDuration: const Duration(seconds: 3),
              touchCallback: (event, response) {
                // handle the long press on the same section
                // preventing it from printing the same value many times
                // setState(() {
                //   if (event.isInterestedForInteractions ||
                //       response == null ||
                //       response.touchedSection == null) {
                //     _touchedIndex = -1;
                //     return;
                //   }
                //   _touchedIndex = 0;
                //   debugPrint('${response.touchedSection!.touchedSectionIndex}');
                //   _showMorePieChartInfo = true;
                // });
              },
            ),
            sectionsSpace: 0,
            startDegreeOffset: 180,
            sections: [
              _buildPieChartItem(value: values[0], opacity: opacities[0]),
              _buildPieChartItem(value: values[1], opacity: opacities[1]),
              _buildPieChartItem(value: values[2], opacity: opacities[2]),
              _buildPieChartItem(value: values[3], opacity: opacities[3]),
            ],
          ),
          swapAnimationDuration: const Duration(seconds: 1),
        ),
      ),
    );
  }

  PieChartSectionData _buildPieChartItem({
    double value = 0.0,
    double opacity = 1.0,
  }) {
    return PieChartSectionData(
      value: value,
      // title: '$value',
      titleStyle: const TextStyle(
        color: Colors.white,
        fontSize: 10,
      ),
      color: ColorConstant.topSpending.withOpacity(opacity),
      showTitle: false,
      radius: 25,
    );
  }

  Widget _buildPieChartLegend(values, opacities) {
    return Column(
      children: [
        Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildPieChartLegendItem(
                    category: 'Transportation',
                    amount: '\$${values[0]}',
                    color: ColorConstant.topSpending.withOpacity(opacities[0]),
                  ),
                ),
                Expanded(
                  child: _buildPieChartLegendItem(
                    category: 'Groceries',
                    amount: '\$${values[1]}',
                    color: ColorConstant.topSpending.withOpacity(opacities[1]),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: _buildPieChartLegendItem(
                    category: 'Utilities',
                    amount: '\$${values[2]}',
                    color: ColorConstant.topSpending.withOpacity(opacities[2]),
                  ),
                ),
                Expanded(
                  child: _buildPieChartLegendItem(
                    category: 'Entertainment',
                    amount: '\$${values[3]}',
                    color: ColorConstant.topSpending.withOpacity(opacities[3]),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPieChartLegendItem(
      {String category = '', String amount = '', Color? color}) {
    return Row(
      children: [
        _buildSmallCircle(color),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(category, style: HomeTextStyleConstant.pieChartLegendSmall),
            Text(amount, style: HomeTextStyleConstant.pieChartLegendBig),
          ],
        ),
      ],
    );
  }

  Widget _buildSmallCircle(Color? color) {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color ?? Colors.black,
      ),
    );
  }

  // ----- budget plan -----
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
                  InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, RouteName.budgetPlan),
                    child: _buildBudgetOverview(),
                  ),
                  _buildBudgetCards(),
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
      _buildAddButton(),
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
      child: Row(
        children: [
          const Icon(Icons.add, color: Colors.white),
          const SizedBox(width: 8),
          Text('Add New', style: HomeTextStyleConstant.smallAddButton),
        ],
      ),
    );
  }

  Widget _buildBudgetOverview() {
    return const BudgetOverview(
      totalBudget: 130,
      available: 30,
      spend: 0,
      overBudget: 0,
      plannedBudget: 150,
    );
  }

  Widget _buildBudgetCards() {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildBudgetCardItem(),
            const SizedBox(width: 12),
            _buildBudgetCardItem(),
            const SizedBox(width: 12),
            _buildBudgetCardItem(),
          ],
        ),
      ),
    );
  }

  Widget _buildBudgetCardItem() {
    return BudgetCard(
      screen: const BudgetPlanDetailScreen(),
      title: 'Transportation',
      color: ColorConstant.expense,
      topLeft: Row(
        children: [
          Text('\$40', style: HomeTextStyleConstant.budgetCardTitle),
          const SizedBox(width: 6),
          Text('Left', style: HomeTextStyleConstant.medium),
        ],
      ),
      topRight: Row(
        children: [
          Text('out of', style: HomeTextStyleConstant.medium),
          const SizedBox(width: 6),
          Text('\$50', style: HomeTextStyleConstant.budgetCardTitle),
        ],
      ),
      bottomLeft: Text('Today', style: HomeTextStyleConstant.medium),
      bottomRight:
          Text('January 24, 2024', style: HomeTextStyleConstant.medium),
      total: 10,
      spent: 5,
    );
  }

  // ---------- totally spent ----------
  Widget _buildTotalSpend() {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildGeneralTitle('Totally Spent'),
          RoundedContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildGeneralContentHeading(
                  title: 'Totally Spent',
                  amount: '\$256',
                  color: ColorConstant.expense,
                  icon: IconConstant.expense,
                  buttonText: 'Last 7 days',
                  onButtonPressed: () {},
                ),
                const Divider(color: ColorConstant.divider),
                const SizedBox(height: 16),
                Text('Recent Transactions',
                    style: HomeTextStyleConstant.medium),
                const SizedBox(height: 12),
                _buildTransactions(color: ColorConstant.expense),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------- totally earned -----------
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
                  amount: '\$356',
                  color: ColorConstant.income,
                  icon: IconConstant.earn,
                  buttonText: 'Last 7 days',
                  onButtonPressed: () {},
                ),
                const Divider(color: ColorConstant.divider),
                const SizedBox(height: 16),
                Text('Recent Transactions',
                    style: HomeTextStyleConstant.medium),
                const SizedBox(height: 12),
                _buildTransactions(color: ColorConstant.income),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // -------------- transaction -----------------
  Widget _buildTransactions({Color color = Colors.black}) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 2,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.pushNamed(context, RouteName.transaction);
          },
          child: TransactionItem(
              color: color,
              icon: IconHelper.getSVG(
                SVGName.schoolBus,
                color: Colors.white,
              )),
        );
      },
      separatorBuilder: (context, index) {
        return Divider(color: ColorConstant.divider);
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
                    buttonText: 'This month',
                    onButtonPressed: () {},
                  ),
                  const Divider(color: ColorConstant.divider),
                  const SizedBox(height: 16),
                  _buildBills(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBills() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildBillItem(),
          const SizedBox(width: 8),
          _buildBillItem(),
          const SizedBox(width: 8),
          _buildBillItem(),
        ],
      ),
    );
  }

  Widget _buildBillItem() {
    return Container(
      width: 200,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: ColorConstant.divider),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextButton(
        onPressed: () =>
            Navigator.pushNamed(context, RouteName.upcomingBillDetail),
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          ),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _buildSmallRoundedSquare(color: ColorConstant.bill),
                    const SizedBox(width: 12),
                    Text('Today', style: HomeTextStyleConstant.budgetCardTitle),
                  ],
                ),
                IconConstant.getMore(color: const Color(0xffBABCD4)),
              ],
            ),
            const SizedBox(height: 8),
            const Divider(color: ColorConstant.divider),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Netflix', style: HomeTextStyleConstant.medium),
                const SizedBox(height: 2),
                Text('\$2.5',
                    style: HomeTextStyleConstant.numberFocus(
                      color: ColorConstant.black,
                    )),
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
              padding: EdgeInsets.symmetric(vertical: 4),
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
              padding: EdgeInsets.symmetric(vertical: 4),
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
