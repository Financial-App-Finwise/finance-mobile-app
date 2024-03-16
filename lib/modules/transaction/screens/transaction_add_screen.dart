import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/helpers/ui_helper.dart';
import 'package:finwise/modules/budget_plan/models/budget_plan_model.dart';
import 'package:finwise/modules/categories/models/categories_model.dart';
import 'package:finwise/modules/smart_goal/stores/smart_goal_store.dart';
import 'package:finwise/modules/transaction/layouts/transaction_form_layout.dart';
import 'package:finwise/modules/transaction/models/transaction_model.dart';
import 'package:finwise/modules/transaction/screens/transaction_create_screen.dart';
import 'package:finwise/modules/upcoming_bill/models/upcoming_bill_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionAddScreen extends StatefulWidget {
  const TransactionAddScreen({super.key});

  @override
  State<TransactionAddScreen> createState() => _TransactionAddScreenState();
}

class _TransactionAddScreenState extends State<TransactionAddScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await _readAll();
    });
  }

  Future _readAll() async {
    await context.read<SmartGoalStore>().readByPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return TransactionFormLayout(
      title: 'Add Transaction',
      amountIncomeController: TextEditingController(),
      amountExpenseController: TextEditingController(),
      noteController: TextEditingController(),
      transactionData: TransactionData(
        date: UIHelper.getDateFormat(DateTime.now().toString(), 'dd MMM, yyyy'),
      ),
      buttonLabel: 'Add Transaction',
      onTap: ({
        bool isIncome = true,
        String expenseType = 'General',
        String amount = '',
        bool hasContributed = false,
        String note = '',
        required BudgetPlanData selectedBudgetPlan,
        required UpcomingBillData selectedUpcomingBill,
        required CategoryData selectedCategory,
      }) async {
        int? selectedBudgetPlanId;
        int? selectedUpcomingBillId;
        int selectedCategoryId = 0;

        if (selectedUpcomingBill.id != 0) {
          selectedUpcomingBillId = selectedUpcomingBill.id;
          selectedCategoryId = selectedUpcomingBill.categoryID;
        } else if (selectedBudgetPlan.id != 0) {
          selectedBudgetPlanId = selectedBudgetPlan.id;
          selectedCategoryId = selectedBudgetPlan.categoryID;
        } else {
          selectedCategoryId = selectedCategory.id;
        }

        bool success = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TransactionCreateScreen(
              transactionData: TransactionData(
                categoryID: selectedCategoryId,
                isIncome: isIncome,
                amount: double.parse(amount),
                hasContributed: hasContributed,
                upcomingbillID: selectedUpcomingBillId,
                budgetplanID: selectedBudgetPlanId,
                expenseType: expenseType,
                date: DateTime.now().toString(),
                note: note,
              ),
            ),
          ),
        );

        if (success) {
          Navigator.pop(context);
        }
      },
    );
  }
}
