import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'budget_plan_model.g.dart';

BudgetPlan getBudgetPlan(Map<String, dynamic> json) {
  debugPrint('lllll ${json['data']}');
  return BudgetPlan.fromJson(json);
}

@JsonSerializable()
class BudgetPlan {
  late List<BudgetPlan> data;

  BudgetPlan({required this.data});

  factory BudgetPlan.fromJson(Map<String, dynamic> json) =>
      _$BudgetPlanFromJson(json);

  Map<String, dynamic> toJson() => _$BudgetPlanToJson(this);
}

@JsonSerializable()
class BudgetPlanData {
  @JsonKey(includeToJson: false)
  late int id;

  late int userID;
  late int categoryID;
  late bool isMonthly;
  late String name;

  @JsonKey(fromJson: _stringToDouble)
  late double amount;

  @JsonKey(name: 'created_at', includeToJson: false)
  late String createdAt;

  @JsonKey(name: 'updated_at', includeToJson: false)
  late String updatedAt;

  BudgetPlanData({
    this.id = 0,
    this.userID = 0,
    this.categoryID = 0,
    this.isMonthly = false,
    this.name = 'no name',
    this.amount = 0.0,
    this.createdAt = 'no date',
    this.updatedAt = 'no date',
  });

  factory BudgetPlanData.fromJson(Map<String, dynamic> json) =>
      _$BudgetPlanDataFromJson(json);

  Map<String, dynamic> toJson() => _$BudgetPlanDataToJson(this);

  static double _stringToDouble(String value) => double.parse(value);
}

// {
//   "id": 1,
//   "userID": 17,
//   "categoryID": 3,
//   "isMonthly": 0,
//   "name": "ea",
//   "amount": "822.08",
//   "created_at": "2023-12-27T03:46:04.000000Z",
//   "updated_at": "2023-09-10T21:08:29.000000Z"
// },
