import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/constants/text_style_constants/smart_goal_text_style_constant.dart';
import 'package:finwise/core/enums/smart_goal_status_enum.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/helpers/ui_helper.dart';
import 'package:finwise/core/widgets/circular_progress/circular_progress_two_arches.dart';
import 'package:finwise/core/widgets/empty_data_widget.dart';
import 'package:finwise/core/widgets/filter_bars/headers/models/filter_bar_header_item_model.dart';
import 'package:finwise/core/widgets/filter_bars/headers/widgets/general_filter_bar_header/general_filter_bar_header.dart';
import 'package:finwise/core/widgets/general_progress_widget.dart';
import 'package:finwise/core/widgets/small_rounded_square.dart';
import 'package:finwise/modules/smart_goal/models/smart_goal_model.dart';
import 'package:finwise/modules/smart_goal/stores/smart_goal_store.dart';
import 'package:finwise/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class SmartGoalList extends StatefulWidget {
  const SmartGoalList({super.key});

  @override
  State<SmartGoalList> createState() => _SmartGoalListState();
}

class _SmartGoalListState extends State<SmartGoalList> {
  late final _store = context.read<SmartGoalStore>();
  
  @override
  Widget build(BuildContext context) {
    return _buildSmartGoals();
  }

  Widget _buildSmartGoals() {
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
              if (_store.filteredSmartGoal.items.isEmpty) {
                _store.readByPage(refreshed: true);
              }
            },
          ),
          _store.filteredSmartGoal.items.isEmpty
              ? EmptyDataWidget(
                  description: 'You have no smart goal yet for this month',
                  buttonLabel: 'Add Smart Goal',
                  icon: IconHelper.getSVG(
                    SVGName.smartGoal,
                    color: ColorConstant.colorA4A7C6,
                  ),
                  onButtonTap: () =>
                      Navigator.pushNamed(context, RouteName.smartGoalAdd),
                )
              : _buildFilteredSmartGoals(),
          const SizedBox(height: 16),
        ],
      );
    });
  }

  Widget _buildFilteredSmartGoals() {
    List<SmartGoalData> items = _store.filteredSmartGoal.items;

    return SingleChildScrollView(
      child: _store.isLoading
          ? const CircularProgressIndicatorTwoArcs()
          : Column(
              children: [
                Text('${items.length}'),
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
