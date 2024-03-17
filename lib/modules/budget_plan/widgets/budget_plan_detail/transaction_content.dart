import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/helpers/ui_helper.dart';
import 'package:finwise/core/widgets/filter_bar.dart';
import 'package:finwise/core/widgets/filter_bars/headers/models/filter_bar_header_item_model.dart';
import 'package:finwise/core/widgets/filter_bars/headers/widgets/general_filter_bar_header/general_filter_bar_header.dart';
import 'package:finwise/modules/budget_plan/models/budget_plan_model.dart';
import 'package:finwise/modules/budget_plan/screens/budget_plan_screen.dart';
import 'package:finwise/modules/budget_plan/store/budget_plan_store.dart';
import 'package:finwise/modules/categories/models/categories_model.dart';
import 'package:finwise/modules/categories/stores/category_store.dart';
import 'package:finwise/modules/transaction/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionContent extends StatefulWidget {
  final List<TransactionData> data;

  const TransactionContent({
    super.key,
    required this.data,
  });

  @override
  State<TransactionContent> createState() => _TransactionContentState();
}

class _TransactionContentState extends State<TransactionContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title(),
        const SizedBox(
          height: 16,
        ),
        GeneralFilterBarHeader(
          physics: const BouncingScrollPhysics(),
          items: [
            FilterBarHeaderItem(
              title: 'All',
              value: 'All',
            ),
            FilterBarHeaderItem(
              title: 'Recently',
              value: 'Recently',
            ),
            FilterBarHeaderItem(
              title: 'Earliest',
              value: 'Earliest',
            ),
            FilterBarHeaderItem(
              title: 'Lowest',
              value: 'Lowest',
            ),
            FilterBarHeaderItem(
              title: 'Highest',
              value: 'Higest',
            ),
          ],
          onTap: (value) async {},
          currentValue: 'All',
        ),
        const SizedBox(
          height: 16,
        ),
        for (int index = 0; index < widget.data.length; index++)
          Column(
            children: [
              _transaction(widget.data[index]),
              if (index < widget.data.length - 1)
                const SizedBox(
                  height: 12,
                ),
            ],
          ),
      ],
    );
  }

  Widget _title() {
    return const Text(
      'Transaction',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Color(0xFF191B29),
      ),
    );
  }

  Widget _transaction(TransactionData item) {
    return Column(
      children: [
        // Row(
        //   children: [
        //     Text(
        //       UIHelper.getDateFormat(item.date, "dd MMM, yyyy"),
        //       style: const TextStyle(
        //         fontSize: 14,
        //         fontWeight: FontWeight.w500,
        //         color: Color(0xFF333652),
        //       ),
        //     ),
        //     const SizedBox(
        //       width: 12,
        //     ),
        //     const Expanded(
        //       child: Divider(
        //         color: Color(0xFFE9EAF1),
        //       ),
        //     ),
        //   ],
        // ),
        // const SizedBox(
        //   height: 12,
        // ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              _transactionCard(item),
              // const Divider(
              //   color: Color(0xFFE9EAF1),
              // ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _transactionCard(TransactionData item) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: const Color(0xFFEE5353),
                    borderRadius: BorderRadius.circular(4)),
                child: const Icon(
                  Icons.car_rental_outlined,
                  color: Color(0xFFFFFFFF),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.note.isEmpty ? 'No note' : item.note,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF191B29),
                    ),
                  ),
                  Text(UIHelper.getDateFormat(item.date, "dd MMM, yyyy")),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Text(
                '\$${item.amount.toInt()}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFEE5353),
                ),
              ),
              IconHelper.getSVGDefault(SVGName.arrowRight),
            ],
          ),
        ],
      ),
    );
  }
}
