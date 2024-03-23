import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:finwise/modules/auth/stores/auth_store.dart';
import 'package:finwise/modules/budget_plan/models/budget_plan_model.dart';
import 'package:finwise/modules/budget_plan/models/prediction_model.dart';
import 'package:finwise/modules/budget_plan/screens/test_category.dart';
import 'package:finwise/modules/budget_plan/store/budget_plan_store.dart';
import 'package:finwise/modules/budget_plan/widgets/amount_input.dart';
import 'package:finwise/modules/budget_plan/widgets/budget_plan_edit_screen.dart';
import 'package:finwise/modules/budget_plan/widgets/budget_recommendation.dart';
import 'package:finwise/modules/budget_plan/widgets/calendar_month_widget.dart';
import 'package:finwise/modules/budget_plan/widgets/expenses_name_input.dart';
import 'package:finwise/modules/categories/models/categories_model.dart';
import 'package:finwise/modules/categories/stores/category_store.dart';
import 'package:finwise/modules/categories/widgets/category_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class EditBudgetPlanScreen extends StatefulWidget {
  const EditBudgetPlanScreen({super.key});

  @override
  State<EditBudgetPlanScreen> createState() => _EditBudgetPlanScreenState();
}

class _EditBudgetPlanScreenState extends State<EditBudgetPlanScreen> {
  late AuthStore authStore = context.read<AuthStore>();
  late final BudgetPlanData args =
      ModalRoute.of(context)!.settings.arguments as BudgetPlanData;

  late final _expenseNameController = TextEditingController(text: args.name);
  late final _budgetAmountController =
      TextEditingController(text: '${args.amount.toInt()}');

  late DateTime _selectedDate = DateTime.parse(args.date);

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 0), () async {
      if (mounted) {
        await context.read<BudgetPlanStore>().readPrediction(
              authStore.user!.apiToken,
              _selectedCategory.name,
              _selectedDate.month,
            );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                _title(),
                const SizedBox(
                  height: 20,
                ),
                _form(),
                const SizedBox(
                  height: 20,
                ),
                _buttons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _title() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: IconConstant.close,
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                const EdgeInsets.all(0),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TestCategory()));
          },
          child: const Text(
            'Edit budget',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 32,
              letterSpacing: 1,
              color: ColorConstant.black,
            ),
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
              child:  IconConstant.myBudget(
                color: ColorConstant.primary,
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            const Expanded(
              child: Text(
                'Budget plan in specific category for this month only.',
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
      ],
    );
  }

  late List<CategoryData> categoryList =
      context.read<CategoryStore>().categoryModel.categoryDataList;
  late CategoryData _selectedCategory =
      categoryList.firstWhere((category) => category.id == args.categoryID);

  Widget _form() {
    return Observer(builder: (context) {
      PredictionData predictionData =
          context.read<BudgetPlanStore>().prediction.data;
      return Column(
        children: [
          // Category
          CategoryButton(
            setCategory: (category) async {
              // debugPrint('${category.id}');
              setState(() {
                _selectedCategory = category;
              });
              await context.read<BudgetPlanStore>().readPrediction(
                    authStore.user!.apiToken,
                    _selectedCategory.name,
                    _selectedDate.month,
                  );
            },
            category: _selectedCategory,
          ),
          const SizedBox(
            height: 20,
          ),

          CalendarMonthWidget(
            date: _selectedDate,
            selected: DateTime(_selectedDate.year, _selectedDate.month),
            onChange: (value) async {
              setState(() {
                _selectedDate = value;
              });
              await context.read<BudgetPlanStore>().readPrediction(
                    authStore.user!.apiToken,
                    _selectedCategory.name,
                    _selectedDate.month,
                  );
            },
          ),

          const SizedBox(
            height: 20,
          ),

          // Amount input
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AmountInput(controller: _budgetAmountController),
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
              predictionData.predictedBudget != '0'
                  ? BudgetRecommendation(
                      amount: predictionData.predictedBudget,
                      nullData: false,
                    )
                  : BudgetRecommendation(
                      amount: predictionData.predictedBudget,
                      nullData: true,
                    ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          // Name input
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
    });
  }

  Widget _buttons() {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: _backButton(),
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: InkWell(
            onTap: () async {
              bool success = false;
              success = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BudgetPlanEditScreen(
                    budgetPlanData: BudgetPlanData(
                      id: args.id,
                      categoryID: _selectedCategory.id,
                      isMonthly: args.isMonthly,
                      date: _selectedDate.toString(),
                      name: _expenseNameController.text == ''
                          ? _selectedCategory.name
                          : _expenseNameController.text,
                      amount: int.parse(_budgetAmountController.text),
                    ),
                  ),
                ),
              );

              if (success) {
                Navigator.pop(context, success);
              }

              // context.read<BudgetPlanStore>().edit(
              //       BudgetPlanData(
              //         id: args.id,
              //         categoryID: _selectedCategory.id,
              //         isMonthly: args.isMonthly,
              //         date: _selectedDate.toString(),
              //         name: _expenseNameController.text == ''
              //             ? _selectedCategory.name
              //             : _expenseNameController.text,
              //         amount: int.parse(_budgetAmountController.text),
              //       ),
              //     );
            },
            child: _createButton(),
          ),
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

  Widget _createButton() {
    return Container(
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
        'Save',
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
