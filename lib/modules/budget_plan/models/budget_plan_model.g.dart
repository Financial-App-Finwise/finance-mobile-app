// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_plan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BudgetPlan _$BudgetPlanFromJson(Map<String, dynamic> json) => BudgetPlan(
      data: (json['data'] as List<dynamic>)
          .map((e) => BudgetPlan.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BudgetPlanToJson(BudgetPlan instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

BudgetPlanData _$BudgetPlanDataFromJson(Map<String, dynamic> json) =>
    BudgetPlanData(
      id: json['id'] as int? ?? 0,
      userID: json['userID'] as int? ?? 0,
      categoryID: json['categoryID'] as int? ?? 0,
      isMonthly: json['isMonthly'] as bool? ?? false,
      name: json['name'] as String? ?? 'no name',
      amount: json['amount'] == null
          ? 0.0
          : BudgetPlanData._stringToDouble(json['amount'] as String),
      createdAt: json['created_at'] as String? ?? 'no date',
      updatedAt: json['updated_at'] as String? ?? 'no date',
    );

Map<String, dynamic> _$BudgetPlanDataToJson(BudgetPlanData instance) =>
    <String, dynamic>{
      'userID': instance.userID,
      'categoryID': instance.categoryID,
      'isMonthly': instance.isMonthly,
      'name': instance.name,
      'amount': instance.amount,
    };
