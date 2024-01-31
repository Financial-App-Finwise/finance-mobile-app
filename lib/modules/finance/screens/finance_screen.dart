import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/widgets/calendar_header_layout.dart';
import 'package:finwise/core/widgets/income_expense_barchart.dart';
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
    return CalendarHeaderLayout(
      addScreen: SizedBox(),
      title: 'My Finance',
      description: 'Effortlessly manage your finance with a powerful simple tool in FinWise',
      firstColor: ColorConstant.secondary,
      secondColor: ColorConstant.primary,
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    return Container(
      color: Colors.amber[200],
      padding: EdgeInsets.only(top: 80, left: 16, right: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildBarChart(),
          ],
        ),
      ),
    );
  }

  Widget _buildBarChart() {
    return Container(
      child: IncomeExpenseBarChart(),
    );
  }
}
