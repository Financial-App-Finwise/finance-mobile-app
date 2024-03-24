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

class TransactionUpdateScreen extends StatefulWidget {
  final TransactionPost transactionPost;
  final int id;

  const TransactionUpdateScreen({
    super.key,
    required this.transactionPost,
    required this.id,
  });

  @override
  State<TransactionUpdateScreen> createState() =>
      _TransactionUpdateScreenState();
}

class _TransactionUpdateScreenState extends State<TransactionUpdateScreen> {
  late final store = context.read<TransactionStore>();
  late final financeStore = context.read<FinanceStore>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      bool success = await store.update(
        widget.transactionPost,
        widget.id,
      );
      success = true;

      if (success) {
        await financeStore.read();
        Navigator.pop(context, success);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildLoadingScreen();
  }

  Widget _buildLoadingScreen() {
    return Observer(builder: (context) {
      return store.loadingUpdate == LoadingStatusEnum.done
          ? LoadingScreen(
              title: 'Transaction Updated Successfully!',
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
