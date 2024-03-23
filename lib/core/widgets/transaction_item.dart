import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/constants/text_style_constants/home_text_style_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/helpers/text_style_helper.dart';
import 'package:finwise/core/widgets/small_rounded_square.dart';
import 'package:finwise/modules/transaction/models/transaction_model.dart';
import 'package:finwise/route.dart';
import 'package:flutter/material.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    super.key,
    this.title = '',
    this.date = '',
    this.amount = '',
    this.color,
    this.icon,
    required this.transactionData,
  });

  final String title;
  final String date;
  final String amount;
  final Color? color;
  final Widget? icon;
  final TransactionData transactionData;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  late final String title;

  @override
  void initState() {
    super.initState();
    title = widget.transactionData.budgetPlanData != null
        ? widget.transactionData.budgetPlanData!.name
        : widget.transactionData.upcomingBillData != null
            ? widget.transactionData.upcomingBillData!.name
            : widget.transactionData.categoryData != null
                ? widget.transactionData.categoryData!.name
                : widget.transactionData.note;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildTransactionItem(),
    );
  }

  Widget _buildTransactionItem() {
    return TextButton(
      onPressed: () => Navigator.pushNamed(
        context,
        RouteName.transactionDetail,
        arguments: widget.transactionData,
      ),
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        alignment: Alignment.center,
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  SmallRoundedSquare(
                    color: widget.color ?? ColorConstant.income,
                    icon: widget.icon,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title.isEmpty
                              ? widget.transactionData.isIncome
                                  ? 'My Income'
                                  : 'My Expense'
                              : title,
                          style: HomeTextStyleConstant.transactionItemTitle,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 1),
                        Text(widget.date,
                            style:
                                HomeTextStyleConstant.transactionItemSubtitle),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Row(
              children: [
                Text(
                  '\$${widget.transactionData.amount}',
                  style: TextStyleHelper.getw500size(20,
                      color: widget.color ?? ColorConstant.income),
                ),
                const SizedBox(width: 12),
                IconHelper.getSVG(SVGName.arrowRight,
                    color: const Color(0xff292D32)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
