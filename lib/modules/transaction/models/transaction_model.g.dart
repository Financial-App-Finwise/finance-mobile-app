// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionData _$TransactionDataFromJson(Map<String, dynamic> json) =>
    TransactionData(
      isIncome: json['isIncome'] as bool? ?? true,
      hasContributed: json['hasContributed'] as bool? ?? false,
      amount: (json['amount'] as num?)?.toDouble() ?? 0,
      date: json['date'] as String? ?? 'no data',
    );

Map<String, dynamic> _$TransactionDataToJson(TransactionData instance) =>
    <String, dynamic>{
      'isIncome': instance.isIncome,
      'hasContributed': instance.hasContributed,
      'amount': instance.amount,
      'date': instance.date,
    };
