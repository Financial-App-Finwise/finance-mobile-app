import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/font_constant.dart';
import 'package:finwise/core/constants/home_text_style_constant.dart';
import 'package:finwise/modules/auth/screens/sign_in_screen.dart';
import 'package:finwise/modules/budget_plan/screens/budget_plan_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icons_flutter/icons_flutter.dart';

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
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildProfile(), // almost
              _buildFinance(), // almost
              _buildMainFeatures(),
              _buildSpendingIncome(),
              _buildTopSpending(),
              _buildBudgetPlan(),
              _buildTotalSpend(),
              _buildTotalEarn(),
              _buildUpcomingBill(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfile() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox.fromSize(
                size: Size(56, 56),
                child: CircleAvatar(
                  child: Image.asset('assets/images/Avatar.png'),
                ),
              ),
              SizedBox(width: 16),
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
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => SignInScreen()));
            },
            child: Icon(Icons.notifications_active_outlined),
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
          SizedBox(height: 16),
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
          SizedBox(height: 12),
          // build content
          Container(
            padding: EdgeInsets.all(16),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
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
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Divider(color: Colors.grey[300]),
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
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: VerticalDivider(color: Colors.grey[300]),
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
        icon ?? SizedBox(),
        SizedBox(width: 12),
        Column(
          children: [
            Text(
              text,
              style: HomeTextStyleConstant.medium,
            ),
            Text(
              amount,
              style: HomeTextStyleConstant.numberFocus(
                color: color,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDurationButton() {
    return TextButton(
      onPressed: () {},
      child: Row(
        children: [
          Text(
            'Last 7 days',
            style: HomeTextStyleConstant.small,
          ),
          Icon(
            Icons.arrow_drop_down,
            color: Color(0xff292D32),
          ),
        ],
      ),
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: Color(0xffD3D5E4))),
        ),
      ),
    );
  }

  Widget _buildMainFeatures() {
    return Container(
      alignment: Alignment.topLeft,
      color: Colors.red[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Other Features',
            style: HomeTextStyleConstant.header,
          ),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              _buildFeatureItem(
                  text: 'My Budget',
                  amount: '3',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BudgetPlanScreen(),
                      ),
                    );
                  }),
              SizedBox(width: 12),
              _buildFeatureItem(text: 'Upcoming Bill', amount: '3'),
              SizedBox(width: 12),
              _buildFeatureItem(text: 'Smart Goal', amount: '3'),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(
      {String text = '', String amount = '', void Function()? onPressed}) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        width: 165.5,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [ColorConstant.primary, ColorConstant.secondary],
              stops: [0, 0.8]),
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
            Icon(FlutterIcons.ellipsis1_ant, color: Colors.white),
          ],
        ),
      ),
    );
  }

  Widget _buildSpendingIncome() {
    return Container(
      color: Colors.orange[100],
      alignment: Alignment.topLeft,
      child: Text(
        'Spending and Income',
        style: HomeTextStyleConstant.header,
      ),
    );
  }

  Widget _buildTopSpending() {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        'Top Spending Categories',
        style: HomeTextStyleConstant.header,
      ),
    );
  }

  Widget _buildBudgetPlan() {
    return Container(
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
      child: Text(
        'Totally Spent',
        style: HomeTextStyleConstant.header,
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
