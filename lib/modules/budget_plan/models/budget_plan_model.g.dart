// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_plan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BudgetPlan _$BudgetPlanFromJson(Map<String, dynamic> json) => BudgetPlan(
      data: February.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BudgetPlanToJson(BudgetPlan instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

February _$FebruaryFromJson(Map<String, dynamic> json) => February(
      monthData: (json['February'] as List<dynamic>)
          .map((e) => BudgetPlanData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FebruaryToJson(February instance) => <String, dynamic>{
      'February': instance.monthData,
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
      createdAt: json['created_at'] as String? ?? 'no date',
      updatedAt: json['updated_at'] as String? ?? 'no date',
    );

Map<String, dynamic> _$BudgetPlanDataToJson(BudgetPlanData instance) =>
    <String, dynamic>{
      'userID': instance.userID,
      'categoryID': instance.categoryID,
      'isMonthly': BudgetPlanData._boolToInt(instance.isMonthly),
      'name': instance.name,
      'amount': BudgetPlanData._doubleToString(instance.amount),
    };
