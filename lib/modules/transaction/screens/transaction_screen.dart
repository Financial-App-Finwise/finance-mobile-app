import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:finwise/core/enums/transaction_period_enum.dart';
import 'package:finwise/core/enums/transaction_type_enum.dart';
import 'package:finwise/core/helpers/text_style_helper.dart';
import 'package:finwise/core/helpers/ui_helper.dart';
import 'package:finwise/core/widgets/circular_progress/circular_progress_two_arches.dart';
import 'package:finwise/core/widgets/custom_refresh_indicator.dart';
import 'package:finwise/core/widgets/filter_bars/headers/models/filter_bar_header_item_model.dart';
import 'package:finwise/core/widgets/filter_bars/headers/widgets/general_filter_bar_header/general_filter_bar_header.dart';
import 'package:finwise/core/layouts/general_simple_header_layout.dart';
import 'package:finwise/core/widgets/filter_bars/headers/widgets/rect_filter_bar_header/rect_filter_bar_header.dart';
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
      await store.readByPage(refreshed: true);
    });
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
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          if (notification.metrics.pixels ==
              notification.metrics.maxScrollExtent) {
            Future.delayed(Duration.zero, () async {
              await store.readByPage();
            });
            return true;
          }
        }
        return true;
      },
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    return CustomRefreshIndicator(
      onRefresh: () async => await store.readByPage(refreshed: true),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            RectFilterBarHeader(
              type: RectFilterBarHeaderType.expanded,
              currentValue: store.filteredType,
              fontSize: 16,
              items: [
                FilterBarHeaderItem(
                    title: 'All', value: TransactionTypeEnum.all),
                FilterBarHeaderItem(
                    title: 'Income', value: TransactionTypeEnum.income),
                FilterBarHeaderItem(
                    title: 'Expense', value: TransactionTypeEnum.expense),
              ],
              onTap: (value) async {
                if (!store.isLoading) {
                  store.changeFilteredType(value);
                  store.initialize();
                  if (store.filteredTransaction.items.isEmpty) {
                    await store.readByPage(refreshed: true);
                  }
                }
              },
            ),
            _buildTypeTransactions(type: TransactionTypeEnum.all),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  // -------------------- All, Income or Expense --------------------
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
          ? const CircularProgressIndicatorTwoArcs()
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                // List
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: store.filteredTransaction.items.length,
                  itemBuilder: ((context, index) {
                    final TransactionData item =
                        store.filteredTransaction.items[index];

                    // if it's not the first item
                    if (index > 0) {
                      // previous item
                      TransactionData previousItem =
                          store.filteredTransaction.items[index - 1];

                      // check date of the previous item
                      String previosItemDate = UIHelper.getDateFormat(
                          previousItem.date, 'dd MMM, yyyy');

                      // check date of the current item
                      String currentItemDate =
                          UIHelper.getDateFormat(item.date, 'dd MMM, yyyy');

                      // compare if they are the same
                      bool dateVisible = previosItemDate != currentItemDate;

                      return _buildTransactionItem(item,
                          dateVisible: dateVisible);
                    }
                    return _buildTransactionItem(item, dateVisible: true);
                  }),
                  separatorBuilder: (context, index) =>
                      const Divider(color: ColorConstant.divider),
                ),
                Visibility(
                  // visible: ,
                  child: const CircularProgressIndicatorTwoArcs(),
                ),
              ],
            );
    });
  }

  Widget _buildTransactionItem(
    TransactionData item, {
    bool dateVisible = false,
  }) {
    return Column(
      children: [
        Visibility(
          visible: dateVisible,
          child: Row(children: [
            Text(UIHelper.getDateFormat(item.date, 'dd MMM, yyyy'),
                style: TextStyleHelper.getw500size(14)),
            const SizedBox(width: 12),
            const Expanded(child: Divider(color: ColorConstant.divider))
          ]),
        ),
        TransactionItem(
          transactionData: item,
          date: UIHelper.getDateFormat(item.date, 'dd MMM, yyy'),
          amount: item.amount.toString(),
          icon: item.isIncome
              ? IconConstant.getEarn()
              : IconConstant.getExpense(),
          color: item.isIncome ? ColorConstant.income : ColorConstant.expense,
        ),
      ],
    );
  }
}
