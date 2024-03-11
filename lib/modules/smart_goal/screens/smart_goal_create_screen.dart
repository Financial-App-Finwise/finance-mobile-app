import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/enums/loading_status_enum.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/widgets/screens/loading_screen.dart';
import 'package:finwise/modules/smart_goal/models/smart_goal_model.dart';
import 'package:finwise/modules/smart_goal/stores/smart_goal_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class SmartGoalCreateScreen extends StatefulWidget {
  final SmartGoalData smartGoalData;

  const SmartGoalCreateScreen({
    super.key,
    required this.smartGoalData,
  });

  @override
  State<SmartGoalCreateScreen> createState() =>
      _SmartGoalCreateScreenState();
}

class _SmartGoalCreateScreenState extends State<SmartGoalCreateScreen> {
  late final store = context.read<SmartGoalStore>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      bool success = await store.post(widget.smartGoalData);

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
    return Observer(
      builder: (context) {
        return store.loadingCreate == LoadingStatusEnum.done
            ? LoadingScreen(
                title: 'Goal Created Successfully!',
                description:
                    'Please wait...\nYou will be directed back.',
                icon: IconHelper.getSVG(SVGName.check, color: Colors.white),
              )
            : LoadingScreen(
                title: 'Just a moment',
                description: 'Please wait...\nWe are preparing for you...',
                icon: IconHelper.getSVG(SVGName.transaction, color: Colors.white),
              );
      }
    );
  }
}
