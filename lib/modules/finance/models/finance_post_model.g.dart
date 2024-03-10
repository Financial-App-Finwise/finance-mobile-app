// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finance_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FinancePost _$FinancePostFromJson(Map<String, dynamic> json) => FinancePost(
      totalbalance: (json['totalbalance'] as num?)?.toDouble() ?? 0,
      currencyID: json['currencyID'] as int? ?? 2,
    );

Map<String, dynamic> _$FinancePostToJson(FinancePost instance) =>
    <String, dynamic>{
      'totalbalance': instance.totalbalance,
      'currencyID': instance.currencyID,
    };
