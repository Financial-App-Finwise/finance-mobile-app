import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:finwise/core/enums/budget_plan_enum.dart';
import 'package:finwise/core/enums/loading_status_enum.dart';
import 'package:finwise/core/widgets/circular_progress/circular_progress_two_arches.dart';
import 'package:finwise/core/widgets/custom_progess_bar.dart';
import 'package:finwise/core/widgets/filter_bars/headers/models/filter_bar_header_item_model.dart';
import 'package:finwise/core/widgets/filter_bars/headers/widgets/general_filter_bar_header/general_filter_bar_header.dart';
import 'package:finwise/modules/budget_plan/models/budget_plan_model.dart';
import 'package:finwise/modules/budget_plan/screens/add_budget_plan_screen.dart';
import 'package:finwise/modules/budget_plan/store/budget_plan_store.dart';
import 'package:finwise/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class FilteredBudget extends StatefulWidget {
  final List<FilterBarHeaderItem> filterTitles;
  final List<BudgetPlanData> budgetCards;

  const FilteredBudget({
    super.key,
    required this.filterTitles,
    required this.budgetCards,
  });

  @override
  State<FilteredBudget> createState() => _FilteredBudgetState();
}

class _FilteredBudgetState extends State<FilteredBudget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GeneralFilterBarHeader(
          physics: const BouncingScrollPhysics(),
          items: widget.filterTitles,
          onTap: (value) async {
            context.read<BudgetPlanStore>().setFilter(value);
            await context.read<BudgetPlanStore>().read(refreshed: true);
          },
          currentValue: context.read<BudgetPlanStore>().filter,
        ),
        const SizedBox(
          height: 16,
        ),
        Observer(builder: (context) {
          LoadingStatusEnum loadingStatus =
              context.watch<BudgetPlanStore>().status;
          return loadingStatus == LoadingStatusEnum.loading
              ? const CircularProgressIndicatorTwoArcs()
              : widget.budgetCards.isEmpty
                  ? _noContentView()
                  : Column(
                      children: [
                        for (int index = 0;
                            index < widget.budgetCards.length;
                            index++)
                          Column(
                            children: [
                              _titleProgressCard(widget.budgetCards[index]),
                              if (index < widget.budgetCards.length - 1)
                                const SizedBox(
                                  height: 16,
                                ),
                            ],
                          ),
                      ],
                    );
        })
      ],
    );
  }

  // No content
  Widget _noContentView() {
    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.only(top: 77, left: 16, right: 16, bottom: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        decoration: BoxDecoration(
          color: ColorConstant.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            // Icon(
            //   Icons.circle,
            //   color: ColorConstant.primary,
            //   size: 100,
            // ),
            SizedBox(
              height: 100,
              width: 100,
              child: IconConstant.myBudget(color: const Color(0xFFA4A7C6)),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'You have no budget plan for this month.',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: ColorConstant.mainText,
                height: 2,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 24,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: ColorConstant.secondary,
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddBudgetPlanScreen()));
                },
                child: const Text(
                  'Add Budget Plan',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: ColorConstant.white,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _titleProgressCard(BudgetPlanData item) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          RouteName.budgetPlanDetail,
          arguments: item,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ColorConstant.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: ColorConstant.expense,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(
                    Icons.car_rental_outlined,
                    color: ColorConstant.white,
                  ),
                ),
                const SizedBox(
                  width: 11,
                ),
                Text(
                  item.name,
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
            _card(item),
          ],
        ),
      ),
    );
  }

  Widget _card(BudgetPlanData item) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstant.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // Transactions
                  Text(
                    '${item.transactionCount}',
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
                      color: ColorConstant.mainText,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    '\$${item.remainingAmount.toInt()}',
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
                      color: ColorConstant.mainText,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          SizedBox(
            width: double.infinity,
            child: CustomProgressBar(
              value: item.spent / item.amount,
              gradient1: const Color(0xFFFBA6A6),
              gradient2: ColorConstant.expense,
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
                    '\$${item.spent}',
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
                      color: ColorConstant.mainText,
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
                    '\$${item.amount.toInt()}',
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
