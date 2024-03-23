import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/enums/loading_status_enum.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/widgets/screens/loading_screen.dart';
import 'package:finwise/modules/finance/stores/finance_store.dart';
import 'package:finwise/modules/transaction/models/transaction_post_model.dart';
import 'package:finwise/modules/transaction/stores/transaction_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class TransactionCreateScreen extends StatefulWidget {
  final TransactionPost transactionPost;

  const TransactionCreateScreen({
    super.key,
    required this.transactionPost,
  });

  @override
  State<TransactionCreateScreen> createState() =>
      _TransactionCreateScreenState();
}

class _TransactionCreateScreenState extends State<TransactionCreateScreen> {
  late final store = context.read<TransactionStore>();
  late final financeStore = context.read<FinanceStore>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      bool success = await store.post(widget.transactionPost);

      if (success) {
        await financeStore.read(updateFinance: true);
        if (mounted) {
          Navigator.pop(context, success);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildLoadingScreen();
  }

  Widget _buildLoadingScreen() {
    return Observer(builder: (context) {
      return store.loadingCreate == LoadingStatusEnum.done
          ? LoadingScreen(
              title: 'Transaction Created Successfully!',
              description: 'Please wait...\nYou will be directed back.',
              icon: IconHelper.getSVG(SVGName.check, color: Colors.white),
            )
          : LoadingScreen(
              title: 'Just a moment',
              description: 'Please wait...\nWe are preparing for you...',
              icon: IconHelper.getSVG(SVGName.transaction, color: Colors.white),
            );
    });
  }
}
