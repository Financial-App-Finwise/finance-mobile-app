import 'package:finwise/modules/budget_plan/models/budget_plan_model.dart';
import 'package:finwise/modules/categories/models/categories_model.dart';
import 'package:finwise/modules/transaction/layouts/transaction_form_layout.dart';
import 'package:finwise/modules/transaction/models/transaction_model.dart';
import 'package:finwise/modules/transaction/models/transaction_post_model.dart';
import 'package:finwise/modules/transaction/screens/transaction_update_screen.dart';
import 'package:finwise/modules/upcoming_bill/models/upcoming_bill_model.dart';
import 'package:finwise/route.dart';
import 'package:flutter/material.dart';

class TransactionEditScreen extends StatefulWidget {
  const TransactionEditScreen({super.key});

  @override
  State<TransactionEditScreen> createState() => _TransactionEditScreenState();
}

class _TransactionEditScreenState extends State<TransactionEditScreen> {
  late final args =
      ModalRoute.of(context)!.settings.arguments as TransactionData;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TransactionFormLayout(
      amountController: TextEditingController(text: args.amount.toString()),
      amountExpenseController:
          TextEditingController(text: args.amount.toString()),
      noteController: TextEditingController(text: args.note),
      dateController: TextEditingController(text: args.date),
      transactionData: args,
      title: 'Edit Transaction',
      isIncome: args.isIncome,
      expenseType: args.expenseType,
      selectedUpcomingBillID: args.upcomingbillID ?? 0,
      defaultBillName: '${args.upcomingbillID ?? 0}',
      canChangeType: false,
      amount: args.amount,
      buttonLabel: 'Edit Transaction',
      onTap: ({
        bool isIncome = true,
        String expenseType = 'General',
        String amount = '',
        bool hasContributed = false,
        String note = '',
        required BudgetPlanData selectedBudgetPlan,
        required UpcomingBillData selectedUpcomingBill,
        required CategoryData selectedCategory,
        required TransactionPost transactionPost,
      }) async {
        selectedBudgetPlan = BudgetPlanData(id: args.budgetplanID ?? 0);
        selectedUpcomingBill = UpcomingBillData(id: args.upcomingbillID ?? 0);
        selectedCategory = CategoryData(id: args.categoryID);
        int? selectedBudgetPlanId;
        int? selectedUpcomingBillId;
        int selectedCategoryId = 0;

        if (args.upcomingbillID != 0) {
          selectedUpcomingBillId = args.upcomingbillID;
          selectedCategoryId = args.categoryID;
        } else if (args.budgetplanID != 0) {
          selectedBudgetPlanId = args.budgetplanID;
          selectedCategoryId = args.categoryID;
        } else {
          selectedCategoryId = args.categoryID;
        }

        bool success = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TransactionUpdateScreen(
                transactionPost: transactionPost,
                id: args.id,
              ),
            ));
        if (success) {
          Navigator.pop(context);
          Navigator.pop(context);
        }
      },
    );
  }
}
