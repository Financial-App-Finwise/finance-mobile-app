import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/enums/budget_plan_enum.dart';
import 'package:finwise/core/enums/loading_status_enum.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/widgets/custom_progess_bar.dart';
import 'package:finwise/core/widgets/filter_bars/headers/models/filter_bar_header_item_model.dart';
import 'package:finwise/core/widgets/filter_bars/headers/widgets/general_filter_bar_header/general_filter_bar_header.dart';
import 'package:finwise/core/widgets/general_date_picker.dart';
import 'package:finwise/core/layouts/general_sticky_header_layout.dart';
import 'package:finwise/modules/budget_plan/models/budget_plan_model.dart';
import 'package:finwise/modules/budget_plan/store/budget_plan_store.dart';
import 'package:finwise/modules/budget_plan/widgets/budget_plan/budget_grid_tile.dart';
import 'package:finwise/modules/budget_plan/widgets/budget_plan/budget_overview.dart';
import 'package:finwise/modules/budget_plan/widgets/budget_plan/filtered_budget.dart';
import 'package:finwise/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class SelectBudgetPlanWidget extends StatefulWidget {
  late void Function(BudgetPlanData) onPressed;

  SelectBudgetPlanWidget({
    super.key,
    required this.onPressed,
  });

  @override
  State<SelectBudgetPlanWidget> createState() => _SelectBudgetPlanWidgetState();
}

class _SelectBudgetPlanWidgetState extends State<SelectBudgetPlanWidget> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 0), () async {
      if (mounted) {
        await context.read<BudgetPlanStore>().read();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  bool _isGrid = false;

  Widget _buildBody() {
    return GeneralStickyHeaderLayout(
      title: 'Select a Budget Plan',
      description:
          'Effortlessly manage your finance with a powerful simple tool in FinWise',
      gradient: const LinearGradient(colors: [
        Color(0xFF0ABDE3),
        Color(0xFF0B8AAF),
      ]),
      centerContent: GeneralDatePicker(
        suffix: IconHelper.getSVG(SVGName.addSquare,
            color: ColorConstant.secondary),
        onSuffix: () => Navigator.pushNamed(context, RouteName.addBudget),
        onPreffix: () => setState(() => _isGrid = !_isGrid),
        onDateChanged: (DateTime date) async {
          context.read<BudgetPlanStore>().setSelectedDate(date);
          await context.read<BudgetPlanStore>().read();
        },
      ),
      mainContent: _buildContent(),
      centerContentPadding: const EdgeInsets.all(16),
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          if (notification.metrics.pixels ==
              notification.metrics.maxScrollExtent) {
            context.read<BudgetPlanStore>().read();
            return true;
          }
        }
        return true;
      },
    );
  }

  Widget _buildContent() {
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<BudgetPlanStore>().read();
      },
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.only(
            top: 20,
            bottom: 16,
          ),
          child: _mainContentListView(),
        ),
      ),
    );
  }

  late BudgetPlanStore store = context.read<BudgetPlanStore>();

// Main content list view
  Widget _mainContentListView() {
    return Observer(builder: (context) {
      

      return Container(
        color: const Color(0xFFF5F7F8),
        child: _buildBudgetPlans(),
      );
    });
  }

  Widget _buildBudgetPlans() {
    return Column(
      children: [
        GeneralFilterBarHeader(
          physics: const BouncingScrollPhysics(),
          items: [
            FilterBarHeaderItem(
              title: 'All',
              value: BudgetPlanFilterEnum.all,
            ),
            FilterBarHeaderItem(
              title: 'One-time budget',
              value: BudgetPlanFilterEnum.oneTimeBudget,
            ),
            FilterBarHeaderItem(
              title: 'Monthly budget',
              value: BudgetPlanFilterEnum.monthlyBudget,
            ),
          ],
          onTap: (value) async {
            context.read<BudgetPlanStore>().setFilter(value);
            await context.read<BudgetPlanStore>().read();
          },
          currentValue: context.read<BudgetPlanStore>().filter,
        ),
        const SizedBox(
          height: 16,
        ),
        Observer(builder: (context) {
          LoadingStatusEnum loadingStatus =
              context.watch<BudgetPlanStore>().status;
          List<BudgetPlanData> budgetPlans = store.budgetPlan.data.budgetPlans;
            
          return loadingStatus == LoadingStatusEnum.loading
              ? Text('Loading...')
              : Column(
                  children: [
                    for (int index = 0;
                        index < store.budgetPlan.data.budgetPlans.length;
                        index++)
                      Column(
                        children: [
                          _titleProgressCard(budgetPlans[index]),
                          if (index <budgetPlans.length - 1)
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

  Widget _titleProgressCard(BudgetPlanData item) {
    return GestureDetector(
      onTap: () {
        widget.onPressed(item);
        Navigator.pop(context);
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
                    '${item.transactionCount.toInt()}',
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
              value: item.totalTransactionAmount / item.amount,
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
                    '\$${item.totalTransactionAmount.toInt()}',
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
