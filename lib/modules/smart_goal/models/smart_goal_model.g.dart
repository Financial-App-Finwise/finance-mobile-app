// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smart_goal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SmartGoal _$SmartGoalFromJson(Map<String, dynamic> json) => SmartGoal(
      items: (json['data'] as List<dynamic>)
          .map((e) => SmartGoalData.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: SmartGoalMeta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SmartGoalToJson(SmartGoal instance) => <String, dynamic>{
      'data': instance.items,
    };

SmartGoalData _$SmartGoalDataFromJson(Map<String, dynamic> json) =>
    SmartGoalData(
      id: json['id'] as int? ?? 0,
      userID: json['userID'] as int? ?? 0,
      name: json['name'] as String? ?? 'no name',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      currentSave: (json['currentSave'] as num?)?.toDouble() ?? 0.0,
      remainingSave: (json['remainingSave'] as num?)?.toDouble() ?? 0.0,
      setDate: json['setDate'] == null
          ? false
          : SmartGoalData._intToBool(json['setDate'] as int),
      startDate: json['startDate'] as String? ?? 'no date',
      endDate: json['endDate'] as String? ?? 'no date',
      monthlyContribution:
          (json['monthlyContribution'] as num?)?.toDouble() ?? 0.0,
      createdAt: json['created_at'] as String? ?? 'no date',
      updatedAt: json['updated_at'] as String? ?? 'no date',
      transactionCount: json['transactionCount'] as int? ?? 0,
    )
      ..transactionCountDetail = json['transactions_count'] as int
      ..transactions = (json['transactions'] as List<dynamic>)
          .map((e) => Transaction.fromJson(e as Map<String, dynamic>))
          .toList()
      ..contributions =
          json['contribution_amounts_last_6_months'] as List<dynamic>
      ..averageContribution =
          (json['average_total_contribution'] as num).toDouble()
      ..totalContributionLastMonth =
          (json['total_contribution_last_month'] as num).toDouble();

Map<String, dynamic> _$SmartGoalDataToJson(SmartGoalData instance) =>
    <String, dynamic>{
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
