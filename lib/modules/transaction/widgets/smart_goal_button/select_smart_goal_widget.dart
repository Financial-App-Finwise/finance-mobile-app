import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/text_style_constants/smart_goal_text_style_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/enums/loading_status_enum.dart';
import 'package:finwise/core/enums/smart_goal_status_enum.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/helpers/ui_helper.dart';
import 'package:finwise/core/widgets/circular_progress/circular_progress_two_arches.dart';
import 'package:finwise/core/widgets/empty_data_widget.dart';
import 'package:finwise/core/widgets/filter_bars/headers/models/filter_bar_header_item_model.dart';
import 'package:finwise/core/widgets/filter_bars/headers/widgets/general_filter_bar_header/general_filter_bar_header.dart';
import 'package:finwise/core/widgets/general_progress_widget.dart';
import 'package:finwise/core/layouts/general_sticky_header_layout.dart';
import 'package:finwise/core/widgets/small_rounded_square.dart';
import 'package:finwise/modules/smart_goal/models/smart_goal_model.dart';
import 'package:finwise/modules/smart_goal/stores/smart_goal_store.dart';
import 'package:finwise/modules/smart_goal/stores/ui_stores/smart_goal_ui_store.dart';
import 'package:finwise/core/widgets/date_text_field_widget.dart';
import 'package:finwise/modules/smart_goal/widgets/smart_goal_grid_content.dart';
import 'package:finwise/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class SelectSmartGoalWidget extends StatefulWidget {
  final void Function(SmartGoalData) onItemSelected;

  const SelectSmartGoalWidget({
    super.key,
    required this.onItemSelected,
  });

  @override
  State<SelectSmartGoalWidget> createState() => _SelectSmartGoalWidgetState();
}

