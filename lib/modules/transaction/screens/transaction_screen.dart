import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/text_style_constants/general_text_style_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:finwise/core/enums/transaction_period_enum.dart';
import 'package:finwise/core/enums/transaction_type_enum.dart';
import 'package:finwise/core/helpers/ui_helper.dart';
import 'package:finwise/core/widgets/circular_progress/circular_progress_two_arches.dart';
import 'package:finwise/core/widgets/filter_bars/headers/models/filter_bar_header_item_model.dart';
import 'package:finwise/core/widgets/filter_bars/headers/widgets/general_filter_bar_header/general_filter_bar_header.dart';
import 'package:finwise/core/widgets/general_simple_header_layout.dart';
import 'package:finwise/core/widgets/filter_bars/headers/widgets/rect_filter_bar_header/rect_filter_bar_header.dart';
import 'package:finwise/core/widgets/rounded_container.dart';
import 'package:finwise/core/widgets/transaction_item.dart';
import 'package:finwise/modules/transaction/models/transaction_model.dart';
import 'package:finwise/modules/transaction/stores/transaction_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  late TransactionStore store = context.read<TransactionStore>();

  @override
  void initState() {
    super.initState();
    store.initialize();
    Future.delayed(Duration.zero, () async {
      await context.read<TransactionStore>().readByPage(refreshed: true);
    });
    store.setReaction();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GeneralSimpleHeaderLayout(
      title: 'All Transactions',
      description:
          'Explore a detailed breakdown of your financial transactions.',
      gradient: const LinearGradient(
        colors: [
          ColorConstant.secondary,
          ColorConstant.primary,
        ],
        stops: [0, 1],
      ),
      child: RefreshIndicator(
        onRefresh: () async {
          await context.read<TransactionStore>().readByPage(refreshed: true);
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              RectFilterBarHeader(
                type: RectFilterBarHeaderType.expanded,
                currentValue: TransactionTypeEnum.all,
                fontSize: 16,
                items: [
                  FilterBarHeaderItem(
                      title: 'All', value: TransactionTypeEnum.all),
                  FilterBarHeaderItem(
                      title: 'Income', value: TransactionTypeEnum.income),
                  FilterBarHeaderItem(
                      title: 'Expense', value: TransactionTypeEnum.expense),
                ],
                onTap: (value) {
                  // context
                  //     .read<TransactionStore>()
                  //     .changeFilteredType(value);
                  store.changeFilteredType(value);
                },
              ),
              _buildTypeTransactions(type: TransactionTypeEnum.all),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  // ---------- All, Income or Expense ----------
  Widget _buildTypeTransactions({
    TransactionTypeEnum type = TransactionTypeEnum.all,
  }) {
    return Column(
      children: [
        GeneralFilterBarHeader(
          currentValue: TransactionPeriodEnum.all,
          physics: const BouncingScrollPhysics(),
          items: [
            FilterBarHeaderItem(title: 'All', value: TransactionPeriodEnum.all),
            FilterBarHeaderItem(
                title: 'Recently', value: TransactionPeriodEnum.recently),
            FilterBarHeaderItem(
                title: 'Earliest', value: TransactionPeriodEnum.earliest),
            FilterBarHeaderItem(
                title: 'Lowest', value: TransactionPeriodEnum.lowest),
            FilterBarHeaderItem(
                title: 'Highest', value: TransactionPeriodEnum.hightest),
          ],
          onTap: (value) {},
        ),
        _buildTransactions(),
      ],
    );
  }

  Widget _buildTransactions() {
    return Observer(builder: (context) {
      return store.isLoading
          ? CircularProgressIndicatorTwoArcs()
          : ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: store.filteredTransaction[store.queryParemeter]!.items
                  .length, // example
              itemBuilder: ((context, index) {
                return _buildTransactionItem(store
                    .filteredTransaction[store.queryParemeter]!.items[index]);
              }),
              separatorBuilder: (context, index) {
                return const Divider(color: ColorConstant.divider);
              },
            );
    });
  }

  //  Widget _buildTransactions() {
  //   return ListView.separated(
  //     physics: const NeverScrollableScrollPhysics(),
  //     shrinkWrap: true,
  //     itemCount: 2, // example
  //     itemBuilder: ((context, index) {
  //       return Observer(builder: (context) {
  //         if (store.typeFilteredTransactions.length >
  //             index + (periodIndex * 2)) {
  //           return _buildTransactionItem(
  //               store.typeFilteredTransactions[index + (periodIndex * 2)]);
  //         }
  //         return SizedBox();
  //       });
  //     }),
  //     separatorBuilder: (context, index) {
  //       return const Divider(color: ColorConstant.divider);
  //     },
  //   );
  // }

  // test
  List<String> _periods = ['Today', 'Yesterday', 'Previously'];

  Widget _buildPeriodTransactions() {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (context, index) {
        return _buildPeriodTransactionItems(index, day: _periods[index]);
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 8);
      },
    );
  }

  // Widget _buildTodayTranscations({bool isIncome = true}) {
  //   return Column(
  //     children: [
  //       Row(children: [
  //         Text('Today', style: GeneralTextStyle.getSize(14)),
  //         const SizedBox(width: 12),
  //         const Expanded(child: Divider(color: ColorConstant.divider))
  //       ]),
  //       const SizedBox(height: 12),
  //       RoundedContainer(
  //         child: ListView.separated(
  //           physics: const NeverScrollableScrollPhysics(),
  //           shrinkWrap: true,
  //           itemCount: 2, // example
  //           itemBuilder: ((context, index) {
  //             return _buildTransactionItem();
  //           }),
  //           separatorBuilder: (context, index) {
  //             return const Divider(color: ColorConstant.divider);
  //           },
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildPeriodTransactionItems(
    int periodIndex, {
    String? day,
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
          child: _buildTransactions(),
        ),
      ],
    );
  }

  Widget _buildTransactionItem(TransactionData item) {
    return TransactionItem(
      transactionData: item,
      title: item.note,
      date: UIHelper.getDateFormat(item.date, 'dd MMM, yyy'),
      amount: item.amount.toString(),
      icon: item.isIncome ? IconConstant.getEarn() : IconConstant.getExpense(),
      color: item.isIncome ? ColorConstant.income : ColorConstant.expense,
    );
  }
}
