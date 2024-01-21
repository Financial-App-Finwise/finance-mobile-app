import 'package:finwise/core/widgets/calendar_header_layout.dart';
import 'package:finwise/modules/budget_plan/models/budget_card.dart';
import 'package:finwise/modules/budget_plan/widgets/budget_plan/budget_grid_tile.dart';
import 'package:finwise/modules/budget_plan/widgets/budget_plan/budget_overview.dart';
import 'package:finwise/modules/budget_plan/widgets/budget_plan/filtered_budget.dart';
import 'package:flutter/material.dart';

class BudgetPlanScreen extends StatefulWidget {
  const BudgetPlanScreen({super.key});

  @override
  State<BudgetPlanScreen> createState() => _BudgetPlanScreenState();
}

class _BudgetPlanScreenState extends State<BudgetPlanScreen> {
  bool _gridView = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CalendarHeaderLayout(
        title: 'My budget plan',
        description:
            'Effortlessly manage your finance with a powerful simple tool in FinWise',
        firstColor: const Color(0xFF0ABDE3),
        secondColor: const Color(0xFF0B8AAF),
        child: _gridView ? _mainContentGridView() : _mainContentListView(),
        changeView: () => setState(
          () {
            _gridView = !_gridView;
          },
        ),
      ),
    );
  }

// Main content list view
  Widget _mainContentListView() {
    return Container(
      color: const Color(0xFFF5F7F8),
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 77,
        bottom: 16,
      ),
      child: const Column(
        children: [
          BudgetOverview(
              totalBudget: 3,
              available: 130,
              spend: 30,
              overBudget: 0,
              plannedBudget: 150),
          SizedBox(
            height: 16,
          ),
          FilteredBudget(filterTitles: [
            'All',
            'One-time budget',
            'Monthly budget',
            'Monthly budget',
            'Monthly budget'
          ], budgetCards: [
            BudgetCardModel(
                title: 'Transportation',
                transaction: 7,
                remain: 40,
                spent: 10,
                total: 50),
            BudgetCardModel(
                title: 'Transportation',
                transaction: 7,
                remain: 40,
                spent: 10,
                total: 50),
            BudgetCardModel(
                title: 'Transportation',
                transaction: 7,
                remain: 40,
                spent: 10,
                total: 50),
          ])
        ],
      ),
    );
  }

  Widget _mainContentGridView() {
    return Container(
      color: const Color(0xFFF5F7F8),
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 77,
        bottom: 16,
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 12,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          crossAxisCount: 3,
        ),
        itemBuilder: (context, index) =>
            const BudgetGridTile(month: 'January', budget: 3),
      ),
    );
  }
}
