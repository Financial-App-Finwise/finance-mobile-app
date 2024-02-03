// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'income_expense_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IncomeExpense _$IncomeExpenseFromJson(Map<String, dynamic> json) =>
    IncomeExpense(
      category: json['category'] as String? ?? 'no category',
      amount: (json['amount'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$IncomeExpenseToJson(IncomeExpense instance) =>
    <String, dynamic>{
      'category': instance.category,
      'amount': instance.amount,
    };
