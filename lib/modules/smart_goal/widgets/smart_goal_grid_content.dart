import 'package:finwise/modules/budget_plan/widgets/budget_plan/budget_grid_tile.dart';
import 'package:flutter/material.dart';

class SmartGoalGridView extends StatefulWidget {
  const SmartGoalGridView({super.key});

  @override
  State<SmartGoalGridView> createState() => _SmartGoalGridViewState();
}

class _SmartGoalGridViewState extends State<SmartGoalGridView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _mainContentGridView(),
    );
  }


  Widget _mainContentGridView() {
    return Container(
      color: const Color(0xFFF5F7F8),
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