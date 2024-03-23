// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smart_goal_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SmartGoalDetailModel _$SmartGoalDetailModelFromJson(
        Map<String, dynamic> json) =>
    SmartGoalDetailModel(
      smartGoalDetail:
          SmartGoalDetail.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SmartGoalDetailModelToJson(
        SmartGoalDetailModel instance) =>
    <String, dynamic>{
      'data': instance.smartGoalDetail,
    };

SmartGoalDetail _$SmartGoalDetailFromJson(Map<String, dynamic> json) =>
    SmartGoalDetail(
      id: json['id'] as int? ?? 0,
      userID: json['userID'] as int? ?? 0,
      name: json['name'] as String? ?? 'no name',
      amount: json['amount'] == null
          ? 0.0
          : SmartGoalDetail._stringToDouble(json['amount']),
      currentSave: json['currentSave'] == null
          ? 0.0
          : SmartGoalDetail._stringToDouble(json['currentSave']),
      remainingSave: json['remainingSave'] == null
          ? 0.0
          : SmartGoalDetail._stringToDouble(json['remainingSave']),
      setDate: json['setDate'] == null
          ? false
          : SmartGoalDetail._intToBool(json['setDate'] as int),
      startDate: json['startDate'] as String? ?? 'no date',
      endDate: json['endDate'] as String? ?? 'no date',
      monthlyContribution: json['monthlyContribution'] == null
          ? 0.0
          : SmartGoalDetail._stringToDouble(json['monthlyContribution']),
      createdAt: json['created_at'] as String? ?? 'no date',
      updatedAt: json['updated_at'] as String? ?? 'no date',
      transactionCount: json['transactions_count'] as int? ?? 0,
      transactions: SmartGoalDetail._toMap(json['transactions']),
      contributions:
          json['contribution_amounts_last_6_months'] as List<dynamic>,
      averageContribution: json['average_total_contribution'] == null
          ? 0
          : SmartGoalDetail._stringToDouble(json['average_total_contribution']),
      totalContributionLastMonth: json['total_contribution_last_month'] == null
          ? 0
          : SmartGoalDetail._stringToDouble(
              json['total_contribution_last_month']),
    );

Map<String, dynamic> _$SmartGoalDetailToJson(SmartGoalDetail instance) =>
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

ContributionItem _$ContributionItemFromJson(Map<String, dynamic> json) =>
    ContributionItem();

Map<String, dynamic> _$ContributionItemToJson(ContributionItem instance) =>
    <String, dynamic>{};
