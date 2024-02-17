import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/text_style_constants/general_text_style_constant.dart';
import 'package:finwise/core/constants/text_style_constants/smart_goal_text_style_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/enums/smart_goal_status_enum.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/helpers/ui_helper.dart';
import 'package:finwise/core/widgets/filter_bars/headers/models/filter_bar_header_item_model.dart';
import 'package:finwise/core/widgets/filter_bars/headers/widgets/general_filter_bar_header/general_filter_bar_header.dart';
import 'package:finwise/core/widgets/general_progress_widget.dart';
import 'package:finwise/core/widgets/general_sticky_header_layout.dart';
import 'package:finwise/core/widgets/small_rounded_square.dart';
import 'package:finwise/modules/smart_goal/models/smart_goal_model.dart';
import 'package:finwise/modules/smart_goal/stores/smart_goal_store.dart';
import 'package:finwise/modules/smart_goal/stores/ui_stores/smart_goal_ui_store.dart';
import 'package:finwise/modules/smart_goal/widgets/date_text_field_widget.dart';
import 'package:finwise/modules/smart_goal/widgets/smart_goal_grid_content.dart';
import 'package:finwise/modules/smart_goal/widgets/smart_goal_overview.dart';
import 'package:finwise/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class SmartGoalScreen extends StatefulWidget {
  const SmartGoalScreen({super.key});

  @override
  State<SmartGoalScreen> createState() => _SmartGoalScreenState();
}

class _SmartGoalScreenState extends State<SmartGoalScreen> {
  late SmartGoalUIStore uiStore = SmartGoalUIStore();
  final ScrollController _pageController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      _pageController.addListener(() async {
        if (_pageController.position.pixels ==
            _pageController.position.maxScrollExtent) {
          await context.read<SmartGoalStore>().readByPage();
        }
      });
      if (mounted) {
        await context.read<SmartGoalStore>().read();
        await context.read<SmartGoalStore>().readByPage();
      }
    });
  }

  @override
  void deactivate() {
    context.read<SmartGoalStore>().dispose();
    print('deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    print('disposed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Observer(
        builder: (context) => GeneralStickyHeaderLayout(
              title: 'My Smart Goal',
              description:
                  'Effortlessly manage your finance with a powerful simple tool in FinWise.',
              gradient: const LinearGradient(colors: [
                ColorConstant.smartGoalLight,
                ColorConstant.smartGoalThick,
              ]),
              centerContent: _buildCenterContent(),
              mainContent: _buildContent(),
              centerContentPadding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
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
            ));
  }

  DateTime _startDay = DateTime.now();
  DateTime _endDay = DateTime.now().add(Duration(days: 7));
  final TextEditingController _startDayController = TextEditingController();
  final TextEditingController _endDayController = TextEditingController();

  Widget _buildCenterContent() {
    return Row(
      children: [
        Expanded(
          child: DateTextFieldWidget(
            onDaySelected: ((selectedDay, focusedDay) {
              setState(() {
                _startDayController.text =
                    UIHelper.getInputDate(selectedDay.toString());
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
                _endDayController.text =
                    UIHelper.getInputDate(selectedDay.toString());
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
    // return uiStore.showGrid
    //     ? _buildCenterOfGrid()
    //     : GeneralDatePicker(
    //         prefix: IconHelper.getSVG(SVGName.contentManagerDashboard),
    //         suffix: IconHelper.getSVG(SVGName.addSquare,
    //             color: ColorConstant.secondary),
    //         onSuffix: () =>
    //             Navigator.pushNamed(context, RouteName.smartGoalCreate),
    //         onPreffix: () => uiStore.toggleShowGrid(),
    //       );
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
                onPressed: () => uiStore.toggleShowGrid(),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                ),
                child: IconHelper.getSVG(SVGName.burgerMenu),
              ),
            ),
            SizedBox(width: 24),
            Text(
              '2024',
              style: GeneralTextStyle.getSize(18).copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            Icon(Icons.keyboard_arrow_down),
          ],
        ),
        Row(
          children: [
            Icon(Icons.keyboard_arrow_left),
            Icon(Icons.keyboard_arrow_right),
          ],
        )
      ],
    );
  }

  Widget _buildContent() {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child:
          uiStore.showGrid ? const SmartGoalGridView() : _buildColumnContent(),
    );
  }

  Widget _buildColumnContent() {
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<SmartGoalStore>().read();
        await context.read<SmartGoalStore>().readByPage(refreshed: true);
      },
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildSummary(),
            const SizedBox(height: 16),
            _buildSmartGoals(),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildSummary() {
    return Column(
      children: [
        _buildTotalSummary(),
        const SizedBox(height: 12),
        _buildStatusSummary(),
      ],
    );
  }

  Widget _buildTotalSummary() {
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
              Text('${context.watch<SmartGoalStore>().smartGoal.meta.total}',
                  style: SmartGoalTextStyle.totalNumber),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusSummary() {
    return const SmartGoalOverview(
      achieved: '0',
      saved: '0',
      leftToSave: '0',
      targetAmount: '0',
    );
  }

  Widget _buildSmartGoals() {
    return Observer(builder: (context) {
      return Column(
        children: [
          GeneralFilterBarHeader(
            padding: const EdgeInsets.only(left: 0, bottom: 12),
            currentValue: context.watch<SmartGoalStore>().currentProgressStatus,
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
            onTap: (value) =>
                context.read<SmartGoalStore>().changeProgressStatus(value),
          ),
          context.watch<SmartGoalStore>().isLoading
              ? CircularProgressIndicator()
              : _buildFilteredSmartGoals(
                  context.watch<SmartGoalStore>().paginatedGoals,
                ),
          const SizedBox(height: 16),
        ],
      );
    });
  }

  // NotificationListener<ScrollNotification>(
  //           onNotification: (notification) {
  //            if (notification is ScrollEndNotification) {
  //              if (notification.metrics.pixels ==
  //                  notification.metrics.maxScrollExtent) {
  //                final tempList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  //                setState(() => _list.addAll(tempList));
  //                return true;
  //              }
  //            }
  //            return true;
  //          },

  Widget _buildFilteredSmartGoals(List<SmartGoalData> data) {
    return SingleChildScrollView(
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _buildSmartGoalItem(data[index]);
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 8);
        },
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
                          'Due Date: ${UIHelper.getFormattedDate(item.endDate)}',
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
