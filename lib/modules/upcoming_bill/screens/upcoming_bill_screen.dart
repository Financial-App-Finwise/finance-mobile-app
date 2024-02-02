import 'package:finwise/core/widgets/calendar_header_layout.dart';
import 'package:finwise/modules/budget_plan/screens/add_budget_plan_screen.dart';
import 'package:finwise/modules/upcoming_bill/widgets/upcoming_bill_screen/main_content_list_view.dart';
import 'package:flutter/material.dart';

class UpcomingBillScreen extends StatelessWidget {
  const UpcomingBillScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CalendarHeaderLayout(
        addScreen: AddBudgetPlanScreen(),
        title: 'My upcoming bill',
        description:
            'Effortlessly manage your finance with a powerful simple tool in Finwise.',
        firstColor: Color(0xFF0ABDE3),
        secondColor: Color(0xFF0B8AAF),
        child: MainContentListView(
          totalUpcomingBill: 3,
          category: "Netflex",
          amount: 12.2,
        ),
        // child: _gridView ? _mainContentGridView() : _mainContentListView(),
        // changeView: () => setState(
        //   () {
        //     _gridView = !_gridView;
        //   },
        // ),
        // gridView: _gridView,
      ),
    );
  }
}
