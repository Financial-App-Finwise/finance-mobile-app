import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/font_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/helpers/ui_helper.dart';
import 'package:finwise/core/layouts/general_detail_layout.dart';
import 'package:finwise/core/utils/ui_util.dart';
import 'package:finwise/modules/finance/stores/finance_store.dart';
import 'package:finwise/modules/transaction/models/transaction_model.dart';
import 'package:finwise/modules/transaction/stores/transaction_store.dart';
import 'package:finwise/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class TransactionDetailScreen extends StatefulWidget {
  const TransactionDetailScreen({super.key});

  @override
  State<TransactionDetailScreen> createState() =>
      _TransactionDetailScreenState();
}

class _TransactionDetailScreenState extends State<TransactionDetailScreen> {
  late final args =
      ModalRoute.of(context)!.settings.arguments as TransactionData;

  @override
  Widget build(BuildContext context) {
    return GeneralDetailLayout(
      themeColor: args.isIncome ? ColorConstant.income : ColorConstant.expense,
      gradient: LinearGradient(
        colors: args.isIncome
            ? [
                ColorConstant.smartGoalLight,
                ColorConstant.smartGoalThick,
              ]
            : [
                ColorConstant.expenseLight,
                ColorConstant.expenseIcon,
              ],
      ),
      title: args.note.isEmpty
          ? '${args.isIncome ? 'Income' : 'Expense'}'
          : args.note,
      subTitle: args.isIncome ? 'My Income' : 'My Expense',
      iconTitle: args.isIncome
          ? IconHelper.getSVG(
              SVGName.earn,
              color: ColorConstant.income,
            )
          : IconHelper.getSVG(
              SVGName.expense,
              color: ColorConstant.expense,
            ),
      onEdit: () => Navigator.pushNamed(
        context,
        RouteName.transactionEdit,
        arguments: args,
      ),
      onDelete: () {
        UIUtil.showModal(
          context,
          'Are you sure you want to delete this TRANSACTION?',
          '',
          onTap: () async {
            bool success = await context.read<TransactionStore>().delete(args);
            if (success) {
              await context.read<FinanceStore>().read();
              if (mounted) {
                // await context.read<TransactionStore>().readByPage(refreshed: true);
                Navigator.pop(context);
                Navigator.pop(context);
              }
            }
          },
        );
      },
      mainContent: _buildContent(),
    );
  }

  Widget _buildContent() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(),
          const SizedBox(height: 12),
          _buildOverviewContent(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return const Text(
      'Overview',
      style: TextStyle(
        fontFamily: FontConstant.balooThambi2,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: ColorConstant.black,
        letterSpacing: 1,
      ),
    );
  }

  Widget _buildOverviewContent() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorConstant.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          overviewCard(
            IconHelper.getSVG(
              args.isIncome ? SVGName.earn : SVGName.expense,
              color: args.isIncome
                  ? ColorConstant.incomeIcon
                  : ColorConstant.expense,
            ),
            args.isIncome ? 'Earned' : 'Spent',
            '\$${args.amount}',
            defaultStyle,
          ),
          Visibility(
            visible: args.budgetplanID != null,
            child: overviewCard(
              IconHelper.getSVG(
                SVGName.budgetPlan,
                color: args.isIncome
                    ? ColorConstant.incomeIcon
                    : ColorConstant.expense,
              ),
              'Budget Plan',
              '${args.budgetplanID}',
              defaultStyle,
            ),
          ),
          Visibility(
            visible: args.upcomingbillID != null,
            child: overviewCard(
              IconHelper.getSVG(
                SVGName.upcomingBill,
                color: args.isIncome
                    ? ColorConstant.incomeIcon
                    : ColorConstant.expense,
              ),
              'Upcoming Bill',
              '${args.upcomingbillID}',
              defaultStyle,
            ),
          ),
          Visibility(
            visible: args.categoryID != null,
            child: overviewCard(
              IconHelper.getSVG(
                SVGName.internet,
                color: args.isIncome
                    ? ColorConstant.incomeIcon
                    : ColorConstant.expense,
              ),
              'Category',
              '${args.categoryID}',
              defaultStyle,
            ),
          ),
          overviewCard(
            IconHelper.getSVG(
              SVGName.calendarTick,
              color: args.isIncome
                  ? ColorConstant.incomeIcon
                  : ColorConstant.expense,
            ),
            'Transaction date',
            '${UIHelper.getDateFormat(args.date, 'dd MMM, yyyy HH:mm:ss')}',
            defaultStyle,
          ),
          overviewCard(
            IconHelper.getSVG(
              SVGName.budgetPlan,
              color: args.isIncome
                  ? ColorConstant.incomeIcon
                  : ColorConstant.expense,
            ),
            'Note',
            args.note.isEmpty ? "You didn't add any note." : args.note,
            noteStyle,
            showDivider: false,
          ),
        ],
      ),
    );
  }

  Widget overviewCard(
    SvgPicture icon,
    String title,
    String description,
    TextStyle textStyle, {
    bool showDivider = true,
  }) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: icon,
            ),
            const SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    letterSpacing: 0.75,
                    color: ColorConstant.mainText,
                  ),
                ),
                const SizedBox(
                  height: 1,
                ),
                Text(
                  description,
                  style: textStyle,
                ),
              ],
            )
          ],
        ),
        Visibility(
          visible: showDivider,
          child: dividerGap(),
        ),
      ],
    );
  }

  TextStyle defaultStyle = const TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 24,
    letterSpacing: 1,
    color: ColorConstant.black,
  );

  TextStyle noteStyle = const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: 0.5,
    color: ColorConstant.black,
  );

  Widget dividerGap() {
    return const Column(
      children: [
        SizedBox(
          height: 17,
        ),
        Divider(
          color: Color(0xFFF2F2F2),
          thickness: 1,
        ),
        SizedBox(
          height: 17,
        ),
      ],
    );
  }
}
