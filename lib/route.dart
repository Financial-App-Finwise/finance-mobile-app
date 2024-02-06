import 'package:finwise/modules/auth/screens/sign_in_screen.dart';
import 'package:finwise/modules/auth/screens/sign_up_screen.dart';
import 'package:finwise/modules/auth/screens/verify_email_screen.dart';
import 'package:finwise/modules/budget_plan/screens/add_budget_plan_screen.dart';
import 'package:finwise/modules/budget_plan/screens/budget_plan_screen.dart';
import 'package:finwise/modules/finance/screens/finance_screen.dart';
import 'package:finwise/modules/finance/screens/finance_update_screen.dart';
import 'package:finwise/modules/home/screens/home_screen.dart';
import 'package:finwise/modules/smart_goal/screens/smart_goal_create_screen.dart';
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

// store all route names
abstract class RouteName {
  // ----- starting screens -----
  static const String splash = '/splash';
  static const String wrapper = '/wrapper';
  static const String signUp = '/sign_up';
  static const String verifyEmail = '/verify_email';
  static const String signIn = '/sign_in';
  static const String index = '/index';
  static const String home = '/home';

  // ----- budget plan
  static const String budgetPlan = '/budget_plan';
  static const String addBudget = '/budget_plan/create';

  // ----- finance -----
  static const String finance = '/finance';
  static const String financeUpdate = '/finance/update';

  // ----- transaction -----
  static const String transaction = '/transaction';
  static const String transactionDetail = 'transaction/show';
  static const String transactionCreate = 'transaction/create';

  // ----- smart goal -----
  static const String smartGoal = '/smart_goal';
  static const String smartGoalDetail = '/smart_goal/show';
  static const String smartGoalCreate = '/smart_goal/create';

  // ----- upcoming bill -----
  static const String upcomingBill = "/upcomingBill";
}

// map from route names to screens
var appRoutes = {
  // ----- starting screens -----
  RouteName.wrapper: (BuildContext context) => const WrapperScreen(),
  RouteName.splash: (BuildContext context) => const SplashScreen(),
  RouteName.signUp: (BuildContext context) => const SignUpScreen(),
  RouteName.signIn: (BuildContext context) => const SignInScreen(),
  RouteName.verifyEmail: (BuildContext context) => VerifyEmailScreen(),
  RouteName.index: (BuildContext context) => const IndexScreen(),
  RouteName.home: (BuildContext context) => const HomeScreen(),

  // ----- budget plan -----
  RouteName.budgetPlan: (BuildContext context) => const BudgetPlanScreen(),
  RouteName.addBudget: (BuildContext context) => const AddBudgetPlanScreen(),

  // ----- finance -----
  RouteName.finance: (BuildContext context) => const FinanceScreen(),
  RouteName.financeUpdate: (BuildContext context) =>
      const FinanceUpdateScreen(),

  // ----- transaction -----
  RouteName.transaction: (BuildContext context) => const TransactionScreen(),
  RouteName.transactionDetail: (BuildContext context) =>
      const TransactionDetailScreen(),
  RouteName.transactionCreate: (BuildContext context) =>
      const AddTransactionScreen(),

  // ----- smart goal -----
  RouteName.smartGoal: (BuildContext context) => const SmartGoalScreen(),
  RouteName.smartGoalCreate: (BuildContext context) => const AddSmartGoalScreen(),
  RouteName.smartGoalDetail: (BuildContext context) =>
      const SmartGoalDetailScreen(),

  // ----- upcoming bill -----
  RouteName.upcomingBill: (BuildContext context) => const UpcomingBillScreen(),
};
