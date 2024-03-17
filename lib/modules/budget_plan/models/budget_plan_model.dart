import 'package:finwise/modules/transaction/models/transaction_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'budget_plan_model.g.dart';

BudgetPlan getBudgetPlan(Map<String, dynamic> json) {
  return BudgetPlan.fromJson(json);
}

@JsonSerializable()
class BudgetPlan {
  late BudgetPlanItem data;

  BudgetPlan({required this.data});

  factory BudgetPlan.fromJson(Map<String, dynamic> json) =>
      _$BudgetPlanFromJson(json);

  Map<String, dynamic> toJson() => _$BudgetPlanToJson(this);
}

@JsonSerializable()
class BudgetPlanItem {
  @JsonKey(name: 'total_budgets')
  late int totalBudget;
  late int available;
  late int spent;
  late String date;

  @JsonKey(name: 'planned_budgets')
  late int plannedBudget;

  @JsonKey(name: 'over_budget')
  late int overBudget;

  @JsonKey(name: 'budget_plans')
  late List<BudgetPlanData> budgetPlans;

  BudgetPlanItem({
    this.totalBudget = 0,
    this.available = 0,
    this.spent = 0,
    this.date = 'no date',
    this.plannedBudget = 0,
    this.overBudget = 0,
    required this.budgetPlans,
  });

  factory BudgetPlanItem.fromJson(Map<String, dynamic> json) =>
      _$BudgetPlanItemFromJson(json);

  Map<String, dynamic> toJson() => _$BudgetPlanItemToJson(this);
}

@JsonSerializable()
class BudgetPlanData {
  @JsonKey(includeToJson: false)
  late int id;

  late int userID;
  late int categoryID;

  @JsonKey(fromJson: _intToBool, toJson: _boolToInt)
  late bool isMonthly;
  late String name;
  late int amount;
  late String date;

  @JsonKey(fromJson: _intToBool, toJson: _boolToInt)
  late bool isRecurring;

  @JsonKey(name: 'created_at', includeToJson: false)
  late String createdAt;

  @JsonKey(name: 'updated_at', includeToJson: false)
  late String updatedAt;

  @JsonKey(name: 'transactions_count')
  late int transactionCount;

  @JsonKey(name: 'spent')
  late int spent;

  @JsonKey(name: 'remaining_amount')
  late int remainingAmount;

  late List<TransactionData> transactions;

  BudgetPlanData({
    this.id = 0,
    this.userID = 0,
    this.categoryID = 0,
    this.isMonthly = false,
    this.name = 'no name',
    this.amount = 0,
    this.date = 'no date',
    this.isRecurring = false,
    this.createdAt = 'no date',
    this.updatedAt = 'no date',
    this.transactionCount = 0,
    this.spent = 0,
    this.remainingAmount = 0,
    List<TransactionData>?
        transactions, 
  }) : transactions = transactions ?? [];

  factory BudgetPlanData.fromJson(Map<String, dynamic> json) =>
      _$BudgetPlanDataFromJson(json);

  Map<String, dynamic> toJson() => _$BudgetPlanDataToJson(this);

  static double _stringToDouble(String value) => double.parse(value);

  static String _doubleToString(double value) => value.toString();

  static bool _intToBool(int value) => 1 == value;

  static int _boolToInt(bool value) => value ? 1 : 0;
}
