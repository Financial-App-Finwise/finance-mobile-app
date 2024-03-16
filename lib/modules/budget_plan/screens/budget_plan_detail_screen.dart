import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/widgets/custom_icon_button.dart';
import 'package:finwise/modules/budget_plan/models/budget_plan_model.dart';
import 'package:finwise/modules/budget_plan/screens/edit_budget_plan_screen.dart';
import 'package:finwise/modules/budget_plan/store/budget_plan_store.dart';
import 'package:finwise/modules/budget_plan/widgets/budget_plan_detail/six_month_chart.dart';
import 'package:finwise/modules/budget_plan/widgets/budget_plan_detail/this_month_content.dart';
import 'package:finwise/modules/budget_plan/widgets/budget_plan_detail/transaction_content.dart';
import 'package:finwise/route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BudgetPlanDetailScreen extends StatefulWidget {
  const BudgetPlanDetailScreen({super.key});

  @override
  State<BudgetPlanDetailScreen> createState() => _BudgetPlanDetailScreenState();
}

class _BudgetPlanDetailScreenState extends State<BudgetPlanDetailScreen> {
  late final BudgetPlanData args =
      ModalRoute.of(context)!.settings.arguments as BudgetPlanData;

  final Map<String, dynamic> data = {
    "06": 10,
    "07": 20,
    "08": 50,
    "09": 30,
    "10": 20,
    "11": 40,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xFFFBA6A6), Color(0xFFEE5353)],
              stops: [0.2, 0.8]),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _topBarContent(),
              Expanded(
                child: Container(
                  color: ColorConstant.backgroundColor,
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: _mainContent(),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topBarContent() {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xFFFBA6A6), Color(0xFFEE5353)], stops: [0.2, 0.8]),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          CustomIconButton(
            onPressed: () => Navigator.pop(context),
            icon: IconHelper.getSVG(
              SVGName.arrowBack,
              color: ColorConstant.white,
            ),
          ),

          const SizedBox(
            height: 12,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Title
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(4)),
                    child: const Icon(
                      Icons.car_rental_outlined,
                      color: Color(0xFFEE5353),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        args.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            color: Color(0xFFFFFFFF)),
                      ),
                      const Text(
                        'Budget Category',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Color(0xFFFFFFFF)),
                      ),
                    ],
                  ),
                ],
              ),

              // Action Icon Buttons
              Row(
                children: [
                  // Edit Icon Button
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: IconButton(
                      onPressed: () async {
                        var result = await Navigator.pushNamed(
                          context,
                          RouteName.editBudget,
                          arguments: args,
                        );
                        if (result.toString().toLowerCase() == "true") {
                          Navigator.pop(context);
                          await context
                              .read<BudgetPlanStore>()
                              .read(refreshed: true);
                        }
                      },
                      icon: IconHelper.getSVG(
                        SVGName.edit,
                        color: ColorConstant.white,
                      ),
                      style: ButtonStyle(
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(0)),
                      ),
                    ),
                  ),

                  const SizedBox(
                    width: 6,
                  ),

                  // Delete Icon Button
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: IconButton(
                      onPressed: () {
                        _showModal(context);
                      },
                      icon: IconHelper.getSVG(
                        SVGName.delete,
                        color: ColorConstant.white,
                      ),
                      style: ButtonStyle(
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(0)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _mainContent() {
    return Container(
      color: const Color(0xFFF5F7F8),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ThisMonthContent(
            transaction: args.amount.toInt(),
            total: args.amount.toInt(),
            remain: args.amount.toInt(),
            spent: args.amount.toInt(),
          ),
          const SizedBox(
            height: 16,
          ),
          SixMonthChart(
            sixMonthBudget: data,
            average: 10,
            thisMonth: 50,
          ),
          const SizedBox(
            height: 16,
          ),
          const TransactionContent(),
        ],
      ),
    );
  }

// Popup delete warning
  void _showModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorConstant.white,
          elevation: 0,
          contentPadding: const EdgeInsets.all(16),
          content: IntrinsicHeight(
            child: SizedBox(
              child: Column(children: [
                SizedBox(
                  width: 125,
                  height: 125,
                  child: IconConstant.myBudget(
                    color: ColorConstant.expense,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'Are you sure you want to delete this SMART gaol?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    height: 1.5,
                    letterSpacing: 1,
                    color: ColorConstant.black,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'You will delete every transaction added to this goal.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    height: 1.5,
                    letterSpacing: 0.5,
                    color: ColorConstant.mainText,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 24,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xFFE9EAF1),
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 1,
                              color: ColorConstant.thin,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          bool success = await context
                              .read<BudgetPlanStore>()
                              .delete(args);

                          if (success) {
                            Navigator.of(context).pop();
                            Navigator.pop(context);
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 24,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: ColorConstant.expense,
                          ),
                          child: const Text(
                            'Delete',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 1,
                              color: ColorConstant.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ]),
            ),
          ),
        );
      },
    );
  }
}
