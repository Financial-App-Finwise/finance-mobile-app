import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/smart_goal_text_style_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/widgets/general_date_picker.dart';
import 'package:finwise/core/widgets/general_filter_bar.dart';
import 'package:finwise/core/widgets/general_progress_widget.dart';
import 'package:finwise/core/widgets/general_sticky_header_layout.dart';
import 'package:finwise/core/widgets/small_rounded_square.dart';
import 'package:finwise/modules/smart_goal/models/smart_goal_model.dart';
import 'package:finwise/modules/smart_goal/stores/smart_goal_store.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  bool _isGrid = false;

  Widget _buildBody() {
    return GeneralStickyHeaderLayout(
      title: 'My Smart Goal',
      description:
          'Effortlessly manage your finance with a powerful simple tool in FinWise.',
      gradient: LinearGradient(colors: [
        ColorConstant.smartGoalLight,
        ColorConstant.smartGoalThick,
      ]),
      centerContent: GeneralDatePicker(
        prefix: IconHelper.getSVG(SVGName.contentManagerDashboard),
        suffix: IconHelper.getSVG(SVGName.addSquare,
            color: ColorConstant.secondary),
        onSuffix: () => Navigator.pushNamed(context, RouteName.addSmartGoal),
        onPreffix: () => setState(() => _isGrid = !_isGrid),
      ),
      mainContent: _buildContent(),
      centerContentPadding: EdgeInsets.all(16),
    );
  }

  Widget _buildContent() {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: _isGrid ? SmartGoalGridView() : _buildColumnContent(),
    );
  }

  Widget _buildColumnContent() {
    return Container(
      // padding: const EdgeInsets.only(left: 16, right: 16),
      child: RefreshIndicator(
        onRefresh: () async {},
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildSummary(),
              SizedBox(height: 16),
              _buildSmartGoals(),
              SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummary() {
    return Column(
      children: [
        _buildTotalSummary(),
        SizedBox(height: 12),
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
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: Row(
        children: [
          SizedBox(
            width: 36,
            height: 36,
            child: IconHelper.getSVG(SVGName.smartGoal,
                color: ColorConstant.income),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Total SMART Goal', style: SmartGoalTextStyle.totalTitle),
              Text('3', style: SmartGoalTextStyle.totalNumber),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusSummary() {
    return Container(
      child: SmartGoalOverview(
        achieved: '0',
        saved: '0',
        leftToSave: '0',
        targetAmount: '0',
      ),
    );
  }

  Widget _buildSmartGoals() {
    return Observer(builder: (context) {
      SmartGoal smartGoal = context.watch<SmartGoalStore>().smartGoal;
      return Column(
        children: [
          GeneralFilterBar(
            filterTitles: ['All', 'In Progress', 'Achieved'],
            children: [
              _buildFilteredSmartGoals(smartGoal.data),
              _buildFilteredSmartGoals(
                  context.watch<SmartGoalStore>().inProgress),
              _buildFilteredSmartGoals(
                  context.watch<SmartGoalStore>().achieved),
            ],
          ),
          SizedBox(height: 16),
        ],
      );
    });
  }

  Widget _buildFilteredSmartGoals(List<SmartGoalData> data) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.pushNamed(context, RouteName.smartGoalDetail);
          },
          child: _buildSmartGoalItem(data[index]),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 8);
      },
    );
  }

  Widget _buildSmartGoalItem(SmartGoalData item) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xffE9EAF1)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            children: [
              SmallRoundedSquare(
                color: ColorConstant.incomeIcon,
                icon: SizedBox(
                  child:
                      IconHelper.getSVG(SVGName.smartGoal, color: Colors.white),
                ),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${item.name}',
                      style: SmartGoalTextStyle.getCardTitle()),
                  Text('Due Date: ${item.endDate}',
                      style: SmartGoalTextStyle.cardSubTitle),
                ],
              ),
            ],
          ),
          Divider(color: ColorConstant.divider),
          GeneralProgressWidget(
            current: item.currentSave,
            gradient: LinearGradient(
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
                SizedBox(width: 2),
                Text('transactions', style: SmartGoalTextStyle.cardSubTitle),
              ],
            ),
            bottomLeft: Text('${item.currentSave}',
                style: SmartGoalTextStyle.cardSubTitle),
            bottomRight: Row(
              children: [
                Text('out of ', style: SmartGoalTextStyle.cardSubTitle),
                SizedBox(width: 6),
                Text('${item.amount}',
                    style: SmartGoalTextStyle.getCardTitle(
                        color: ColorConstant.black)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
