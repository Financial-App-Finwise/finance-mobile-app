import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/layouts/detail_header_layout.dart';
import 'package:finwise/core/widgets/switch_input.dart';
import 'package:finwise/modules/upcoming_bill/models/upcoming_bill_model.dart';
import 'package:finwise/modules/upcoming_bill/screens/edit_upcoming_bill_screen.dart';
import 'package:finwise/modules/upcoming_bill/stores/upcoming_bill_store.dart';
import 'package:finwise/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class UpcomingBillDetailScreen extends StatefulWidget {
  UpcomingBillDetailScreen({super.key});

  @override
  State<UpcomingBillDetailScreen> createState() =>
      _UpcomingBillDetailScreenState();
}

class _UpcomingBillDetailScreenState extends State<UpcomingBillDetailScreen> {
  late final UpcomingBillData args =
      ModalRoute.of(context)!.settings.arguments as UpcomingBillData;

  @override
  Widget build(BuildContext context) {
    return DetailHeaderLayout(
      gradient1: const Color(0xFFFBA6A6),
      gradient2: const Color(0xFFEE5353),
      title: args.name,
      description: 'Upcoming Bill',
      editScreen: const EditUpcomingBuildScreen(),
      edit: () {
        Navigator.pushNamed(context, RouteName.editUpcomingBill,
            arguments: args);
      },
      delete: () async {
        bool success = await context.read<UpcomingBillStore>().delete(args);
        if (success) {
          Navigator.of(context).pop();
          Navigator.pop(context);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Overview',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              letterSpacing: 1,
              color: ColorConstant.black,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          overviewContent(),
          const SizedBox(
            height: 16,
          ),
          recurrringMonth(),
        ],
      ),
    );
  }

  Widget overviewContent() {
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

  Widget recurrringMonth() {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: ColorConstant.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recurring every month',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    letterSpacing: 1,
                    color: ColorConstant.mainText,
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  'This upcoming bill will carry forward to future months as well.',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    height: 2,
                    letterSpacing: 0.75,
                    color: ColorConstant.thin,
                  ),
                ),
              ],
            ),
          ),
          SwitchInput(),
        ],
      ),
    );
  }
}