class _SelectSmartGoalWidgetState extends State<SelectSmartGoalWidget> {
  late SmartGoalUIStore uiStore = SmartGoalUIStore();
  late SmartGoalStore store = context.read<SmartGoalStore>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      // await _readAll();
    });
    store.initialize();
  }

  Future _readAll() async {
    await context.read<SmartGoalStore>().readByPage();
    await context.read<SmartGoalStore>().readYearly();
  }

  @override
  void dispose() {
    print('disposed');
    // store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => GeneralStickyHeaderLayout(
        title: 'Select a Smart Goal',
        description:
            'Effortlessly manage your finance with a powerful simple tool in FinWise.',
        gradient: const LinearGradient(colors: [
          ColorConstant.smartGoalLight,
          ColorConstant.smartGoalThick,
        ]),
        onNotification: (notification) {
          if (notification is ScrollEndNotification) {
            if (notification.metrics.pixels ==
                notification.metrics.maxScrollExtent) {
              context.read<SmartGoalStore>().readByPage();
              return true;
            }
          }
          return true;
        },
        centerContentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        centerContent: _buildCenterContent(),
        mainContent: _buildLoadedData(),
        // mainContent: _buildNestedScrollView(),
      ),
    );
  }

  late final DateTime _currentDate = DateTime.now();
  late final DateTime _startDay = DateTime(
    _currentDate.year,
    _currentDate.month,
  );
  late final DateTime _endDay = DateTime(
    _currentDate.year,
    _currentDate.month + 1,
  );

  late final TextEditingController _startDayController = TextEditingController(
    text: UIHelper.getDateFormat(store.startDate.toString(), 'dd MMM, yyyy'),
  );
  late final TextEditingController _endDayController = TextEditingController(
    text: UIHelper.getDateFormat(store.endDate.toString(), 'dd MMM, yyyy'),
  );

  Widget _buildCenterContent() {
    return Row(
      children: [
        Expanded(
          child: DateTextFieldWidget(
            onDaySelected: ((selectedDay, focusedDay) {
              setState(() {
                _startDayController.text = UIHelper.getDateFormat(
                    selectedDay.toString(), 'MMM dd, yyyy');
                store.startDate = selectedDay;
              });
            }),
            hintText: 'Start Date',
            controller: _startDayController,
          ),
        ),
        Expanded(
          child: DateTextFieldWidget(
            onDaySelected: ((selectedDay, focusedDay) {
              setState(() {
                _endDayController.text = UIHelper.getDateFormat(
                    selectedDay.toString(), 'MMM dd, yyyy');
                store.endDate = selectedDay;
              });
            }),
            hintText: 'End Date',
            controller: _endDayController,
          ),
        ),
        IconButton(
          onPressed: () =>
              Navigator.pushNamed(context, RouteName.smartGoalCreate),
          icon: IconHelper.getSVG(SVGName.addSquare,
              color: ColorConstant.secondary),
        ),
      ],
    );
  }

  Widget _buildLoadedData() {
    LoadingStatusEnum status = context.watch<SmartGoalStore>().loadingStatus;
    switch (status) {
      case LoadingStatusEnum.loading:
        return Center(child: CircularProgressIndicatorTwoArcs());
      case LoadingStatusEnum.none:
        return SizedBox();
      case LoadingStatusEnum.error:
        return Icon(Icons.error);
      case LoadingStatusEnum.done:
        return _buildContent();
    }
  }

  Widget _buildContent() {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: uiStore.showGrid
          ? SmartGoalGridView(data: store.smartGoalYearly)
          : _buildColumnContent(),
    );
  }

  Widget _buildColumnContent() {
    return RefreshIndicator(
      color: ColorConstant.primary,
      onRefresh: () async {
        await context.read<SmartGoalStore>().read();
        await context.read<SmartGoalStore>().readByPage(refreshed: true);
      },
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // _buildSummary(),
            // const SizedBox(height: 16),
            _buildSmartGoals(),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildSmartGoals() {
    return Observer(builder: (context) {
      return Column(
        children: [
          GeneralFilterBarHeader(
            padding: const EdgeInsets.only(left: 0, bottom: 12),
            currentValue: store.filteredProgress,
            items: [
              FilterBarHeaderItem(
                title: 'In Progress',
                value: SmartGoalStatusEnum.inProgress,
              ),
            ],
            onTap: (value) {
              store.changeFilteredProgress(value);
              store.initialize();
              if (store
                  .filteredSmartGoal[store.queryParemeter]!.items.isEmpty) {
                store.readByPage(refreshed: true);
              }
            },
          ),
          store.filteredSmartGoal[store.queryParemeter]!.items.isEmpty
              ? EmptyDataWidget(
                  description: 'You have no smart goal yet for this month',
                  buttonLabel: 'Add Smart Goal',
                  icon: IconHelper.getSVG(
                    SVGName.smartGoal,
                    color: ColorConstant.colorA4A7C6,
                  ),
                  onButtonTap: () =>
                      Navigator.pushNamed(context, RouteName.smartGoalCreate),
                )
              : _buildFilteredSmartGoals(),
          const SizedBox(height: 16),
        ],
      );
    });
  }

  Widget _buildFilteredSmartGoals() {
    List<SmartGoalData> items =
        store.filteredSmartGoal[store.queryParemeter]!.items;

    return SingleChildScrollView(
      child: store.isLoading
          ? CircularProgressIndicatorTwoArcs()
          : Column(
              children: [
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return _buildSmartGoalItem(items[index]);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 8);
                  },
                ),
              ],
            ),
    );
  }

  Widget _buildSmartGoalItem(SmartGoalData item) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xffE9EAF1)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextButton(
        onPressed: () {
          widget.onItemSelected(item);
          Navigator.pop(context);
        },
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SmallRoundedSquare(
                        color: ColorConstant.incomeIcon,
                        icon: SizedBox(
                          child: IconHelper.getSVG(SVGName.smartGoal,
                              color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.name,
                              style: SmartGoalTextStyle.getCardTitle()),
                          Text(
                              'Due Date: ${UIHelper.getFormattedDate(item.endDate)}',
                              style: SmartGoalTextStyle.cardSubTitle),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(color: ColorConstant.divider),
              GeneralProgressWidget(
                current: item.currentSave,
                gradient: const LinearGradient(
                  colors: [
                    ColorConstant.smartGoalLight,
                    ColorConstant.smartGoalThick,
                  ],
                  stops: [0, 1],
                ),
                total: item.amount,
                topLeft: Row(
                  children: [
                    Text('7',
                        style: SmartGoalTextStyle.getCardTitle(
                            color: ColorConstant.black)),
                    const SizedBox(width: 2),
                    Text('transactions',
                        style: SmartGoalTextStyle.cardSubTitle),
                  ],
                ),
                bottomLeft: Text('${item.currentSave}',
                    style: SmartGoalTextStyle.cardSubTitle),
                bottomRight: Row(
                  children: [
                    Text('out of ', style: SmartGoalTextStyle.cardSubTitle),
                    const SizedBox(width: 6),
                    Text('${item.amount}',
                        style: SmartGoalTextStyle.getCardTitle(
                            color: ColorConstant.black)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
