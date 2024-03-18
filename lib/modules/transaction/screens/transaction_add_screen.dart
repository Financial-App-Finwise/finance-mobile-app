import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/helpers/ui_helper.dart';
import 'package:finwise/modules/budget_plan/models/budget_plan_model.dart';
import 'package:finwise/modules/categories/models/categories_model.dart';
import 'package:finwise/modules/smart_goal/stores/smart_goal_store.dart';
import 'package:finwise/modules/transaction/layouts/transaction_form_layout.dart';
import 'package:finwise/modules/transaction/models/transaction_model.dart';
import 'package:finwise/modules/transaction/models/transaction_post_model.dart';
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
      dateController: TextEditingController(),
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
        required TransactionPost transactionPost,
      }) async {

        print(transactionPost.toJson());

        // bool success = await Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (_) =>
        //           TransactionCreateScreen(transactionPost: transactionPost)),
        // );

        // if (success) {
        //   Navigator.pop(context);
        // }
      },
    );
  }
}
