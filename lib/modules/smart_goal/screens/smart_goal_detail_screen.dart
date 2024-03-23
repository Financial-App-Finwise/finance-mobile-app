import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/constants/text_style_constants/general_text_style_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:finwise/core/constants/text_style_constants/smart_goal_text_style_constant.dart';
import 'package:finwise/core/enums/transaction_period_enum.dart';
import 'package:finwise/core/enums/transaction_type_enum.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/helpers/text_style_helper.dart';
import 'package:finwise/core/helpers/ui_helper.dart';
import 'package:finwise/core/utils/ui_util.dart';
import 'package:finwise/core/widgets/charts/general_six_month_bar_chart.dart';
import 'package:finwise/core/widgets/circular_progress/circular_progress_two_arches.dart';
import 'package:finwise/core/widgets/empty_data_widget.dart';
import 'package:finwise/core/widgets/filter_bars/headers/models/filter_bar_header_item_model.dart';
import 'package:finwise/core/widgets/filter_bars/headers/widgets/general_filter_bar_header/general_filter_bar_header.dart';
import 'package:finwise/core/layouts/general_detail_layout.dart';
import 'package:finwise/core/widgets/general_progress_widget.dart';
import 'package:finwise/core/widgets/rounded_container.dart';
import 'package:finwise/core/widgets/transaction_item.dart';
import 'package:finwise/core/widgets/view_more_text_button.dart';
import 'package:finwise/modules/finance/stores/finance_store.dart';
import 'package:finwise/modules/smart_goal/models/smart_goal_model.dart';
import 'package:finwise/modules/smart_goal/stores/smart_goal_store.dart';
import 'package:finwise/modules/transaction/models/transaction_model.dart';
import 'package:finwise/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class SmartGoalDetailScreen extends StatefulWidget {
  const SmartGoalDetailScreen({super.key});

  @override
  State<SmartGoalDetailScreen> createState() => _SmartGoalDetailScreenState();
}

class _SmartGoalDetailScreenState extends State<SmartGoalDetailScreen> {
  late final SmartGoalData args =
      ModalRoute.of(context)!.settings.arguments as SmartGoalData;

