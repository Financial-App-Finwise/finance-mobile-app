import 'package:finwise/core/enums/budget_plan_enum.dart';

abstract class BudgetPlanHelper {
  static Map<BudgetPlanFilterEnum, String> enumToQuery = {
    BudgetPlanFilterEnum.all: '',
    BudgetPlanFilterEnum.monthlyBudget: 'is_monthly=1',
    BudgetPlanFilterEnum.oneTimeBudget: 'is_monthly=0',
  };
}
