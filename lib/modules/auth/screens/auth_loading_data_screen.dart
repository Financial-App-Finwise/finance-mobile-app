import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/enums/smart_goal_status_enum.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/widgets/screens/loading_screen.dart';
import 'package:finwise/modules/data_science/stores/insight_store.dart';
import 'package:finwise/modules/finance/stores/finance_store.dart';
import 'package:finwise/modules/smart_goal/stores/smart_goal_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthLoadingDataScreen extends StatefulWidget {
  const AuthLoadingDataScreen({super.key});

  @override
  State<AuthLoadingDataScreen> createState() => _AuthLoadingDataScreenState();
}

class _AuthLoadingDataScreenState extends State<AuthLoadingDataScreen> {
  // **************************************************************************
  // Required Stores
  // **************************************************************************
  late final FinanceStore _financeStore = context.read<FinanceStore>();
  late final InsightStore _insightStore = context.read<InsightStore>();
  late final SmartGoalStore _smartGoalStore = context.read<SmartGoalStore>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await _readAll();
    });
  }

  // -------------------- Read all Necessary Data --------------------
  Future _readAll() async {
    _insightStore.loadWebPage();
    await _financeStore.read(updateFinance: true);
    await _smartGoalStore.read(status: SmartGoalStatusEnum.all);

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildLoadingScreen();
  }

  Widget _buildLoadingScreen() {
    return LoadingScreen(
      title: 'Just a moment',
      description: 'Loading...\n',
      icon: IconHelper.getSVG(SVGName.transaction, color: Colors.white),
    );
  }
}
