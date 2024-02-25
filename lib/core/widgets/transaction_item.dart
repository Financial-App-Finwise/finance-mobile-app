import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/constants/text_style_constants/home_text_style_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/helpers/text_style_helper.dart';
import 'package:finwise/core/widgets/small_rounded_square.dart';
import 'package:finwise/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    super.key,
    this.title = '',
    this.date = '',
    this.amount = '',
    this.color,
    this.icon,
  });

  final String title;
  final String date;
  final String amount;
  final Color? color;
  final Widget? icon;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildTransactionItem(),
    );
  }

  Widget _buildTransactionItem() {
    return TextButton(
      onPressed: () =>
          Navigator.pushNamed(context, RouteName.transactionDetail),
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
                          widget.title,
                          style: HomeTextStyleConstant.transactionItemTitle,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 1),
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
                  '\$${widget.amount}',
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
