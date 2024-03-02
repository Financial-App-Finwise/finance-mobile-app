import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/font_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/widgets/general_detail_layout.dart';
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
      themeColor: ColorConstant.income,
      gradient: LinearGradient(
        colors: [
          ColorConstant.smartGoalLight,
          ColorConstant.smartGoalThick,
        ],
      ),
      title: 'CADT Salary',
      subTitle: 'My Income',
      iconTitle: IconHelper.getSVG(SVGName.earn, color: ColorConstant.income),
      onEdit: () => Navigator.pushNamed(context, RouteName.transactionEdit),
      onDelete: () async {
        bool success = await context.read<TransactionStore>().delete(args);
        if (success) {
          if (mounted) {
            // await context.read<TransactionStore>().readByPage(refreshed: true);
            await context.read<FinanceStore>().read();
            Navigator.pop(context);
            Navigator.pop(context);
          }
        }
      },
      mainContent: _buildContent(),
    );
  }

  Widget _buildContent() {
    return Container(
      padding: EdgeInsets.all(16),
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
              SVGName.expense,
              color: ColorConstant.overbudgetIcon,
            ),
            'Spent',
            '-\$2.5',
            defaultStyle,
          ),
          dividerGap(),
          overviewCard(
            IconHelper.getSVG(
              SVGName.internet,
              color: ColorConstant.overbudgetIcon,
            ),
            'Category',
            'Entertainment',
            defaultStyle,
          ),
          dividerGap(),
          overviewCard(
            IconHelper.getSVG(
              SVGName.calendarTick,
              color: ColorConstant.overbudgetIcon,
            ),
            'Transaction date',
            '13 Nov, 2026',
            defaultStyle,
          ),
          dividerGap(),
          overviewCard(
            IconHelper.getSVG(
              SVGName.budgetPlan,
              color: ColorConstant.overbudgetIcon,
            ),
            'Note',
            'You didn\'t add any note.',
            noteStyle,
          ),
        ],
      ),
    );
  }

  Widget overviewCard(
      SvgPicture icon, String title, String description, TextStyle textStyle) {
    return Row(
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
              style: TextStyle(
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
    );
  }

  TextStyle defaultStyle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 24,
    letterSpacing: 1,
    color: ColorConstant.black,
  );

  TextStyle noteStyle = TextStyle(
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
