import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/text_style_constants/smart_goal_text_style_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/enums/loading_status_enum.dart';
import 'package:finwise/core/enums/smart_goal_status_enum.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/helpers/text_style_helper.dart';
import 'package:finwise/core/helpers/ui_helper.dart';
import 'package:finwise/core/layouts/general_sticky_header_layout.dart';
import 'package:finwise/core/widgets/circular_progress/circular_progress_two_arches.dart';
import 'package:finwise/core/widgets/circular_progress/linear_progress_dots.dart';
import 'package:finwise/core/widgets/custom_icon_button.dart';
import 'package:finwise/core/widgets/empty_data_widget.dart';
import 'package:finwise/core/widgets/filter_bars/headers/models/filter_bar_header_item_model.dart';
import 'package:finwise/core/widgets/filter_bars/headers/widgets/general_filter_bar_header/general_filter_bar_header.dart';
import 'package:finwise/core/widgets/general_progress_widget.dart';
import 'package:finwise/core/widgets/small_rounded_square.dart';
import 'package:finwise/modules/smart_goal/models/smart_goal_model.dart';
import 'package:finwise/modules/smart_goal/stores/smart_goal_store.dart';
import 'package:finwise/modules/smart_goal/stores/ui_stores/smart_goal_ui_store.dart';
import 'package:finwise/core/widgets/date_text_field_widget.dart';
import 'package:finwise/modules/smart_goal/widgets/smart_goal_grid_content.dart';
import 'package:finwise/modules/smart_goal/widgets/smart_goal_list.dart';
import 'package:finwise/modules/smart_goal/widgets/smart_goal_overview.dart';
import 'package:finwise/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class SmartGoalScreen extends StatefulWidget {
  const SmartGoalScreen({super.key});

  @override
  State<SmartGoalScreen> createState() => _SmartGoalScreenState();
}

class _SmartGoalScreenState extends State<SmartGoalScreen> {
  // -------------------- Initialization --------------------
  late final SmartGoalUIStore _uiStore = SmartGoalUIStore();
  late final SmartGoalStore _store = context.read<SmartGoalStore>();

