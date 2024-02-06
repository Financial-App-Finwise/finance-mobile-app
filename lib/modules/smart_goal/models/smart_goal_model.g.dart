// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smart_goal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SmartGoal _$SmartGoalFromJson(Map<String, dynamic> json) => SmartGoal(
      data: (json['data'] as List<dynamic>)
          .map((e) => SmartGoalData.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: SmartGoalMeta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SmartGoalToJson(SmartGoal instance) => <String, dynamic>{
      'data': instance.data,
    };

SmartGoalData _$SmartGoalDataFromJson(Map<String, dynamic> json) =>
    SmartGoalData(
      id: json['id'] as int? ?? 0,
      userID: json['userID'] as int? ?? 0,
      name: json['name'] as String? ?? 'no name',
      amount: json['amount'] == null
          ? 0.0
          : SmartGoalData._stringToDouble(json['amount'] as String),
      currentSave: json['currentSave'] == null
          ? 0.0
          : SmartGoalData._stringToDouble(json['currentSave'] as String),
      remainingSave: json['remainingSave'] == null
          ? 0.0
          : SmartGoalData._stringToDouble(json['remainingSave'] as String),
      setDate: json['setDate'] == null
          ? false
          : SmartGoalData._intToBool(json['setDate'] as int),
      startDate: json['startDate'] as String? ?? 'no date',
      endDate: json['endDate'] as String? ?? 'no date',
      monthlyContribution: json['monthlyContribution'] == null
          ? 0.0
          : SmartGoalData._stringToDouble(
              json['monthlyContribution'] as String),
      createdAt: json['created_at'] as String? ?? 'no date',
      updatedAt: json['updated_at'] as String? ?? 'no date',
    );

Map<String, dynamic> _$SmartGoalDataToJson(SmartGoalData instance) =>
    <String, dynamic>{
      'userID': instance.userID,
      'name': instance.name,
      'amount': instance.amount,
      'currentSave': instance.currentSave,
      'remainingSave': instance.remainingSave,
      'setDate': instance.setDate,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'monthlyContribution': instance.monthlyContribution,
    };

SmartGoalMeta _$SmartGoalMetaFromJson(Map<String, dynamic> json) =>
    SmartGoalMeta(
      total: json['total'] as int? ?? 0,
    );

Map<String, dynamic> _$SmartGoalMetaToJson(SmartGoalMeta instance) =>
    <String, dynamic>{
      'total': instance.total,
    };
