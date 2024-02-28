import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/enums/budget_plan_enum.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/widgets/filter_bars/headers/models/filter_bar_header_item_model.dart';
import 'package:finwise/core/widgets/general_date_picker.dart';
import 'package:finwise/core/widgets/general_sticky_header_layout.dart';
import 'package:finwise/modules/budget_plan/models/budget_plan_model.dart';
import 'package:finwise/modules/budget_plan/store/budget_plan_store.dart';
import 'package:finwise/modules/budget_plan/widgets/budget_plan/budget_grid_tile.dart';
import 'package:finwise/modules/budget_plan/widgets/budget_plan/budget_overview.dart';
import 'package:finwise/modules/budget_plan/widgets/budget_plan/filtered_budget.dart';
import 'package:finwise/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class BudgetPlanScreen extends StatefulWidget {
  const BudgetPlanScreen({super.key});

  @override
  State<BudgetPlanScreen> createState() => _BudgetPlanScreenState();
}

class _BudgetPlanScreenState extends State<BudgetPlanScreen> {
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
      title: 'My budget plan',
      description:
          'Effortlessly manage your finance with a powerful simple tool in FinWise',
      gradient: const LinearGradient(colors: [
        Color(0xFF0ABDE3),
        Color(0xFF0B8AAF),
      ]),
      centerContent: GeneralDatePicker(
        prefix: IconHelper.getSVG(SVGName.contentManagerDashboard),
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
          child: _isGrid ? _mainContentGridView() : _mainContentListView(),
        ),
      ),
    );
  }

// Main content list view
  Widget _mainContentListView() {
    return Observer(builder: (context) {
      BudgetPlan budgetPlan = context.watch<BudgetPlanStore>().budgetPlan;

      return Container(
        color: const Color(0xFFF5F7F8),
        child: Column(
          children: [
            const BudgetOverview(
                totalBudget: 3,
                available: 130,
                spend: 30,
                overBudget: 0,
                plannedBudget: 150),
            const SizedBox(
              height: 16,
            ),
            FilteredBudget(filterTitles: [
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
            ], budgetCards: budgetPlan.data),
          ],
        ),
      );
    });
  }

// Main content grid view
  Widget _mainContentGridView() {
    return Container(
      color: const Color(0xFFF5F7F8),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 12,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          crossAxisCount: 3,
        ),
        itemBuilder: (context, index) =>
            const BudgetGridTile(month: 'January', budget: 3),
      ),
    );
  }

// No content
  Widget _noContentView() {
    return Container(
      alignment: Alignment.center,
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
          ],
        ),
      ),
    );
  }
}
