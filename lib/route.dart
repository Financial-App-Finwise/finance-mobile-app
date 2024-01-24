import 'package:finwise/modules/auth/screens/sign_in_screen.dart';
import 'package:finwise/modules/auth/screens/sign_up_screen.dart';
import 'package:finwise/modules/budget_plan/screens/add_budget_plan_screen.dart';
import 'package:finwise/modules/budget_plan/screens/budget_plan_screen.dart';
import 'package:finwise/modules/home/screens/home_screen.dart';
import 'package:finwise/screens/index_screen.dart';
import 'package:finwise/screens/splash_screen.dart';
import 'package:flutter/material.dart';

abstract class RouteName {
  static String splash = '/splash';
  static String signIn = '/sign_in';
  static String signUp = '/sign_up';
  static String index = '/index';
  static String home ='/home';
  static String budgetPlan = '/budget_plan';
  static String addBudget = '/budget_plan/create';
}

var appRoutes = {
  RouteName.splash: (BuildContext context) => SplashScreen(),
  RouteName.signIn: (BuildContext context) => SignInScreen(),
  RouteName.signUp: (BuildContext context) => SignUpScreen(),
  RouteName.index: (BuildContext context) => IndexScreen(),
  RouteName.home: (BuildContext context) => HomeScreen(),
  RouteName.budgetPlan: (BuildContext context) => BudgetPlanScreen(),
  RouteName.addBudget: (BuildContext context) => AddBudgetPlanScreen(),
};