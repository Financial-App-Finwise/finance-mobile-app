// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      items: (json['data'] as List<dynamic>)
          .map((e) => TransactionData.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: TransactionMeta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'data': instance.items,
      'meta': instance.meta,
    };

TransactionData _$TransactionDataFromJson(Map<String, dynamic> json) =>
    TransactionData(
      id: json['id'] as int? ?? 0,
      userID: json['userID'] as int? ?? 0,
      categoryID: json['categoryID'] as int? ?? 0,
      categoryData: json['category'] == null
          ? null
          : CategoryData.fromJson(json['category'] as Map<String, dynamic>),
      isIncome: json['isIncome'] == null
          ? true
          : TransactionData._intToBool(json['isIncome'] as int),
      amount: json['amount'] == null
          ? 0
          : TransactionData._stringToDouble(json['amount']),
      hasContributed: json['hasContributed'] == null
          ? false
          : TransactionData._intToBool(json['hasContributed'] as int),
      upcomingbillID: json['upcomingbillID'] as int?,
      budgetplanID: json['budgetplanID'] as int?,
      expenseType: json['expenseType'] as String? ?? '',
      date: json['date'] as String? ?? '',
      note: json['note'] as String? ?? '',
      createdAt: json['created_at'] as String? ?? '',
      updatedAt: json['updated_at'] as String? ?? '',
    );

Map<String, dynamic> _$TransactionDataToJson(TransactionData instance) =>
    <String, dynamic>{
      'categoryID': instance.categoryID,
      'isIncome': TransactionData._boolToInt(instance.isIncome),
      'amount': instance.amount,
      'hasContributed': TransactionData._boolToInt(instance.hasContributed),
      'upcomingbillID': instance.upcomingbillID,
      'budgetplanID': instance.budgetplanID,
      'expenseType': instance.expenseType,
      'date': instance.date,
      'note': instance.note,
    };

TransactionLink _$TransactionLinkFromJson(Map<String, dynamic> json) =>
    TransactionLink();

Map<String, dynamic> _$TransactionLinkToJson(TransactionLink instance) =>
    <String, dynamic>{};

TransactionMeta _$TransactionMetaFromJson(Map<String, dynamic> json) =>
    TransactionMeta(
      total: json['total'] as int? ?? 0,
    );

Map<String, dynamic> _$TransactionMetaToJson(TransactionMeta instance) =>
    <String, dynamic>{
      'total': instance.total,
    };
