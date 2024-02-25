// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Finance _$FinanceFromJson(Map<String, dynamic> json) => Finance(
      items: (json['data'] as List<dynamic>)
          .map((e) => FinanceData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FinanceToJson(Finance instance) => <String, dynamic>{
      'data': instance.items,
    };

FinanceData _$FinanceDataFromJson(Map<String, dynamic> json) => FinanceData(
      id: json['id'] as int? ?? 0,
      userID: json['userID'] as int? ?? 0,
      totalbalance: json['totalbalance'] == null
          ? 0
          : FinanceData._stringToDouble(json['totalbalance'] as String),
      currency: Currency.fromJson(json['currency'] as Map<String, dynamic>),
      createdAt: json['created_at'] as String? ?? '',
      updatedAt: json['updated_at'] as String? ?? '',
    );

Map<String, dynamic> _$FinanceDataToJson(FinanceData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userID': instance.userID,
      'totalbalance': instance.totalbalance,
      'currency': instance.currency,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

Currency _$CurrencyFromJson(Map<String, dynamic> json) => Currency(
      id: json['id'] as int? ?? 0,
      code: json['code'] as String? ?? '',
      name: json['name'] as String? ?? '',
      createdAt: json['created_at'] as String? ?? '',
      updatedAt: json['updated_at'] as String? ?? '',
    );

Map<String, dynamic> _$CurrencyToJson(Currency instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