  late final store = context.read<SmartGoalStore>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await store.show(args.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return GeneralDetailLayout(
      title: args.name,
      subTitle: 'Created on: ${UIHelper.getFormattedDate(args.createdAt)}',
      iconTitle: IconHelper.getSVG(
        SVGName.smartGoal,
        color: ColorConstant.income,
      ),
      onEdit: () {
        Navigator.pushNamed(
          context,
          RouteName.smartGoalEdit,
          arguments: args,
        );
      },
      onDelete: () async {
        UIUtil.showModal(
          context,
          'Are you sure you want to delete this SMART gaol?',
          'You will delete every transaction added to this goal.',
          onTap: () async {
            bool success = await context.read<SmartGoalStore>().delete(args);
            if (success) {
              if (mounted) {
                context.read<SmartGoalStore>().readByPage(refreshed: true);
                Navigator.pop(context);
                Navigator.pop(context);
              }
            }
          },
        );
      },
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
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const SizedBox(height: 16),
                _buildOverview(),
                const SizedBox(height: 20),
                _buildContribution(),
                const SizedBox(height: 20),
                _buildTypeTransactions(),
                const SizedBox(height: 48),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverview() {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Text('Overview', style: TextStyleHelper.getw600size(20)),
        const SizedBox(height: 12),
        _buildProgress(),
        const SizedBox(height: 12),
        RoundedContainer(
          child: Column(
            children: [
              _buildOverviewItem(
                title: 'Target Goal',
                subTitle: '\$${args.amount}',
                subTitleColor: ColorConstant.primary,
                icon: IconHelper.getSVG(
                  SVGName.targetAmount,
                  color: ColorConstant.income,
                ),
              ),
              const SizedBox(height: 16),
              const Divider(color: ColorConstant.divider),
              const SizedBox(height: 16),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: _buildOverviewItem(
                        title: 'Saved so far',
                        subTitle: '\$${args.currentSave}',
                        subTitleColor: ColorConstant.income,
                        icon: IconHelper.getSVG(
                          SVGName.save,
                          color: ColorConstant.income,
                        ),
                      ),
                    ),
                    const VerticalDivider(color: ColorConstant.divider),
                    Expanded(
                      child: _buildOverviewItem(
                        title: 'Left to Save',
                        subTitle: '\$${args.remainingSave}',
                        subTitleColor: ColorConstant.expense,
                        icon: IconHelper.getSVG(
                          SVGName.hourGlass,
                          color: ColorConstant.income,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Divider(color: ColorConstant.divider),
              const SizedBox(height: 16),
              _buildOverviewItem(
                title: 'Monthly Contribution',
                subTitle: '+\$${args.monthlyContribution}',
                subTitleColor: ColorConstant.black,
                icon: IconHelper.getSVG(
                  SVGName.pie,
                  color: ColorConstant.income,
                ),
              ),
              const SizedBox(height: 16),
              const Divider(color: ColorConstant.divider),
              const SizedBox(height: 16),
              _buildOverviewItem(
                title: 'Start Date',
                subTitle:
                    UIHelper.getDateFormat(args.startDate, 'MMM dd, yyyy'),
                subTitleColor: ColorConstant.black,
                icon: IconHelper.getSVG(
                  SVGName.calendarTick,
                  color: ColorConstant.income,
                ),
              ),
              const SizedBox(height: 16),
              const Divider(color: ColorConstant.divider),
              const SizedBox(height: 16),
              _buildOverviewItem(
                title: 'Target Date',
                subTitle: UIHelper.getDateFormat(args.endDate, 'MMM dd, yyyy'),
                subTitleColor: ColorConstant.black,
                icon: IconHelper.getSVG(
                  SVGName.calendarTick,
                  color: ColorConstant.income,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOverviewItem({
    String title = '',
    String subTitle = '',
    Color subTitleColor = Colors.black,
    Widget? icon,
  }) {
    return Row(
      children: [
        SizedBox(width: 24, child: icon),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyleHelper.getw500size(14).copyWith(
                    letterSpacing: 0.75,
                    overflow: TextOverflow.ellipsis,
                  )),
              Text(
                subTitle,
                style: TextStyleHelper.getw600size(24, color: subTitleColor)
                    .copyWith(
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
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
            const SizedBox(width: 6),
            Text('transactions', style: SmartGoalTextStyle.cardSubTitle),
          ],
        ),
        topRight: Row(
          children: [
            Text('\$${args.remainingSave}',
                style: SmartGoalTextStyle.getCardTitle(
                    color: ColorConstant.black)),
            const SizedBox(width: 6),
            Text('left', style: SmartGoalTextStyle.cardSubTitle),
          ],
        ),
        bottomLeft: Row(
          children: [
            Text('\$${args.currentSave}',
                style: SmartGoalTextStyle.cardSubTitle),
            const SizedBox(width: 6),
            Text(
              'saved so far',
              style:
                  SmartGoalTextStyle.getCardTitle(color: ColorConstant.black),
            ),
          ],
        ),
        bottomRight: Row(
          children: [
            Text('out of', style: SmartGoalTextStyle.cardSubTitle),
            const SizedBox(width: 6),
            Text(
              '\$${args.amount}',
              style:
                  SmartGoalTextStyle.getCardTitle(color: ColorConstant.black),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContribution() {
    DateTime current = DateTime.now();

    final Map<String, dynamic> data = {
      "${(current.month - 5 + 12) % 12}": 10,
      "${(current.month - 4 + 12) % 12}": 20,
      "${(current.month - 3 + 12) % 12}": 50,
      "${(current.month - 2 + 12) % 12}": 30,
      "${(current.month - 1 + 12) % 12}": 20,
      "${current.month}": 40,
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Last 6 month contribution',
            style: TextStyleHelper.getw600size(20)),
        const SizedBox(height: 12),
        GeneralSixMonthBarChart(
          sixMonthBudget: data,
          average: 10,
          thisMonth: 50,
        )
      ],
    );
  }

  Widget _buildAddButton() {
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, RouteName.transactionAdd),
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: ColorConstant.color25CBEB,
            ),
          ),
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.add, color: ColorConstant.color25CBEB),
          const SizedBox(width: 8),
          Text(
            'Add',
            style:
                TextStyleHelper.getw600size(12, color: ColorConstant.primary),
          ),
        ],
      ),
    );
  }

  // -------------------- Transactions --------------------
  Widget _buildTypeTransactions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Transactions', style: TextStyleHelper.getw600size(20)),
            _buildAddButton(),
          ],
        ),
        const SizedBox(height: 12),
        _buildTransactions(),
      ],
    );
  }

  Widget _buildTransactions() {
    return Observer(builder: (context) {
      return store.isLoadingDetail
          ? const CircularProgressIndicatorTwoArcs()
          : ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: store
                  .smartGoalDetail.smartGoalDetail.transactions.keys.length,
              itemBuilder: ((context, index) {
                return _buildTransactionDays(store
                    .smartGoalDetail.smartGoalDetail.transactions.keys
                    .elementAt(index));
              }),
              separatorBuilder: (context, index) =>
                  const Divider(color: ColorConstant.divider),
            );
    });
  }

  Widget _buildTransactionDays(String key) {
    return Column(
      children: [
        Row(children: [
          Text(UIHelper.getDateFormat(key, 'dd MMM, yyyy'),
              style: TextStyleHelper.getw500size(14)),
          const SizedBox(width: 12),
          const Expanded(child: Divider(color: ColorConstant.divider))
        ]),
        const SizedBox(height: 12),
        RoundedContainer(
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount:
                store.smartGoalDetail.smartGoalDetail.transactions[key].length,
            itemBuilder: ((context, index) {
              return _buildTransactionItem(
                TransactionData.fromJson(store
                    .smartGoalDetail.smartGoalDetail.transactions[key][index]),
              );
            }),
            separatorBuilder: (context, index) =>
                const Divider(color: ColorConstant.divider),
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionItem(TransactionData item) {
    print(item.toJson());
    return TransactionItem(
      transactionData: item,
      date: UIHelper.getDateFormat(item.date, 'dd MMM, yyy'),
      amount: item.amount.toString(),
      icon: item.isIncome ? IconConstant.getEarn() : IconConstant.getExpense(),
      color: item.isIncome ? ColorConstant.income : ColorConstant.expense,
    );
  }
}
