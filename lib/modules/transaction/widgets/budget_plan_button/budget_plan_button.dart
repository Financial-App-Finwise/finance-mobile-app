import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/modules/budget_plan/models/budget_plan_model.dart';
import 'package:finwise/modules/transaction/widgets/budget_plan_button/select_budget_plan_widget.dart';
import 'package:flutter/material.dart';

class BudgetPlanButton extends StatefulWidget {
  late void Function(BudgetPlanData) onPressed;
  late int defaultBudgetId;
  late String defaultBudgetName;

  BudgetPlanButton({
    super.key,
    required this.onPressed,
    this.defaultBudgetId = 0,
    this.defaultBudgetName = 'no name',
  });

  @override
  State<BudgetPlanButton> createState() => _BudgetPlanButtonState();
}

class _BudgetPlanButtonState extends State<BudgetPlanButton> {
  late BudgetPlanData selectedBudgetPlan = BudgetPlanData(
    id: widget.defaultBudgetId,
    name: widget.defaultBudgetName,
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              SelectBudgetPlanWidget(
            onPressed: (budgetPlanData) {
              setState(() {
                selectedBudgetPlan = budgetPlanData;
              });
              widget.onPressed(budgetPlanData);
            },
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 20,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: ColorConstant.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    selectedBudgetPlan.name == 'no name'
                        ? _unpickCategoryIcon()
                        : _pickedCategoryIcon(),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Budget Plan',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            letterSpacing: 0.75,
                            color: ColorConstant.mainText,
                          ),
                        ),
                        Text(
                          selectedBudgetPlan.name == 'no name'
                              ? 'Select one budget plan'
                              : selectedBudgetPlan.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            letterSpacing: 0.75,
                            color: selectedBudgetPlan.name == 'no name'
                                ? const Color(0xFF656B9F)
                                : ColorConstant.mainText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                IconHelper.getSVG(
                  SVGName.arrowRight,
                  color: ColorConstant.thin,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _unpickCategoryIcon() {
    return Container(
      width: 36,
      height: 36,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color(0xFFD3D5E4),
        borderRadius: BorderRadius.circular(50),
      ),
      child: IconHelper.getSVG(
        SVGName.myBudget,
        color: ColorConstant.white,
      ),
    );
  }

  Widget _pickedCategoryIcon() {
    return Container(
      width: 36,
      height: 36,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: ColorConstant.secondary,
        borderRadius: BorderRadius.circular(50),
      ),
      child: IconHelper.getSVG(
        SVGName.myBudget,
        color: ColorConstant.white,
      ),
    );
  }
}
