import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/text_style_constants/general_text_style_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:finwise/core/constants/text_style_constants/smart_goal_text_style_constant.dart';
import 'package:finwise/core/helpers/ui_helper.dart';
import 'package:finwise/core/widgets/charts/general_six_month_bar_chart.dart';
import 'package:finwise/core/widgets/general_detail_layout.dart';
import 'package:finwise/core/widgets/general_filter_bar/general_filter_bar.dart';
import 'package:finwise/core/widgets/general_progress_widget.dart';
import 'package:finwise/core/widgets/rounded_container.dart';
import 'package:finwise/core/widgets/transaction_item.dart';
import 'package:finwise/core/widgets/view_more_text_button.dart';
import 'package:finwise/modules/smart_goal/models/smart_goal_model.dart';
import 'package:finwise/route.dart';
import 'package:flutter/material.dart';

class SmartGoalDetailScreen extends StatefulWidget {
  const SmartGoalDetailScreen({super.key});

  @override
  State<SmartGoalDetailScreen> createState() => _SmartGoalDetailScreenState();
}

class _SmartGoalDetailScreenState extends State<SmartGoalDetailScreen> {
  late final SmartGoalData args =
      ModalRoute.of(context)!.settings.arguments as SmartGoalData;

  @override
  Widget build(BuildContext context) {
    print(args);
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return GeneralDetailLayout(
      title: args.name,
      subTitle: 'Created on: ${UIHelper.getFormattedDate(args.startDate)}',
      gradient: const LinearGradient(
        colors: [
          ColorConstant.smartGoalLight,
          ColorConstant.smartGoalThick,
        ],
        stops: [0.0, 1.0],
      ),
      mainContent: _buildContent(),
    );
  }

  Widget _buildContent() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        shrinkWrap: true,
        children: [
          _buildOverview(),
        ],
      ),
    );
  }

  Widget _buildOverview() {
    return Column(
      children: [
        Text('Overview', style: GeneralTextStyle.getHeader()),
        const SizedBox(height: 12),
        _buildProgress(),
        const SizedBox(height: 12),
        RoundedContainer(),
        _buildContribution(),
        _buildTransactions(),
        const SizedBox(height: 48),
      ],
    );
  }

  Widget _buildProgress() {
    return RoundedContainer(
      child: GeneralProgressWidget(
        current: args.currentSave,
        gradient: const LinearGradient(
          colors: [
            ColorConstant.smartGoalLight,
            ColorConstant.smartGoalThick,
          ],
          stops: [0, 1],
        ),
        total: args.amount,
        topLeft: Row(
          children: [
            Text('7',
                style: SmartGoalTextStyle.getCardTitle(
                    color: ColorConstant.black)),
            const SizedBox(width: 2),
            Text('transactions', style: SmartGoalTextStyle.cardSubTitle),
          ],
        ),
        bottomLeft:
            Text('${args.currentSave}', style: SmartGoalTextStyle.cardSubTitle),
        bottomRight: Row(
          children: [
            Text('out of ', style: SmartGoalTextStyle.cardSubTitle),
            const SizedBox(width: 6),
            Text('${args.amount}',
                style: SmartGoalTextStyle.getCardTitle(
                    color: ColorConstant.black)),
          ],
        ),
      ),
    );
  }

  final Map<String, dynamic> data = {
    "06": 10,
    "07": 20,
    "08": 50,
    "09": 30,
    "10": 20,
    "11": 40,
  };

  Widget _buildContribution() {
    return Column(
      children: [
        Text('Last 6 month contribution', style: GeneralTextStyle.getHeader()),
        GeneralSixMonthBarChart(
          sixMonthBudget: data,
          average: 10,
          thisMonth: 50,
        )
      ],
    );
  }

  Widget _buildTransactions({bool isIncome = true}) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Transactions', style: GeneralTextStyle.getHeader()),
          ],
        ),
        const SizedBox(height: 16),
        GeneralFilterBar(
          topSpace: 0,
          filterTitles: [
            'All',
            'Recently',
            'Earliest',
            'Lowest',
            'Highest',
          ],
          // children: [],
        ),
        const SizedBox(height: 16),
        _buildTransactionItemsDays(isIncome: isIncome),
        const SizedBox(height: 16),
        _buildTransactionItemsDays(day: 'Yesterday', isIncome: isIncome),
      ],
    );
  }

  Widget _buildTransactionItemsDays({
    String? day,
    bool isIncome = true,
  }) {
    return Column(
      children: [
        Row(children: [
          Text(day ?? 'Today', style: GeneralTextStyle.getSize(14)),
          const SizedBox(width: 12),
          const Expanded(child: Divider(color: ColorConstant.divider))
        ]),
        const SizedBox(height: 12),
        RoundedContainer(
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 2,
            itemBuilder: ((context, index) {
              return TransactionItem(
                icon: isIncome
                    ? IconConstant.getEarn()
                    : IconConstant.getExpense(),
                color: isIncome ? ColorConstant.income : ColorConstant.expense,
              );
            }),
            separatorBuilder: (context, index) {
              return const Divider(color: ColorConstant.divider);
            },
          ),
        ),
      ],
    );
  }
}
