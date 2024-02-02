import 'package:finwise/modules/auth/stores/auth_store.dart';
import 'package:finwise/modules/categories/stores/category_store.dart';
import 'package:finwise/route.dart';
import 'package:finwise/screens/index_screen.dart';
import 'package:finwise/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:finwise/themes/app_theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => AuthStore()),
        Provider(create: (context) => CategoryStore()),
      ],
      child: MaterialApp(
        // debugShowCheckedModeBanner: ,
        theme: appTheme,
        routes: appRoutes,
        home: const SplashScreen(),
      ),
    );
  }
}
