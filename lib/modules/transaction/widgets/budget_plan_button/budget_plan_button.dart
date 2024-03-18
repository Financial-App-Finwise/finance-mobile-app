import 'package:finwise/core/widgets/buttons/select_item_button.dart';
import 'package:finwise/modules/budget_plan/models/budget_plan_model.dart';
import 'package:finwise/modules/transaction/widgets/budget_plan_button/select_budget_plan_widget.dart';
import 'package:flutter/material.dart';

class BudgetPlanButton extends StatefulWidget {
  final SelectItem<BudgetPlanData> currentItem;
  final void Function(BudgetPlanData) onItemSelected;

  const BudgetPlanButton({
    super.key,
    required this.currentItem,
    required this.onItemSelected,
  });

  @override
  State<BudgetPlanButton> createState() => _BudgetPlanButtonState();
}

class _BudgetPlanButtonState extends State<BudgetPlanButton> {
  late final SelectItem<BudgetPlanData> _currentItem = widget.currentItem;

  @override
  Widget build(BuildContext context) {
    return SelectItemButton(
      currentItem: _currentItem,
      title: _currentItem.title,
      subTitle: _currentItem.subTitle,
      selectionScreen: SelectBudgetPlanWidget(
        onPressed: (budgetPlanData) {
          setState(() {
            _currentItem.item = budgetPlanData;
            _currentItem.subTitle = budgetPlanData.name;
            _currentItem.itemPicked = true;
          });
          widget.onItemSelected(budgetPlanData);
        },
      ),
    );
  }
}
