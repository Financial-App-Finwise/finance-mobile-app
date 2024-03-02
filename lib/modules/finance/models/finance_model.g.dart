// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Finance _$FinanceFromJson(Map<String, dynamic> json) => Finance(
      success: json['success'] as String? ?? '',
      data: FinanceData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FinanceToJson(Finance instance) => <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };

FinanceData _$FinanceDataFromJson(Map<String, dynamic> json) => FinanceData(
      items: (json['finance'] as List<dynamic>)
          .map((e) => FinanceItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalExpenses: (json['total_expenses'] as num?)?.toDouble() ?? 0,
      totalIncomes: (json['total_incomes'] as num?)?.toDouble() ?? 0,
      topTransactions: (json['top_transactions'] as List<dynamic>)
          .map((e) => TopTransaction.fromJson(e as Map<String, dynamic>))
          .toList(),
      allTransactions: AllTransaction.fromJson(
          json['all_transactions'] as Map<String, dynamic>),
      total: FinanceData._totalFromJson(json['totals']),
    );

Map<String, dynamic> _$FinanceDataToJson(FinanceData instance) =>
    <String, dynamic>{
      'finance': instance.items,
      'total_expenses': instance.totalExpenses,
      'total_incomes': instance.totalIncomes,
      'top_transactions': instance.topTransactions,
      'all_transactions': instance.allTransactions,
      'totals': instance.total,
    };

FinanceItem _$FinanceItemFromJson(Map<String, dynamic> json) => FinanceItem(
      id: json['id'] as int? ?? 0,
      userID: json['userID'] as int? ?? 0,
      totalbalance: json['totalbalance'] == null
          ? 0
          : FinanceItem._stringToDouble(json['totalbalance'] as String),
      currency: Currency.fromJson(json['currency'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FinanceItemToJson(FinanceItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userID': instance.userID,
      'totalbalance': instance.totalbalance,
      'currency': instance.currency,
    };

Currency _$CurrencyFromJson(Map<String, dynamic> json) => Currency(
      id: json['id'] as int? ?? 0,
      code: json['code'] as String? ?? '',
      name: json['name'] as String? ?? '',
    );

Map<String, dynamic> _$CurrencyToJson(Currency instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
    };

TopTransaction _$TopTransactionFromJson(Map<String, dynamic> json) =>
    TopTransaction(
      note: json['note'] as String,
      amount: json['amount'] as int,
    );

Map<String, dynamic> _$TopTransactionToJson(TopTransaction instance) =>
    <String, dynamic>{
      'note': instance.note,
      'amount': instance.amount,
    };

AllTransaction _$AllTransactionFromJson(Map<String, dynamic> json) =>
    AllTransaction(
      today: (json['today'] as List<dynamic>)
          .map((e) => TransactionData.fromJson(e as Map<String, dynamic>))
          .toList(),
      yesterday: (json['yesterday'] as List<dynamic>)
          .map((e) => TransactionData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllTransactionToJson(AllTransaction instance) =>
    <String, dynamic>{
      'today': instance.today,
      'yesterday': instance.yesterday,
    };

IncomeExpenseCompare _$IncomeExpenseCompareFromJson(
        Map<String, dynamic> json) =>
    IncomeExpenseCompare(
      totalIncome: (json['total_income'] as num?)?.toDouble() ?? 0,
      totalExpense: (json['total_expense'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$IncomeExpenseCompareToJson(
        IncomeExpenseCompare instance) =>
    <String, dynamic>{
      'total_income': instance.totalIncome,
      'total_expense': instance.totalExpense,
    };
