import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/widgets/buttons/select_item_button.dart';
import 'package:finwise/modules/budget_plan/models/budget_plan_model.dart';
import 'package:finwise/modules/transaction/widgets/budget_plan_button/select_budget_plan_widget.dart';
import 'package:flutter/material.dart';

class BudgetPlanButton extends StatefulWidget {
  final void Function(BudgetPlanData) onItemSelected;
  final int defaultBudgetId;
  final String defaultBudgetName;

  const BudgetPlanButton({
    super.key,
    required this.onItemSelected,
    this.defaultBudgetId = 0,
    this.defaultBudgetName = 'no name',
  });

  @override
  State<BudgetPlanButton> createState() => _BudgetPlanButtonState();
}

class _BudgetPlanButtonState extends State<BudgetPlanButton> {
  late final SelectItem<BudgetPlanData> _currentItem = SelectItem(
    title: 'Budget PLan',
    subTitle: 'Select a budget plan',
    pickedIcon: IconHelper.getSVG(SVGName.myBudget, color: Colors.white),
    unpickedIcon: IconHelper.getSVG(SVGName.myBudget, color: Colors.white),
    backgroundColor: ColorConstant.expense,
    item: BudgetPlanData(),
  );

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
