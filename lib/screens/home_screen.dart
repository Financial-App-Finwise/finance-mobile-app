import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/home_text_style_constant.dart';
import 'package:finwise/modules/auth/screens/sign_in_screen.dart';
import 'package:finwise/modules/budget_plan/screens/budget_plan_screen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _buildAppBar(),
      body: _buildBody(),
      backgroundColor: ColorConstant.backgroundColor,
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
                child: CircleAvatar(
                  child: Image.asset('assets/images/Avatar.png'),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome Back,',
                    style: HomeTextStyleConstant.welcome,
                  ),
                  Text(
                    'Taylor Lauren',
                    style: HomeTextStyleConstant.profileName,
                  ),
                ],
              ),
            ],
          ),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SignInScreen()));
            },
            child: const Icon(Icons.notifications_active_outlined),
          ),
        ],
      ),
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
              Text(
                'My Finance',
                style: HomeTextStyleConstant.header,
              ),
              Row(
                children: [
                  Text(
                    'View More',
                    style: HomeTextStyleConstant.headerBoldLink,
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: ColorConstant.totalIcon,
                  ),
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
                          icon: Icon(
                            FlutterIcons.ellipsis1_ant,
                            color: ColorConstant.totalIcon,
                          )),
                    ),
                    Container(child: _buildDurationButton()),
                  ],
                ),
                Container(
                  // color: Colors.pink,
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
                          icon: Icon(
                            FlutterIcons.ellipsis1_ant,
                            color: ColorConstant.incomeIcon,
                          ),
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
                          icon: Icon(
                            FlutterIcons.ellipsis1_ant,
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

  Widget _buildDurationButton() {
    return TextButton(
      onPressed: () {},
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(color: Color(0xffD3D5E4))),
        ),
      ),
      child: Row(
        children: [
          Text(
            'Last 7 days',
            style: HomeTextStyleConstant.small,
          ),
          const Icon(
            Icons.arrow_drop_down,
            color: Color(0xff292D32),
          ),
        ],
      ),
    );
  }

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
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              _buildFeatureItem(
                  text: 'My Budget',
                  amount: '3',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BudgetPlanScreen(),
                      ),
                    );
                  }),
              const SizedBox(width: 12),
              _buildFeatureItem(text: 'Upcoming Bill', amount: '3'),
              const SizedBox(width: 12),
              _buildFeatureItem(text: 'Smart Goal', amount: '3'),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem({
    String text = '',
    String amount = '',
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
            const Icon(FlutterIcons.ellipsis1_ant, color: Colors.white),
          ],
        ),
      ),
    );
  }

  /////////

  Widget _buildSpendingIncome() {
    return Container(
      // color: Colors.green[100],
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text(
            'Spending and Income',
            style: HomeTextStyleConstant.header,
          ),
          SizedBox(height: 12),
          _roundedContainer(
            child: Column(
              children: [
                Row(children: [
                  Expanded(child: SizedBox()),
                  _buildDurationButton()
                ]),
                SizedBox(height: 24),
                _buildBarChart(),
                SizedBox(height: 24),
                _buildLegend(),
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
    print(value);
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

  Widget _buildLegend() {
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

  ///

  Widget _buildTopSpending() {
    return Container(
      color: Colors.blue[100],
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          SizedBox(height: 20),
          Text(
            'Top Spending Categories',
            style: HomeTextStyleConstant.header,
          ),
          SizedBox(height: 12),
          _roundedContainer(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text('Text'),
                    ),
                    _buildDurationButton(),
                  ],
                ),
                SizedBox(height: 30),
                _buildPieChart(),
                SizedBox(height: 30),
                _buildPieChartLegend(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPieChart() {
    List values = [40.0, 20.0, 30.0, 10.0];
    values.sort((a, b) => b.compareTo(a));
    List opacities = [1.0, 0.75, 0.50, 0.25];

    print(values);
    return Container(
      height: 200,
      child: PieChart(
        PieChartData(
          startDegreeOffset: 180,
          sections: [
            _buildPieChartItem(value: values[0], opacity: opacities[0]),
            _buildPieChartItem(value: values[1], opacity: opacities[1]),
            _buildPieChartItem(value: values[2], opacity: opacities[2]),
            _buildPieChartItem(value: values[3], opacity: opacities[3]),
          ],
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
      color: ColorConstant.topSpending.withOpacity(opacity),
      showTitle: false,
    );
  }

  Widget _buildPieChartLegend() {
    return Row(
      children: [
        Text('item1')
      ],
    );
  }

  ////
  ///
  ////////
  ///
  ///
  ///
  ///

  Widget _buildBudgetPlan() {
    return Container(
      color: Colors.pink[200],
      alignment: Alignment.topLeft,
      child: Text(
        'My Budget Plan',
        style: HomeTextStyleConstant.header,
      ),
    );
  }

  Widget _buildTotalSpend() {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          SizedBox(height: 20),
          Text(
            'Totally Spent',
            style: HomeTextStyleConstant.header,
          ),
        ],
      ),
    );
  }

  Widget _buildTotalEarn() {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        'Totally Earned',
        style: HomeTextStyleConstant.header,
      ),
    );
  }

  Widget _buildUpcomingBill() {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        'Upcoming Bill',
        style: HomeTextStyleConstant.header,
      ),
    );
  }
}
