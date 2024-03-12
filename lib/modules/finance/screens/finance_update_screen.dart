import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/enums/loading_status_enum.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/widgets/screens/loading_screen.dart';
import 'package:finwise/modules/finance/stores/finance_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class FinanceUpdateScreen extends StatefulWidget {
  final double totalBalance;

  const FinanceUpdateScreen({
    super.key,
    this.totalBalance = 0,
  });

  @override
  State<FinanceUpdateScreen> createState() => _FinanceUpdateScreenState();
}

class _FinanceUpdateScreenState extends State<FinanceUpdateScreen> {
  late final store = context.read<FinanceStore>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      bool success = await store.update(widget.totalBalance);

      if (success) {
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
      return store.isLoadingUpdate
          ? LoadingScreen(
              title: 'Balance Updated Successfully!',
              description:
                  'Please wait...\nYou will be directed to your finance.',
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
