import 'package:flutter/material.dart';
import '../widgets/contentManager.dart';

class BudgetPlanScreen extends StatelessWidget {
  const BudgetPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7F8),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xFF0ABDE3), Color(0xFF0B8AAF)],
              stops: [0.2, 0.8]),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _topBarContent(),
              const ContentManager(),
              Expanded(
                child: Container(
                  color: const Color(0xFFF5F7F8),
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: _mainContentListView(),
                      ),
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

// Top bar content
  Widget _topBarContent() {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xFF0ABDE3), Color(0xFF0B8AAF)], stops: [0.2, 0.8]),
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
              onPressed: () {},
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

          // Title and Description text
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My budget plan',
                style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 32,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                'Effortlessly manage your finance with a powerful simple tool in FinWise',
                style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 14,
                    height: 1.7,
                    fontWeight: FontWeight.w500),
              ),
            ],
          )
        ],
      ),
    );
  }

// Main content liste view
  Widget _mainContentListView() {
    return Container(
      color: const Color(0xFFF5F7F8),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 16,
      ),
      child: Column(
        children: [
          _budgetOverview(3, 130, 30, 0, 150),
          const SizedBox(
            height: 16,
          ),
          _budgetCard('Transportation', 7, 40, 10, 50),
          const SizedBox(
            height: 16,
          ),
          _budgetCard('Transportation', 7, 40, 10, 50),
          const SizedBox(
            height: 16,
          ),
          _budgetCard('Transportation', 7, 40, 10, 50),
        ],
      ),
    );
  }

  // Budget overview
  Widget _budgetOverview(
      int amount, int available, int spend, int overBudget, int plannedBudget) {
    return Column(
      children: [
        // Total budgets
        _totalBudget(amount),

        // Gap
        const SizedBox(
          height: 16,
        ),

        // Budget Overview Card
        _budgetOverviewCard(available, spend, overBudget, plannedBudget),
      ],
    );
  }

  // Total budget
  Widget _totalBudget(int amount) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Row(
          children: [
            // Icon
            const Icon(
              Icons.circle,
              size: 36,
              color: Color(0xFF0ABDE3),
            ),

            const SizedBox(
              width: 12,
            ),
            // Text
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Total budgets',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF333652),
                  ),
                ),
                const SizedBox(
                  height: 1,
                ),
                Text(
                  '$amount',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF0B8AAF),
                  ),
                ),
              ],
            ),
          ],
        ),
      ]),
    );
  }

  // Budget overview card
  Widget _budgetOverviewCard(
      int available, int spend, int overBudget, int plannedBudget) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: _budgetOverviewCardSection('Available', available,
                      const Color(0xFF10AC84), const Color(0xFF35D2A5)),
                ),
                const SizedBox(
                  width: 4,
                ),
                const VerticalDivider(
                  color: Color(0xFFF2F2F2),
                ),
                const SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: _budgetOverviewCardSection('Spend', spend,
                      const Color(0xFFEE5353), const Color(0xFFEE5353)),
                ),
              ],
            ),
          ),
          const Divider(
            color: Color(0xFFF2F2F2),
          ),
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: _budgetOverviewCardSection('Over Budget', overBudget,
                      const Color(0xFFFE7B11), const Color(0xFFEF6007)),
                ),
                const SizedBox(
                  width: 4,
                ),
                const VerticalDivider(
                  color: Color(0xFFF2F2F2),
                ),
                const SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: _budgetOverviewCardSection(
                      'Planned Budget',
                      plannedBudget,
                      const Color(0xFF0ABDE3),
                      const Color(0xFF0B8AAF)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Budget overview section
  Widget _budgetOverviewCardSection(
      String category, int amount, Color iconColor, Color textColor) {
    return Row(
      children: [
        Icon(
          Icons.circle,
          color: iconColor,
          size: 20,
        ),
        const SizedBox(
          width: 4,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF333652),
              ),
            ),
            Text(
              '\$$amount',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _budgetCard(
      String title, int transaction, int remain, int spent, int total) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: const Color(0xFFEE5353),
                    borderRadius: BorderRadius.circular(4)),
                child: const Icon(
                  Icons.car_rental_outlined,
                  color: Color(0xFFFFFFFF),
                ),
              ),
              const SizedBox(
                width: 11,
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF000000),
                ),
              ),
            ],
          ),
          const Divider(
            color: Color(0xFFF2F2F2),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    '$transaction',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF191B29),
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  const Text(
                    'transactions',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF333652),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    '\$$remain',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF191B29),
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  const Text(
                    'left',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF333652),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          ClipRRect(
            child: LinearProgressIndicator(
              minHeight: 10,
              borderRadius: BorderRadius.circular(5),
              value: ((spent * 10) / total) / 10,
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFFEE5353),
              ),
              backgroundColor: const Color(0xFFEDF2F7),
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    '\$$spent',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF191B29),
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  const Text(
                    'spent',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF333652),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    'out of',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF333652),
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(
                    '\$$total',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF191B29),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
