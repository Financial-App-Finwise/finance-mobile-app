import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/widgets/calendar_header_layout.dart';
import 'package:finwise/core/widgets/general_date_picker.dart';
import 'package:finwise/core/widgets/general_sticky_header_layout.dart';
import 'package:finwise/modules/budget_plan/screens/add_budget_plan_screen.dart';
import 'package:finwise/modules/budget_plan/widgets/budget_plan/budget_grid_tile.dart';
import 'package:finwise/modules/upcoming_bill/models/upcoming_bill_model.dart';
import 'package:finwise/modules/upcoming_bill/stores/upcoming_bill_store.dart';
import 'package:finwise/modules/upcoming_bill/widgets/upcoming_bill_screen/main_content_list_view.dart';
import 'package:finwise/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class UpcomingBillScreen extends StatefulWidget {
  const UpcomingBillScreen({super.key});

  @override
  State<UpcomingBillScreen> createState() => _UpcomingBillScreenState();
}

class _UpcomingBillScreenState extends State<UpcomingBillScreen> {
  bool _gridView = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 0), () async {
      if (mounted) {
        await context.read<UpcomingBillStore>().read();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
    // return Scaffold(
    //   body: CalendarHeaderLayout(
    //     addScreen: const AddBudgetPlanScreen(),
    //     title: 'My upcoming bill',
    //     description:
    //         'Effortlessly manage your upcoming bill with a powerful simple tool in Finwise.',
    //     firstColor: const Color(0xFF0ABDE3),
    //     secondColor: const Color(0xFF0B8AAF),
    //     changeView: () => setState(() {
    //       _gridView = !_gridView;
    //     }),
    //     // child: _noContentView(),
    //     child: _gridView ? _mainContentGridView() : _mainContentListView(),
    //   ),
    // );
  }

  bool _isGrid = false;

  Widget _buildBody() {
    return GeneralStickyHeaderLayout(
      title: 'My upcoming bill',
      description:
          'Effortlessly manage your upcoming bill with a powerful simple tool in Finwise.',
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
      ),
      mainContent: _buildContent(),
      centerContentPadding: const EdgeInsets.all(16),
    );
  }

  Widget _buildContent() {
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<UpcomingBillStore>().read();
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

  Widget _mainContentListView() {
    return Observer(builder: (context) {
      late UpcomingBill upcomingBill =
          context.watch<UpcomingBillStore>().upcomingBill;

      return MainContentListView(
        totalUpcomingBill: 3,
        upcomingBillList: upcomingBill.data,
      );
    });
  }

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
            SizedBox(
              height: 100,
              width: 100,
              child:
                  IconConstant.getUpcomingBill(color: const Color(0xFFA4A7C6)),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'You have no upcoming bill for this month.',
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
              child: Text(
                'Add Upcoming Bill',
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
