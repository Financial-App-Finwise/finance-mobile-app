import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/home_text_style_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:finwise/core/widgets/budget_card.dart';
import 'package:finwise/core/widgets/budget_overview.dart';
import 'package:finwise/modules/budget_plan/screens/budget_plan_detail_screen.dart';
import 'package:finwise/route.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void deactivate() {
    debugPrint('--> START: home screen deactivate');
    debugPrint('--> END: home screen deactivate');
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
        // color: Colors.yellow[200],
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  _buildProfile(), // almost
                  _buildFinance(), // almost
                  _buildMainFeatures(), // almost
                  _buildSpendingIncome(),
                  _buildTopSpending(),
                  _buildBudgetPlan(),
                  _buildTotalSpend(),
                  _buildTotalEarn(),
                  _buildUpcomingBill(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

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
                  Text('Taylor Lauren',
                      style: HomeTextStyleConstant.profileName),
                ],
              ),
            ],
          ),
          InkWell(
            onTap: () =>
                Navigator.pushReplacementNamed(context, RouteName.signIn),
            child: IconConstant.notification,
          ),
        ],
      ),
    );
  }

  /// TODO
  /// if there is no data, indicate that the user has no data
  /// and needs to add transaction

  Widget _buildNoDataDisplay() {
    return Container();
  }

  Widget _buildEmptyBarChart() {
    return Container();
  }

  Widget _buildEmptyPieChart() {
    return Container();
  }

  Widget _buildGeneralTitle(String text) {
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 12),
      child: Text(text, style: HomeTextStyleConstant.header),
    );
  }

  Widget _buildFinance() {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('My Finance', style: HomeTextStyleConstant.header),
              Row(
                children: [
                  Text('View More',
                      style: HomeTextStyleConstant.headerBoldLink),
                  SizedBox(width: 6),
                  Icon(Icons.arrow_forward, color: ColorConstant.totalIcon),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          // build content
          _roundedContainer(
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
                    Container(
                        child: _buildDurationButton(
                            text: 'Last 7 days',
                            onPressed: () {
                              print('Total Balance');
                            })),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Divider(color: Color(0xfff2f2f2)),
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
                        child: VerticalDivider(color: Color(0xfff2f2f2)),
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
            Text(amount,
                style: HomeTextStyleConstant.numberFocus(color: color)),
          ],
        ),
      ],
    );
  }

  // ----------------------------------------------------------------------

  // Other Features
  Widget _buildMainFeatures() {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text(
            'Other Features',
            style: HomeTextStyleConstant.header,
          ),
          SizedBox(height: 12),
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
                    icon: IconConstant.getUpcomingBill()),
                const SizedBox(width: 12),
                _buildFeatureItem(
                  text: 'Smart Goal',
                  amount: '3',
                  icon: IconConstant.getSmartGoal(color: Colors.white),
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
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
      ),
      child: Container(
        width: 165.5,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [ColorConstant.primary, ColorConstant.secondary],
              stops: const [0, 0.8]),
          borderRadius: BorderRadius.circular(12),
        ),
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
                        HomeTextStyleConstant.numberFocus(color: Colors.white),
                  ),
                ],
              ),
            ),
            icon ?? SizedBox(),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------------------

  // ------------------------------------------------------------

  Widget _buildSpendingIncome() {
    return Container(
      // color: Colors.green[100],
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildGeneralTitle('Spending and Income'),
          _roundedContainer(
            child: Column(
              children: [
                Row(children: [
                  Expanded(child: SizedBox()),
                  _buildDurationButton(
                    text: 'Last 4 months',
                    onPressed: () {},
                  ),
                ]),
                SizedBox(height: 24),
                _buildBarChart(),
                SizedBox(height: 24),
                _buildBarChartLegend(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _roundedContainer({Widget? child}) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(16),
      child: child,
    );
  }

  Widget _buildBarChart() {
    return Container(
      height: 200,
      child: BarChart(
        BarChartData(
          titlesData: FlTitlesData(
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                reservedSize: 32,
                showTitles: true,
                getTitlesWidget: (value, meta) =>
                    _barChartBottomTitles(value, meta),
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                reservedSize: 48,
                showTitles: true,
                interval: 1000,
                getTitlesWidget: (value, meta) {
                  return _barChartleftTitles(value, meta);
                },
              ),
            ),
          ),
          gridData: FlGridData(
            getDrawingVerticalLine: (value) {
              return FlLine(
                color: Color(0xfff2f2f2),
                dashArray: [4],
                strokeWidth: 1,
              );
            },
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Color(0xfff2f2f2),
                dashArray: [4],
                strokeWidth: 1,
              );
            },
            verticalInterval: 0.25,
            horizontalInterval: 1000,
          ),
          borderData: FlBorderData(
            border: DashedBorder.fromBorderSide(
              side: BorderSide(color: Color(0xfff2f2f2)),
              dashLength: 4,
            ),
          ),
          alignment: BarChartAlignment.spaceAround,
          barGroups: [
            _buildBarChartGroup(x: 0, income: 6000, expense: 4000),
            _buildBarChartGroup(x: 1, income: 4000, expense: 2000),
            _buildBarChartGroup(x: 2, income: 8000, expense: 6000),
            _buildBarChartGroup(x: 3, income: 7000, expense: 3000),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _buildBarChartGroup({
    required int x,
    double income = 0,
    double expense = 0,
  }) {
    return BarChartGroupData(x: x, barRods: [
      _buildBarRod(isIncome: true, toY: income),
      _buildBarRod(toY: expense),
    ]);
  }

  BarChartRodData _buildBarRod({
    bool isIncome = false,
    double toY = 0,
  }) {
    return BarChartRodData(
      toY: toY,
      width: 7,
      color: isIncome ? ColorConstant.income : ColorConstant.expense,
      borderRadius: BorderRadius.zero,
    );
  }

  Widget _barChartBottomTitles(double value, TitleMeta meta) {
    final titles = ['Sep 2023', 'Oct 2023', 'Nov 2023', 'Dec 2023'];
    return SideTitleWidget(
      child: Text(titles[value.toInt()],
          style: HomeTextStyleConstant.barChartBottomTitle),
      axisSide: meta.axisSide,
    );
  }

  Widget _barChartleftTitles(double value, TitleMeta meta) {
    return SideTitleWidget(
      child: Text('\$${value.toInt()}',
          style: HomeTextStyleConstant.barChartLeftTitle),
      axisSide: meta.axisSide,
    );
  }

  Widget _buildBarChartLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: _buildLegendItem('Income', ColorConstant.income)),
        Expanded(child: _buildLegendItem('Expense', ColorConstant.expense)),
      ],
    );
  }

  Widget _buildLegendItem(String text, Color color) {
    return Row(
      children: [
        Container(
          height: 16,
          width: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        SizedBox(width: 8),
        Text(text, style: HomeTextStyleConstant.barChartLegend),
      ],
    );
  }

  // ------------------------------------------------------------------

  // --------------------------------------------------------------------

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
          _roundedContainer(
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
                _buildPieChart(values, opacities),
                _buildPieChartLegend(values, opacities),
                // _showMorePieChartInfo ? _buildMorePieChartInfo() : SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // General
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
            icon ?? SizedBox(),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: HomeTextStyleConstant.medium),
                Text(amount,
                    style: HomeTextStyleConstant.numberFocus(color: color)),
              ],
            )
          ]),
        ),
        _buildDurationButton(text: buttonText, onPressed: onButtonPressed),
      ],
    );
  }

  // General
  Widget _buildDurationButton({
    VoidCallback? onPressed,
    String text = 'Button',
  }) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: Color(0xffD3D5E4)),
          ),
        ),
      ),
      child: Row(children: [
        Text(text, style: HomeTextStyleConstant.small),
        const Icon(Icons.arrow_drop_down, color: Color(0xff292D32)),
      ]),
    );
  }

  bool _showMorePieChartInfo = false;
  int _touchedIndex = -1;

  /// Pie Chart Section
  Widget _buildMorePieChartInfo({int touchedIndex = 0}) {
    return Container(
      constraints: BoxConstraints(maxHeight: 200),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: 4,
        itemBuilder: (context, index) => Card(
          elevation: 0,
          child: ListTile(
            leading: _buildSmallCircle(Colors.orange),
            title: Text('Other'),
          ),
        ),
      ),
    );
  }

  Widget _buildPieChart(values, opacities) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: SizedBox.fromSize(
        size: Size(140, 140),
        child: PieChart(
          PieChartData(
            pieTouchData: PieTouchData(
              // enabled: true,
              longPressDuration: Duration(seconds: 3),
              touchCallback: (event, response) {
                // handle the long press on the same section
                // preventing it from printing the same value many times
                setState(() {
                  if (event.isInterestedForInteractions ||
                      response == null ||
                      response.touchedSection == null) {
                    _touchedIndex = -1;
                    return;
                  }
                  _touchedIndex = 0;
                  debugPrint('${response.touchedSection!.touchedSectionIndex}');
                  _showMorePieChartInfo = true;
                });
                // showDialog(
                //     context: context,
                //     builder: (ctx) {
                //       return AlertDialog(

                //         content: Container(
                //           height: 200,
                //           color: Colors.white,
                //         ),
                //       );
                //     });
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
          swapAnimationDuration: Duration(seconds: 1),
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
      title: '$value',
      titleStyle: TextStyle(
        color: Colors.white,
        fontSize: 10,
      ),
      color: ColorConstant.topSpending.withOpacity(opacity),
      showTitle: true,
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
        SizedBox(width: 8),
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

  // --------------------------------------------------------------------

  ////
  ///

  Widget _buildBudgetPlan() {
    return Container(
      color: Colors.pink[200],
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildGeneralTitle('My Budget Plan'),
          _roundedContainer(
            child: Column(
              children: [
                _buildBudgetPlanHeader(),
                _buildBudgetOverview(),
                _buildBudgetCards(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetPlanHeader() {
    return Container(
      color: Colors.amber[200],
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        _buildBudgetPlanDate(),
        _buildAddButton(),
      ]),
    );
  }

  Widget _buildBudgetPlanDate() {
    return Container(
      child: Text('Date filter...'),
    );
  }

  Widget _buildAddButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, RouteName.addBudget);
      },
      child: Row(
        children: [
          Icon(Icons.add, color: Colors.white),
          SizedBox(width: 8),
          Text('Add New'),
        ],
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(ColorConstant.secondary),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        ),
      ),
    );
  }

  Widget _buildBudgetOverview() {
    return BudgetOverview(
      totalBudget: 130,
      available: 30,
      spend: 0,
      overBudget: 0,
      plannedBudget: 150,
    );
  }

  Widget _buildBudgetCards() {
    return SingleChildScrollView(
      child: Row(
        children: [
          _buildBudgetCardItem(),
        ],
      ),
    );
  }

  Widget _buildBudgetCardItem() {
    return Container(
      child: BudgetCard(
        screen: BudgetPlanDetailScreen(),
        // title: 'Transportation',
        // color: Colors.blue,
        // transaction: 0,
        // remain: 0,
        // total: 0,
        // spent: 0,
      ),
    );
  }

  // --------------------------------------------------------------------------

  //----------------------------------------------------------------------------

  Widget _buildTotalSpend() {
    return Container(
      color: Colors.green[100],
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildGeneralTitle('Totally Spent'),
          _roundedContainer(
            child: Column(
              children: [
                _buildGeneralContentHeading(
                  title: 'Totally Spent',
                  amount: '\$256',
                  color: ColorConstant.expense,
                  icon: IconConstant.expense,
                  buttonText: 'Last 7 days',
                  onButtonPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------

  //----------------------------------------------------------------------------

  Widget _buildTotalEarn() {
    return Container(
      color: Colors.yellow[100],
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildGeneralTitle('Totally Earned'),
          _roundedContainer(
            child: Column(
              children: [
                _buildGeneralContentHeading(
                  title: 'Totally Earned',
                  amount: '\$356',
                  color: ColorConstant.income,
                  icon: IconConstant.earn,
                  buttonText: 'Last 7 days',
                  onButtonPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------

  //----------------------------------------------------------------------------

  Widget _buildUpcomingBill() {
    return Container(
      color: Colors.red[100],
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildGeneralTitle('Upcoming Bill'),
          _roundedContainer(
            child: Column(
              children: [
                _buildGeneralContentHeading(
                  title: 'Total Upcoming Bills',
                  amount: '4',
                  color: ColorConstant.bill,
                  icon: IconConstant.getUpcomingBill(color: ColorConstant.bill),
                  buttonText: 'This month',
                  onButtonPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
