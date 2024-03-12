import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:finwise/core/helpers/ui_helper.dart';
import 'package:finwise/modules/budget_plan/models/budget_plan_model.dart';
import 'package:finwise/modules/budget_plan/store/budget_plan_store.dart';
import 'package:finwise/modules/budget_plan/widgets/add_budget_plan/budget_plan_create_screen.dart';
import 'package:finwise/modules/budget_plan/widgets/amount_input.dart';
import 'package:finwise/modules/budget_plan/widgets/budget_recommendation.dart';
import 'package:finwise/modules/budget_plan/widgets/calendar_month_widget.dart';
import 'package:finwise/modules/budget_plan/widgets/expenses_name_input.dart';
import 'package:finwise/modules/categories/models/categories_model.dart';
import 'package:finwise/modules/categories/widgets/category_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonthlyBudget extends StatefulWidget {
  final VoidCallback backToMain;

  const MonthlyBudget({
    super.key,
    required this.backToMain,
  });

  @override
  State<MonthlyBudget> createState() => _MonthlyBudgetState();
}

class _MonthlyBudgetState extends State<MonthlyBudget> {
  late BudgetPlanStore store = context.read<BudgetPlanStore>();
  final _expenseNameController = TextEditingController();
  final _budgetAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _budgetAmountController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _description(),
      ],
    );
  }

  Widget _description() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Add monthly budget',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 32,
            letterSpacing: 1,
            color: ColorConstant.black,
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 72,
              height: 72,
              child: IconConstant.myBudget(
                color: ColorConstant.primary,
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            const Expanded(
              child: Text(
                'Budget plan in specific category that recurs every month.',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.75,
                  height: 1.5,
                  color: ColorConstant.mainText,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        _form(),
        const SizedBox(
          height: 20,
        ),
        _buttons(),
      ],
    );
  }

  CategoryData _selectedCategory = CategoryData();
  DateTime _selectedDate = DateTime.now();

  Widget _form() {
    return Column(
      children: [
        // Amount input
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CategoryButton(
              setCategory: (category) {
                setState(() {
                  _selectedCategory = category;
                  _isFormFilled;
                });
              },
              category: _selectedCategory,
            ),
            const SizedBox(
              height: 20,
            ),
            CalendarMonthWidget(
              date: _selectedDate,
              selected: DateTime(_selectedDate.year, _selectedDate.month),
              onChange: (value) {
                setState(() {
                  _selectedDate = value;
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            AmountInput(
                controller: _budgetAmountController,
                onChange: (value) => setState(() {
                      _isFormFilled;
                    })),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Amount needed to be spent in this category.',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                letterSpacing: 0.5,
                height: 1.5,
                color: ColorConstant.mainText,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const BudgetRecommendation(amount: 74),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpenseNameInput(controller: _expenseNameController),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Category name will be used if no custom name is set.',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                letterSpacing: 0.5,
                height: 1.5,
                color: ColorConstant.mainText,
              ),
            ),
          ],
        ),
      ],
    );
  }

  bool get _isFormFilled =>
      _selectedCategory.id != 0 && _budgetAmountController.text.isNotEmpty;

  Widget _buttons() {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => widget.backToMain(),
            child: _backButton(),
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: _isFormFilled
              ? InkWell(
                  onTap: () async {
                    String budgetPlanDate = UIHelper.getDateFormat(
                        _selectedDate.toString(), 'yyyy-MM-dd');
                    bool success = false;

                    success = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BudgetPlanCreateScreen(
                          budgetPlanData: BudgetPlanData(
                            categoryID: _selectedCategory.id,
                            isMonthly: true,
                            name: _expenseNameController.text == ''
                                ? _selectedCategory.name
                                : _expenseNameController.text,
                            amount: int.parse(_budgetAmountController.text),
                            date: budgetPlanDate,
                            isRecurring: false,
                          ),
                        ),
                      ),
                    );
                    if (success) {
                      context.read<BudgetPlanStore>().read(refreshed: true);
                      Navigator.pop(context);
                    }
                  },
                  child: _createButton(),
                )
              : _createButton(isFormFill: false),
        ),
      ],
    );
  }

  Widget _backButton() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 24,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: ColorConstant.primary,
          width: 1,
        ),
      ),
      child: const Text(
        'Back',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          letterSpacing: 1,
          color: ColorConstant.primary,
        ),
      ),
    );
  }

  Widget _createButton({bool isFormFill = true}) {
    return isFormFill
        ? Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 24,
            ),
            decoration: BoxDecoration(
              color: ColorConstant.secondary,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: ColorConstant.secondary,
                width: 1,
              ),
            ),
            child: const Text(
              'Create',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                letterSpacing: 1,
                color: ColorConstant.white,
              ),
            ),
          )
        : Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 24,
            ),
            decoration: BoxDecoration(
              color: ColorConstant.secondary.withOpacity(0.4),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: ColorConstant.secondary.withOpacity(0.4),
                width: 1,
              ),
            ),
            child: const Text(
              'Create',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                letterSpacing: 1,
                color: ColorConstant.white,
              ),
            ),
          );
  }
}
