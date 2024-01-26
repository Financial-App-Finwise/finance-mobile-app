import 'package:finwise/modules/auth/stores/auth_store.dart';
import 'package:finwise/route.dart';
import 'package:finwise/modules/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    debugPrint('--> START: splash screen initState');
    Future.delayed(Duration(seconds: 1), () async {
      // if the state object is mounted
      if (mounted) {
        await context.read<AuthStore>().readCache();
        debugPrint('<-- END: splash screen initState');
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
      body: Center(child: Text('Splash Screen')),
    );
  }
}
