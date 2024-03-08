import 'package:finwise/modules/auth/screens/sign_in_screen.dart';
import 'package:finwise/modules/auth/screens/sign_up_screen.dart';
import 'package:finwise/modules/auth/screens/verify_email_screen.dart';
import 'package:finwise/modules/budget_plan/screens/add_budget_plan_screen.dart';
import 'package:finwise/modules/budget_plan/screens/budget_plan_detail_screen.dart';
import 'package:finwise/modules/budget_plan/screens/budget_plan_screen.dart';
import 'package:finwise/modules/budget_plan/screens/edit_budget_plan_screen.dart';
import 'package:finwise/modules/currency/screens/currency_screen.dart';
import 'package:finwise/modules/finance/screens/finance_screen.dart';
import 'package:finwise/modules/finance/screens/finance_update_screen.dart';
import 'package:finwise/modules/home/screens/home_screen.dart';
import 'package:finwise/modules/smart_goal/screens/smart_goal_create_screen.dart';
import 'package:finwise/modules/smart_goal/screens/smart_goal_detail_screen.dart';
import 'package:finwise/modules/smart_goal/screens/smart_goal_edit_screen.dart';
import 'package:finwise/modules/smart_goal/screens/smart_goal_screen.dart';
import 'package:finwise/modules/transaction/screens/transaction_create_screen.dart';
import 'package:finwise/modules/transaction/screens/transaction_detail_screen.dart';
import 'package:finwise/modules/transaction/screens/transaction_edit_screen.dart';
import 'package:finwise/modules/transaction/screens/transaction_screen.dart';
import 'package:finwise/modules/upcoming_bill/screens/add_upcoming_bill_screen.dart';
import 'package:finwise/modules/upcoming_bill/screens/edit_upcoming_bill_screen.dart';
import 'package:finwise/modules/upcoming_bill/screens/upcoming_bill_detail_screen.dart';
import 'package:finwise/modules/upcoming_bill/screens/upcoming_bill_screen.dart';
import 'package:finwise/initiating_screens/index_screen.dart';
import 'package:finwise/initiating_screens/splash_screen.dart';
import 'package:finwise/initiating_screens/wrapper_screen.dart';
import 'package:finwise/modules/user/profile_screen.dart';
import 'package:flutter/material.dart';

// store all route names
abstract class RouteName {
  // -------------------- Initiating Screens --------------------
  static const String splash = '/splash';
  static const String wrapper = '/wrapper';
  static const String signUp = '/sign_up';
  static const String verifyEmail = '/verify_email';
  static const String signIn = '/sign_in';
  static const String index = '/index';
  static const String home = '/home';

  // -------------------- Budget Plan --------------------
  static const String budgetPlan = '/budget_plan';
  static const String budgetPlanDetail = '/budget_plan/show';
  static const String addBudget = '/budget_plan/create';
  static const String editBudget = '/budget_plan/edit';

  // -------------------- Finance --------------------
  static const String finance = '/finance';
  static const String financeUpdate = '/finance/update';

  // -------------------- Transaction --------------------
  static const String transaction = '/transaction';
  static const String transactionDetail = '/transaction/show';
  static const String transactionCreate = '/transaction/create';
  static const String transactionEdit = '/transaction/edit';

  // -------------------- Smart Goal --------------------
  static const String smartGoal = '/smart_goal';
  static const String smartGoalDetail = '/smart_goal/show';
  static const String smartGoalCreate = '/smart_goal/create';
  static const String smartGoalEdit = '/smart_goal/edit';

  // -------------------- Upcoming Bill --------------------
  static const String upcomingBill = "/upcomingBill";
  static const String upcomingBillDetail = '/upcoming_bill/show';
  static const String addUpcomingBill = "/upcomingBill/add";
  static const String editUpcomingBill = "/upcomingBill/edit";

  // -------------------- Currency --------------------
  static const String currency = '/currency';

  // --------------------Category --------------------
  static const String category = '/category';

  // -------------------- Profile --------------------
  static const String profile = '/profile';
}

// map from route names to screens
var appRoutes = {
  // -------------------- Initiating Screens --------------------
  RouteName.wrapper: (BuildContext context) => const WrapperScreen(),
  RouteName.splash: (BuildContext context) => const SplashScreen(),
  RouteName.signUp: (BuildContext context) => const SignUpScreen(),
  RouteName.signIn: (BuildContext context) => const SignInScreen(),
  RouteName.verifyEmail: (BuildContext context) => const VerifyEmailScreen(),
  RouteName.index: (BuildContext context) => const IndexScreen(),
  RouteName.home: (BuildContext context) => const HomeScreen(),

  // -------------------- Budget Plan --------------------
  RouteName.budgetPlan: (BuildContext context) => const BudgetPlanScreen(),
  RouteName.budgetPlanDetail: (BuildContext context) =>
      const BudgetPlanDetailScreen(),
  RouteName.addBudget: (BuildContext context) => const AddBudgetPlanScreen(),
  RouteName.editBudget: (BuildContext context) => const EditBudgetPlanScreen(),

  // -------------------- Finance --------------------
  RouteName.finance: (BuildContext context) => const FinanceScreen(),
  RouteName.financeUpdate: (BuildContext context) =>
      const FinanceUpdateScreen(),

  // -------------------- Transaction --------------------
  RouteName.transaction: (BuildContext context) => const TransactionScreen(),
  RouteName.transactionDetail: (BuildContext context) =>
      const TransactionDetailScreen(),
  RouteName.transactionCreate: (BuildContext context) =>
      const AddTransactionScreen(),
  RouteName.transactionEdit: (BuildContext context) =>
      const TransactionEditScreen(),

  // -------------------- Smart goal --------------------
  RouteName.smartGoal: (BuildContext context) => const SmartGoalScreen(),
  RouteName.smartGoalCreate: (BuildContext context) =>
      const AddSmartGoalScreen(),
  RouteName.smartGoalDetail: (BuildContext context) =>
      const SmartGoalDetailScreen(),
  RouteName.smartGoalEdit: (BuildContext context) =>
      const SmartGoalEditScreen(),

  // -------------------- Upcoming Bill --------------------
  RouteName.upcomingBill: (BuildContext context) => const UpcomingBillScreen(),
  RouteName.upcomingBillDetail: (BuildContext context) =>
      UpcomingBillDetailScreen(),
  RouteName.addUpcomingBill: (BuildContext context) =>
      const AddUpcomingBillScreen(),
  RouteName.editUpcomingBill: (BuildContext context) =>
      const EditUpcomingBuildScreen(),

  // -------------------- Currency --------------------
  RouteName.currency: (BuildContext context) => const CurrencyScreen(),

  // -------------------- Profile --------------------
  RouteName.profile: (BuildContext context) => const ProfileScreen(),
};
