import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/text_style_constants/general_text_style_constant.dart';
import 'package:finwise/core/constants/text_style_constants/smart_goal_text_style_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/enums/loading_status_enum.dart';
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
import 'package:finwise/core/widgets/date_text_field_widget.dart';
import 'package:finwise/modules/smart_goal/widgets/smart_goal_overview.dart';
import 'package:finwise/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

class SmartGoalScreen extends StatefulWidget {
  const SmartGoalScreen({super.key});

  @override
  State<SmartGoalScreen> createState() => _SmartGoalScreenState();
}

class _SmartGoalScreenState extends State<SmartGoalScreen> {
  late SmartGoalUIStore uiStore = SmartGoalUIStore();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
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
        centerContentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 14,
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
        centerContent: _buildCenterContent(),
        // mainContent: _buildContent(),
        mainContent: _buildLoadingData(),
        // mainContent: _buildNestedScrollView(),
      ),
    );
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
                    UIHelper.getDateFormat(selectedDay.toString(), 'MMM dd, yyyy');
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
                    UIHelper.getDateFormat(selectedDay.toString(), 'MMM dd, yyyy');
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

  // Widget _buildNestedScrollView() {
  //   return Column(
  //     children: [
  //       Expanded(
  //         child: NestedScrollView(
  //           physics: ScrollPhysics(parent: BouncingScrollPhysics()),
  //           headerSliverBuilder:
  //               (BuildContext context, bool innerBoxIsScrolled) {
  //             return <Widget>[
  //               SliverAppBar(
  //                 automaticallyImplyLeading: false,
  //                 backgroundColor: Colors.amber,
  //                 toolbarHeight: 150,
  //                 expandedHeight: 300,
  //                 pinned: true,
  //                 flexibleSpace: FlexibleSpaceBar(
  //                   expandedTitleScale: 1,
  //                   titlePadding: EdgeInsets.zero,
  //                   title: _buildSummary(),
  //                 ),
  //               ),
  //             ];
  //           },
  //           body: Column(
  //             children: [
  //               Text('hello'),
  //               Text('hello'),
  //               Text('hello'),
  //               Text('hello'),
  //               Text('hello'),
  //               Text('hello'),
  //               Text('hello'),
  //               Text('hello'),
  //               Text('hello'),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildCenterOfGrid() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Row(
  //         children: [
  //           SizedBox(
  //             width: 24,
  //             height: 24,
  //             child: TextButton(
  //               onPressed: () => uiStore.toggleShowGrid(),
  //               style: ButtonStyle(
  //                 padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
  //               ),
  //               child: IconHelper.getSVG(SVGName.burgerMenu),
  //             ),
  //           ),
  //           SizedBox(width: 24),
  //           Text(
  //             '2024',
  //             style: GeneralTextStyle.getSize(18).copyWith(
  //               fontWeight: FontWeight.w700,
  //             ),
  //           ),
  //           Icon(Icons.keyboard_arrow_down),
  //         ],
  //       ),
  //       Row(
  //         children: [
  //           Icon(Icons.keyboard_arrow_left),
  //           Icon(Icons.keyboard_arrow_right),
  //         ],
  //       )
  //     ],
  //   );
  // }

  Widget _buildLoadingData() {
    LoadingStatusEnum status = context.watch<SmartGoalStore>().loadingStatus;
    return Observer(builder: (_) {
      switch (status) {
        case LoadingStatusEnum.loading:
        case LoadingStatusEnum.none:
          return Center(child: CircularProgressIndicator());
        case LoadingStatusEnum.error:
          return Icon(Icons.error);
        case LoadingStatusEnum.done:
          return _buildContent();
      }
    });
  }

  Widget _buildContent() {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: _buildColumnContent(),
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
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
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
          _buildFilteredSmartGoals(
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
