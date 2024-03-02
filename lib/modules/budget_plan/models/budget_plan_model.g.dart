// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_plan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BudgetPlan _$BudgetPlanFromJson(Map<String, dynamic> json) => BudgetPlan(
      data: BudgetPlanItem.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BudgetPlanToJson(BudgetPlan instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

BudgetPlanItem _$BudgetPlanItemFromJson(Map<String, dynamic> json) =>
    BudgetPlanItem(
      totalBudget: json['total_budgets'] as int? ?? 0,
      available: json['available'] as int? ?? 0,
      spent: json['spent'] as int? ?? 0,
      plannedBudget: json['planned_budgets'] as int? ?? 0,
      overBudget: json['over_budget'] as int? ?? 0,
      budgetPlans: (json['budget_plans'] as List<dynamic>)
          .map((e) => BudgetPlanData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BudgetPlanItemToJson(BudgetPlanItem instance) =>
    <String, dynamic>{
      'total_budgets': instance.totalBudget,
      'available': instance.available,
      'spent': instance.spent,
      'planned_budgets': instance.plannedBudget,
      'over_budget': instance.overBudget,
      'budget_plans': instance.budgetPlans,
    };

BudgetPlanData _$BudgetPlanDataFromJson(Map<String, dynamic> json) =>
    BudgetPlanData(
      id: json['id'] as int? ?? 0,
      userID: json['userID'] as int? ?? 0,
      categoryID: json['categoryID'] as int? ?? 0,
      isMonthly: json['isMonthly'] == null
          ? false
          : BudgetPlanData._intToBool(json['isMonthly'] as int),
      name: json['name'] as String? ?? 'no name',
      amount: json['amount'] == null
          ? 0.0
          : BudgetPlanData._stringToDouble(json['amount'] as String),
      date: json['date'] as String? ?? 'no date',
      isRecurring: json['isRecurring'] == null
          ? false
          : BudgetPlanData._intToBool(json['isRecurring'] as int),
      createdAt: json['created_at'] as String? ?? 'no date',
      updatedAt: json['updated_at'] as String? ?? 'no date',
      transactionCount: json['transaction_counts'] as int? ?? 0,
      totalTransactionAmount: json['total_transactions_amount'] as int? ?? 0,
      remainingAmount: json['remaining_amount'] as int? ?? 0,
    );

Map<String, dynamic> _$BudgetPlanDataToJson(BudgetPlanData instance) =>
    <String, dynamic>{
      'userID': instance.userID,
      'categoryID': instance.categoryID,
      'isMonthly': BudgetPlanData._boolToInt(instance.isMonthly),
      'name': instance.name,
      'amount': BudgetPlanData._doubleToString(instance.amount),
      'date': instance.date,
      'isRecurring': BudgetPlanData._boolToInt(instance.isRecurring),
      'transaction_counts': instance.transactionCount,
      'total_transactions_amount': instance.totalTransactionAmount,
      'remaining_amount': instance.remainingAmount,
    };
