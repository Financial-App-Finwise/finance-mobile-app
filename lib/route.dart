import 'package:finwise/screens/home_screen.dart';
import 'package:finwise/screens/main_screen.dart';
import 'package:finwise/screens/splash_screen.dart';
import 'package:flutter/material.dart';

var appRoutes = {
  '/splash': (BuildContext context) => SplashScreen(),
  '/index': (BuildContext context) => IndexScreen(),
  '/home': (BuildContext context) => HomeScreen(),
};