import 'package:finwise/route.dart';
import 'package:finwise/screens/home_screen.dart';
import 'package:finwise/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:finwise/themes/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: ,
      theme: appTheme,
      routes: appRoutes,
      home: const SplashScreen(),
    );
  }
}