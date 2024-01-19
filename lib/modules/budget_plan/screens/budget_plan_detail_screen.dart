import 'package:finwise/modules/budget_plan/screens/budget_plan_screen.dart';
import 'package:finwise/modules/budget_plan/widgets/budget_plan_detail/this_month_content.dart';
import 'package:finwise/modules/budget_plan/widgets/budget_plan_detail/transaction_content.dart';
import 'package:flutter/material.dart';

class BudgetPlanDetailScreen extends StatefulWidget {
  const BudgetPlanDetailScreen({super.key});

  @override
  State<BudgetPlanDetailScreen> createState() => _BudgetPlanDetailScreenState();
}

class _BudgetPlanDetailScreenState extends State<BudgetPlanDetailScreen> {
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
          SizedBox(
            width: 24,
            height: 24,
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BudgetPlanScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 24,
              ),
              style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                iconColor: MaterialStateProperty.all(
                  const Color(0xFFFFFFFF),
                ),
              ),
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
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Transportation',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            color: Color(0xFFFFFFFF)),
                      ),
                      Text(
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
                      onPressed: () {},
                      icon: const Icon(
                        Icons.edit_outlined,
                        size: 24,
                      ),
                      style: ButtonStyle(
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(0)),
                        iconColor: MaterialStateProperty.all(
                          const Color(0xFFFFFFFF),
                        ),
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
                      onPressed: () {},
                      icon: const Icon(
                        Icons.delete_outline,
                        size: 24,
                      ),
                      style: ButtonStyle(
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(0)),
                        iconColor: MaterialStateProperty.all(
                          const Color(0xFFFFFFFF),
                        ),
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
      child: const Column(
        children: [
          ThisMonthContent(transaction: 7, total: 50, remain: 40, spent: 10),
          SizedBox(
            height: 16,
          ),
          TransactionContent(),
        ],
      ),
    );
  }
}
