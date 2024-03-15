import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/enums/loading_status_enum.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/widgets/screens/loading_screen.dart';
import 'package:finwise/modules/budget_plan/models/budget_plan_model.dart';
import 'package:finwise/modules/budget_plan/store/budget_plan_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class BudgetPlanEditScreen extends StatefulWidget {
  final BudgetPlanData budgetPlanData;

  const BudgetPlanEditScreen({
    super.key,
    required this.budgetPlanData,
  });

  @override
  State<BudgetPlanEditScreen> createState() => _BudgetPlanEditScreenState();
}

class _BudgetPlanEditScreenState extends State<BudgetPlanEditScreen> {
  late final store = context.read<BudgetPlanStore>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      bool success = await store.edit(widget.budgetPlanData);

      if (success) {
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pop(context, success);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildLoadingScreen();
  }

  Widget _buildLoadingScreen() {
    return Observer(builder: (context) {
      return store.createStatus == LoadingStatusEnum.done
          ? LoadingScreen(
              title: 'Budget Edited Successfully!',
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
