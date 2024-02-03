import 'package:finwise/modules/auth/screens/sign_in_screen.dart';
import 'package:finwise/modules/auth/screens/sign_up_screen.dart';
import 'package:finwise/modules/auth/screens/verify_email_screen.dart';
import 'package:finwise/modules/budget_plan/screens/add_budget_plan_screen.dart';
import 'package:finwise/modules/budget_plan/screens/budget_plan_screen.dart';
import 'package:finwise/modules/finance/screens/finance_screen.dart';
import 'package:finwise/modules/home/screens/home_screen.dart';
import 'package:finwise/modules/smart_goal/screens/smart_goal_detail_screen.dart';
import 'package:finwise/modules/smart_goal/screens/smart_goal_screen.dart';
import 'package:finwise/modules/transaction/screens/add_transaction_screen.dart';
import 'package:finwise/modules/transaction/screens/transaction_detail_screen.dart';
import 'package:finwise/modules/transaction/screens/transaction_screen.dart';
import 'package:finwise/modules/upcoming_bill/screens/upcoming_bill_screen.dart';
import 'package:finwise/screens/index_screen.dart';
import 'package:finwise/screens/splash_screen.dart';
import 'package:finwise/screens/wrapper_screen.dart';
import 'package:flutter/material.dart';

abstract class RouteName {
  static String splash = '/splash';
  static String wrapper = '/wrapper';
  static String signUp = '/sign_up';
  static String verifyEmail = '/verify_email';
  static String signIn = '/sign_in';
  static String index = '/index';
  static String home = '/home';
  static String budgetPlan = '/budget_plan';
  static String addBudget = '/budget_plan/create';
  static String finance = '/finance';
  static String transaction = '/transaction';
  static String transactionDetail = 'transaction/show';
  static String addTransaction = 'transaction/create';
  static String smartGoal = '/smart_goal';
  static String smartGoalDetail = '/smart_goal/show';
  static String upcomingBill = "/upcomingBill";
}

var appRoutes = {
  RouteName.wrapper: (BuildContext context) => WrapperScreen(),
  RouteName.splash: (BuildContext context) => SplashScreen(),
  RouteName.signUp: (BuildContext context) => SignUpScreen(),
  RouteName.signIn: (BuildContext context) => SignInScreen(),
  RouteName.verifyEmail: (BuildContext context) => VerifyEmailScreen(),
  RouteName.index: (BuildContext context) => IndexScreen(),
  RouteName.home: (BuildContext context) => HomeScreen(),
  RouteName.budgetPlan: (BuildContext context) => BudgetPlanScreen(),
  RouteName.addBudget: (BuildContext context) => AddBudgetPlanScreen(),
  RouteName.finance: (BuildContext context) => FinanceScreen(),
  RouteName.transaction: (BuildContext context) => TransactionScreen(),
  RouteName.transactionDetail: (BuildContext context) =>
      TransactionDetailScreen(),
  RouteName.addTransaction: (BuildContext context) => AddTransactionScreen(),
  RouteName.smartGoal: (BuildContext context) => SmartGoalScreen(),
  RouteName.smartGoalDetail: (BuildContext context) => SmartGoalDetailScreen(),
  RouteName.upcomingBill: (BuildContext context) => UpcomingBillScreen(),
};
