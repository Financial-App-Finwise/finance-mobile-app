import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/helpers/text_style_helper.dart';
import 'package:finwise/core/widgets/circular_progress/circular_progress_two_arches.dart';
import 'package:finwise/modules/auth/stores/auth_store.dart';
import 'package:finwise/modules/finance/stores/finance_store.dart';
import 'package:finwise/route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final authStore = context.read<AuthStore>();
  late final financeStore = context.read<FinanceStore>();

  @override
  void initState() {
    super.initState();
    debugPrint('--> START: splash screen initState');
    Future.delayed(Duration.zero, () async {
      debugPrint('<-- END: splash screen initState');
      await authStore.readCache();
      if (authStore.user != null) {
        await financeStore.read(updateFinance: true);
      }

      // if the state object is mounted
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(RouteName.wrapper);
      }
    });
  }

  @override
  void dispose() {
    debugPrint('--> START: splash screen gets disposed');
    debugPrint('<-- END: splash screen gets disposed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconHelper.getSVGDefault(SVGName.finwise),
                  const SizedBox(height: 10),
                  Text(
                    'Personal finance. Personal growth.',
                    style: TextStyleHelper.getw500size(14,
                        color: ColorConstant.color211F32),
                  ),
                ],
              ),
            ),
            CircularProgressIndicatorTwoArcs(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
