import 'package:finwise/modules/auth/stores/auth_store.dart';
import 'package:finwise/modules/budget_plan/store/budget_plan_store.dart';
import 'package:finwise/modules/finance/stores/finance_store.dart';
import 'package:finwise/modules/smart_goal/stores/smart_goal_store.dart';
import 'package:finwise/modules/categories/stores/category_store.dart';
import 'package:finwise/modules/transaction/stores/transaction_store.dart';
import 'package:finwise/modules/upcoming_bill/stores/upcoming_bill_store.dart';
import 'package:finwise/route.dart';
import 'package:finwise/themes/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:finwise/screens/splash_screen.dart';
import 'package:flutter/material.dart';

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
        Provider(create: (context) => BudgetPlanStore()),
        Provider(create: (context) => UpcomingBillStore()),
        Provider(create: (context) => TransactionStore()),
        Provider(create: (context) => FinanceStore()),

        // // // proxy provider
        ProxyProvider<AuthStore, SmartGoalStore>(
            update: (_, auth, smartGoal) => SmartGoalStore(authStore: auth)),
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
