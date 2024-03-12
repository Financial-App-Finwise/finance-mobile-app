import 'package:json_annotation/json_annotation.dart';

part 'budget_plan_yearly_model.g.dart';

BudgetPlanYearly getBudgetPlanYearly(Map<String, dynamic> json) {
  return BudgetPlanYearly.fromJson(json);
}

@JsonSerializable()
class BudgetPlanYearly {
  late BudgetPlanMonth data;

  BudgetPlanYearly({
    required this.data,
  });

  factory BudgetPlanYearly.fromJson(Map<String, dynamic> json) =>
      _$BudgetPlanYearlyFromJson(json);
}

@JsonSerializable()
class BudgetPlanMonth {
  @JsonKey(name: 'January')
  late int jan;

  @JsonKey(name: 'February')
  late int feb;

  @JsonKey(name: 'March')
  late int mar;

  @JsonKey(name: 'April')
  late int apr;

  @JsonKey(name: 'May')
  late int may;

  @JsonKey(name: 'June')
  late int jun;

  @JsonKey(name: 'July')
  late int jul;

  @JsonKey(name: 'August')
  late int aug;

  @JsonKey(name: 'September')
  late int sep;

  @JsonKey(name: 'October')
  late int oct;

  @JsonKey(name: 'November')
  late int nov;

  @JsonKey(name: 'December')
  late int dec;

  BudgetPlanMonth({
    this.jan = 0,
    this.feb = 0,
    this.mar = 0,
    this.apr = 0,
    this.may = 0,
    this.jun = 0,
    this.jul = 0,
    this.aug = 0,
    this.sep = 0,
    this.oct = 0,
    this.nov = 0,
    this.dec = 0,
  });

  factory BudgetPlanMonth.fromJson(Map<String, dynamic> json) =>
      _$BudgetPlanMonthFromJson(json);
}
