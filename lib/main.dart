import 'package:flutter/material.dart';
import 'package:test/modules/auth/screens/sign_in_screen.dart';
import 'package:test/modules/auth/screens/sign_up_screen.dart';
import 'package:test/themes/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: ,
      home: SignUpScreen(),
      theme: appTheme,
    );
  }
}