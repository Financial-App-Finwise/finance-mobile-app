import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/enums/budget_plan_enum.dart';
import 'package:finwise/core/enums/loading_status_enum.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/helpers/text_style_helper.dart';
import 'package:finwise/core/helpers/ui_helper.dart';
import 'package:finwise/core/widgets/circular_progress/circular_progress_two_arches.dart';
import 'package:finwise/core/widgets/filter_bars/headers/models/filter_bar_header_item_model.dart';
import 'package:finwise/core/widgets/general_date_picker.dart';
import 'package:finwise/core/layouts/general_sticky_header_layout.dart';
import 'package:finwise/modules/budget_plan/models/budget_plan_model.dart';
import 'package:finwise/modules/budget_plan/models/budget_plan_yearly_model.dart';
import 'package:finwise/modules/budget_plan/screens/add_budget_plan_screen.dart';
import 'package:finwise/modules/budget_plan/store/budget_plan_store.dart';
import 'package:finwise/modules/budget_plan/widgets/budget_plan/budget_grid_tile.dart';
import 'package:finwise/modules/budget_plan/widgets/budget_plan/budget_overview.dart';
import 'package:finwise/modules/budget_plan/widgets/budget_plan/filtered_budget.dart';
import 'package:finwise/modules/categories/screens/category_screen.dart';
import 'package:finwise/modules/categories/stores/category_store.dart';
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
    _performAsyncOperations();
  }

  void _performAsyncOperations() async {
    await Future.delayed(const Duration(seconds: 0));
    if (mounted) {
      await context.read<BudgetPlanStore>().read(refreshed: true);
      await context.read<CategoryStore>().read();
    }
  }

  late BudgetPlanStore store = context.read<BudgetPlanStore>();

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
      centerContent: _buildCenterContent(),
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

  Widget _buildCenterContent() {
    return _isGrid
        ? _buildCenterOfGrid()
        : Observer(builder: (context) {
            return GeneralDatePicker(
              prefix: IconHelper.getSVG(SVGName.contentManagerDashboard),
              suffix: IconHelper.getSVG(SVGName.addSquare,
                  color: ColorConstant.secondary),
              onSuffix: () => Navigator.pushNamed(context, RouteName.addBudget),
              onPreffix: () async {
                setState(() => _isGrid = !_isGrid);
                await store.readYearly();
              },
              date: store.selectedDate,
              onDateChanged: (DateTime date) async {
                context.read<BudgetPlanStore>().setSelectedDate(date);
                await context.read<BudgetPlanStore>().read(refreshed: true);
              },
              loadingStatus: store.status,
            );
          });
  }

  Widget _buildCenterOfGrid() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: TextButton(
                onPressed: () {
                  setState(() => _isGrid = !_isGrid);
                  store.read(refreshed: true);
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                ),
                child: IconHelper.getSVG(SVGName.burgerMenu),
              ),
            ),
            const SizedBox(width: 24),
            Observer(
              builder: (context) => Text(
                '${UIHelper.getDateFormat(store.selectedDate.toString(), 'yyyy')}',
                style: TextStyleHelper.getw500size(18).copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            // const Icon(Icons.keyboard_arrow_down),
          ],
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () async {
                store.addSelectedDateYear(addYear: false);
                await store.readYearly();
              },
              child: const Icon(Icons.keyboard_arrow_left),
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () async {
                store.addSelectedDateYear();
                await store.readYearly();
              },
              child: const Icon(Icons.keyboard_arrow_right),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildContent() {
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<BudgetPlanStore>().read(refreshed: true);
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
            BudgetOverview(
              totalBudget: budgetPlan.data.totalBudget,
              available: budgetPlan.data.available,
              spend: budgetPlan.data.spent,
              overBudget: budgetPlan.data.overBudget,
              plannedBudget: budgetPlan.data.plannedBudget,
            ),
            const SizedBox(
              height: 16,
            ),
            FilteredBudget(
              filterTitles: [
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
              budgetCards: budgetPlan.data.budgetPlans,
            ),
          ],
        ),
      );
    });
  }

// Main content grid view
  Widget _mainContentGridView() {
    return Observer(builder: (context) {
      BudgetPlanYearly budgetPlanYearly =
          context.watch<BudgetPlanStore>().budgetPlanYearly;

      late final List<List<dynamic>> gridData = [
        ['January', budgetPlanYearly.data.jan],
        ['February', budgetPlanYearly.data.feb],
        ['March', budgetPlanYearly.data.mar],
        ['April', budgetPlanYearly.data.apr],
        ['May', budgetPlanYearly.data.may],
        ['June', budgetPlanYearly.data.jun],
        ['July', budgetPlanYearly.data.jul],
        ['August', budgetPlanYearly.data.aug],
        ['September', budgetPlanYearly.data.sep],
        ['Octoboer', budgetPlanYearly.data.oct],
        ['November', budgetPlanYearly.data.nov],
        ['December', budgetPlanYearly.data.dec],
      ];

      return store.status == LoadingStatusEnum.loading
          ? const Center(
              child: CircularProgressIndicatorTwoArcs(),
            )
          : Container(
              color: const Color(0xFFF5F7F8),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: gridData.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) => BudgetGridTile(
                  month: gridData[index][0],
                  budget: gridData[index][1],
                  monthNumber: index + 1,
                  date: store.selectedDate,
                  addItem: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddBudgetPlanScreen(),
                    ),
                  ),
                  setList: (date) {
                    setState(() {
                      store.selectedDate = date;
                      _isGrid = false;
                      store.read(refreshed: true);
                    });
                  },
                ),
              ),
            );
    });
  }
}