  // -------------------- InitState --------------------
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) => _setContainerHeight());
    Future.delayed(Duration.zero, () async => await _readAll());
    // _store.setUpReaction();
    _store.initialize();
  }

  // -------------------- Read --------------------
  Future _readAll() async {
    await _store.readByPage(refreshed: true);
    await _store.readYearly();
  }

  // // -------------------- Container Height --------------------
  final _centerContainerKey = GlobalKey();
  double _centerContainerHeight = 0;

  double _getContainerHeight(GlobalKey containerKey) {
    if (containerKey.currentContext != null) {
      RenderBox renderBox =
          containerKey.currentContext!.findRenderObject() as RenderBox;
      return renderBox.size.height;
    }
    return 100;
  }

  void _setContainerHeight() => setState(
      () => _centerContainerHeight = _getContainerHeight(_centerContainerKey));

  // -------------------- Build --------------------
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => GeneralStickyHeaderLayout(
        title: 'My Smart Goal',
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
        centerContentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        centerContent: _buildCenterContent(),
        mainContent: _buildContent(),
      ),
    );
  }

  // -------------------- Center Content --------------------
  Widget _buildCenterContent() {
    return _uiStore.showGrid ? _buildCenterOfGrid() : _buildCenterOfList();
  }

  // -------------------- Grid View Center --------------------
  Widget _buildCenterOfGrid() {
    return SizedBox(
      height: _centerContainerHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: TextButton(
                  onPressed: () => _uiStore.toggleShowGrid(),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                  ),
                  child: IconHelper.getSVG(SVGName.burgerMenu),
                ),
              ),
              const SizedBox(width: 24),
              Text(
                '${_store.year}',
                style: TextStyleHelper.getw500size(18).copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              // const Icon(Icons.keyboard_arrow_down),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () async {
                  _store.year--;
                  await _store.readYearly();
                },
                child: const Icon(Icons.keyboard_arrow_left),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () async {
                  _store.year++;
                  await _store.readYearly();
                },
                child: const Icon(Icons.keyboard_arrow_right),
              ),
            ],
          )
        ],
      ),
    );
  }

  // -------------------- List View Center --------------------
  late final TextEditingController _startDayController = TextEditingController(
    text: UIHelper.getDateFormat(_store.endDateGTE.toString(), 'dd MMM, yyyy'),
  );
  late final TextEditingController _endDayController = TextEditingController(
    text: UIHelper.getDateFormat(_store.endDateLTE.toString(), 'dd MMM, yyyy'),
  );

  Widget _buildCenterOfList() {
    return Container(
      key: _centerContainerKey,
      child: Row(
        children: [
          CustomIconButton(
            onPressed: () => _uiStore.toggleShowGrid(),
            icon: IconHelper.getSVG(SVGName.contentManagerDashboard),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: DateTextFieldWidget(
              onDaySelected: ((selectedDay, focusedDay) async {
                setState(() => _startDayController.text =
                    UIHelper.getDateFormat(
                        selectedDay.toString(), 'MMM dd, yyyy'));
                _store.endDateGTE = selectedDay;
                await _store.readByPage(refreshed: true);
              }),
              hintText: 'End Date From',
              controller: _startDayController,
            ),
          ),
          Expanded(
            child: DateTextFieldWidget(
              onDaySelected: ((selectedDay, focusedDay) async {
                setState(() => _endDayController.text = UIHelper.getDateFormat(
                    selectedDay.toString(), 'MMM dd, yyyy'));
                _store.endDateLTE = selectedDay;
                await _store.readByPage(refreshed: true);
              }),
              hintText: 'End Date To',
              controller: _endDayController,
            ),
          ),
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, RouteName.smartGoalAdd),
            icon: IconHelper.getSVG(SVGName.addSquare,
                color: ColorConstant.secondary),
          ),
        ],
      ),
    );
  }

  // -------------------- Main Content --------------------
  Widget _buildContent() {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: _uiStore.showGrid ? _buildGridContent() : _buildListContent(),
    );
  }

  // -------------------- Grid View --------------------
  Widget _buildGridContent() {
    return _store.isLoadingYearly
        ? const Center(child: CircularProgressIndicatorTwoArcs())
        : SmartGoalGridView(
            data: _store.smartGoalYearly,
            onTap: (index) async {
              _uiStore.toggleShowGrid();
              setState(() {
                _startDayController.text = UIHelper.getDateFormat(
                    DateTime(_store.year, index + 1).toString(),
                    'MMM dd, yyyy');
                _endDayController.text = UIHelper.getDateFormat(
                  DateTime(_store.year, index + 2).toString(),
                  'MMM dd, yyyy',
                );
              });
              _store.endDateGTE = DateTime(_store.year, index + 1);
              _store.endDateLTE = DateTime(_store.year, index + 2);
              _store.initialize();
              await _store.readByPage(refreshed: true);
            },
          );
  }

  // -------------------- List View --------------------
  Widget _buildListContent() {
    return RefreshIndicator(
      color: ColorConstant.primary,
      onRefresh: () async {
        await _store.read();
        await _store.readByPage(refreshed: true);
      },
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildSummary(),
            const SizedBox(height: 16),
            _buildSmartLoading(),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildSummary() {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        _buildTotalSummary(),
        const SizedBox(height: 12),
        _buildStatusSummary(),
      ],
    );
  }

  Widget _buildTotalSummary() {
    return Observer(builder: (context) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        child: Row(
          children: [
            SizedBox(
              width: 36,
              height: 36,
              child: IconHelper.getSVG(SVGName.smartGoal,
                  color: ColorConstant.income),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total SMART Goal', style: SmartGoalTextStyle.totalTitle),
                Text('${_store.filteredMeta.total}',
                    style: SmartGoalTextStyle.totalNumber),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _buildStatusSummary() {
    return const SmartGoalOverview(
      achieved: '0',
      saved: '0',
      leftToSave: '0',
      targetAmount: '0',
    );
  }

  // -------------------- Smart Goal --------------------
  Widget _buildSmartLoading() {
    return Observer(builder: (context) {
      return Column(
        children: [
          GeneralFilterBarHeader(
            padding: const EdgeInsets.only(left: 0, bottom: 12),
            currentValue: _store.filteredProgress,
            items: [
              FilterBarHeaderItem(
                title: 'All',
                value: SmartGoalStatusEnum.all,
              ),
              FilterBarHeaderItem(
                title: 'In Progress',
                value: SmartGoalStatusEnum.inProgress,
              ),
              FilterBarHeaderItem(
                title: 'Achieved',
                value: SmartGoalStatusEnum.achieved,
              ),
            ],
            onTap: (value) {
              _store.changeFilteredProgress(value);
              _store.initialize();
              _store.readByPage(
                refreshed: _store.filteredSmartGoal.items.isEmpty,
                setLoading: () {
                  _store.loadingStatus = LoadingStatusEnum.loading;
                },
              );
            },
          ),
          Observer(builder: (_) {
            switch (_store.loadingStatus) {
              case LoadingStatusEnum.loading:
              case LoadingStatusEnum.none:
                return const CircularProgressIndicatorTwoArcs();
              case LoadingStatusEnum.done:
                return _store.filteredSmartGoal.items.isEmpty
                    ? EmptyDataWidget(
                        description:
                            'You have no smart goal yet for this month',
                        buttonLabel: 'Add Smart Goal',
                        icon: IconHelper.getSVG(
                          SVGName.smartGoal,
                          color: ColorConstant.colorA4A7C6,
                        ),
                        onButtonTap: () => Navigator.pushNamed(
                            context, RouteName.smartGoalAdd),
                      )
                    : _buildSmartGoals();
              default:
                return const Icon(Icons.error);
            }
          }),
          const SizedBox(height: 16),
        ],
      );
    });
  }

  Widget _buildSmartGoals() {
    List<SmartGoalData> items = _store.filteredSmartGoal.items;

    return SingleChildScrollView(
      child: _store.isLoading
          ? const CircularProgressIndicatorTwoArcs()
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
        onPressed: () => Navigator.pushNamed(
          context,
          RouteName.smartGoalDetail,
          arguments: item,
        ),
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
                      Text(item.name, style: SmartGoalTextStyle.getCardTitle()),
                      Text(
                          'Due Date: ${UIHelper.getDateFormat(item.endDate, 'dd MMM, yyyy')}',
                          style: SmartGoalTextStyle.cardSubTitle),
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
                    Text('${item.transactionCount}',
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

  // -------------------- Dispose --------------------
  @override
  void dispose() {
    debugPrint('<-- SMART GOAL, dispose');
    _store.dispose();
    super.dispose();
  }
}
