import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/enums/loading_status_enum.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/helpers/text_style_helper.dart';
import 'package:finwise/core/helpers/ui_helper.dart';
import 'package:finwise/core/widgets/circular_progress/circular_progress_two_arches.dart';
import 'package:finwise/core/widgets/general_date_picker.dart';
import 'package:finwise/core/layouts/general_sticky_header_layout.dart';
import 'package:finwise/modules/budget_plan/widgets/budget_plan/budget_grid_tile.dart';
import 'package:finwise/modules/categories/screens/category_screen.dart';
import 'package:finwise/modules/categories/stores/category_store.dart';
import 'package:finwise/modules/upcoming_bill/models/upcoming_bill_model.dart';
import 'package:finwise/modules/upcoming_bill/stores/upcoming_bill_store.dart';
import 'package:finwise/modules/upcoming_bill/widgets/upcoming_bill_screen/main_content_list_view.dart';
import 'package:finwise/route.dart';
import 'package:flutter/foundation.dart';
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
        await context.read<UpcomingBillStore>().read(refreshed: true);
        await context.read<CategoryStore>().read();
      }
    });
  }

  late UpcomingBillStore store = context.read<UpcomingBillStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
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
      centerContent: _buildCenterContent(),
      mainContent: _buildContent(),
      centerContentPadding: const EdgeInsets.all(16),
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          if (notification.metrics.pixels ==
              notification.metrics.maxScrollExtent) {
            context.read<UpcomingBillStore>().read();
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
        : GeneralDatePicker(
            prefix: IconHelper.getSVG(SVGName.contentManagerDashboard),
            suffix: IconHelper.getSVG(SVGName.addSquare,
                color: ColorConstant.secondary),
            onSuffix: () =>
                Navigator.pushNamed(context, RouteName.addUpcomingBill),
            onPreffix: () async {
              setState(() => _isGrid = !_isGrid);
              await store.readYearly();
            },
            date: store.startDate,
            onDateChanged: (DateTime date) async {
              context.read<UpcomingBillStore>().setStartDate(date);
              context.read<UpcomingBillStore>().read(refreshed: true);
            },
          );
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
                '${UIHelper.getDateFormat(store.startDate.toString(), 'yyyy')}',
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
        await context.read<UpcomingBillStore>().read(refreshed: true);
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
        totalUpcomingBill: upcomingBill.data.length,
        upcomingBillList: upcomingBill.data,
      );
    });
  }

  late List<String> months = [];

  Widget _mainContentGridView() {
    store.upcomingBillYearly.forEach((key, value) {
      months.add(key);
    });

    return Observer(builder: (context) {
      return store.status == LoadingStatusEnum.loading
          ? const Center(child: CircularProgressIndicatorTwoArcs())
          : Container(
              color: const Color(0xFFF5F7F8),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: store.upcomingBillYearly.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) => BudgetGridTile(
                  month: months[index],
                  budget:
                      store.upcomingBillYearly[months[index]]!.numberOfGoals,
                ),
              ),
            );
    });
  }
}
