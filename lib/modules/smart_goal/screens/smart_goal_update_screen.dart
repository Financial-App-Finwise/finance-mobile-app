import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/widgets/screens/loading_screen.dart';
import 'package:finwise/modules/smart_goal/models/smart_goal_model.dart';
import 'package:finwise/modules/smart_goal/stores/smart_goal_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class SmartGoalUpdateScreen extends StatefulWidget {
  final SmartGoalData smartGoalData;

  const SmartGoalUpdateScreen({
    super.key,
    required this.smartGoalData,
  });

  @override
  State<SmartGoalUpdateScreen> createState() => _SmartGoalUpdateScreenState();
}

class _SmartGoalUpdateScreenState extends State<SmartGoalUpdateScreen> {
  late final store = context.read<SmartGoalStore>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      bool success = await store.update(widget.smartGoalData);

      if (success) {
        // wait for finance to update on the screen
        await store.readByPage(
          refreshed: true,
          updateScreen: true,
        );

        // close the screen
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
              title: 'Just a moment',
              description: 'Please wait...\nWe are preparing for you...',
              icon: IconHelper.getSVG(SVGName.transaction, color: Colors.white),
            )
          : LoadingScreen(
              title: 'Smart Goal Updated Successfully!',
              description:
                  'Please wait...\nYou will be directed to your finance.',
              icon: IconHelper.getSVG(SVGName.check, color: Colors.white),
            );
    });
  }
}
