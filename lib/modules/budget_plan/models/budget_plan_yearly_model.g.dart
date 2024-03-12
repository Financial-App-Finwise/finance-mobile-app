// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_plan_yearly_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BudgetPlanYearly _$BudgetPlanYearlyFromJson(Map<String, dynamic> json) =>
    BudgetPlanYearly(
      data: BudgetPlanMonth.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BudgetPlanYearlyToJson(BudgetPlanYearly instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

BudgetPlanMonth _$BudgetPlanMonthFromJson(Map<String, dynamic> json) =>
    BudgetPlanMonth(
      jan: json['January'] as int? ?? 0,
      feb: json['February'] as int? ?? 0,
      mar: json['March'] as int? ?? 0,
      apr: json['April'] as int? ?? 0,
      may: json['May'] as int? ?? 0,
      jun: json['June'] as int? ?? 0,
      jul: json['July'] as int? ?? 0,
      aug: json['August'] as int? ?? 0,
      sep: json['September'] as int? ?? 0,
      oct: json['October'] as int? ?? 0,
      nov: json['November'] as int? ?? 0,
      dec: json['December'] as int? ?? 0,
    );

Map<String, dynamic> _$BudgetPlanMonthToJson(BudgetPlanMonth instance) =>
    <String, dynamic>{
      'January': instance.jan,
      'February': instance.feb,
      'March': instance.mar,
      'April': instance.apr,
      'May': instance.may,
      'June': instance.jun,
      'July': instance.jul,
      'August': instance.aug,
      'September': instance.sep,
      'October': instance.oct,
      'November': instance.nov,
      'December': instance.dec,
    };
