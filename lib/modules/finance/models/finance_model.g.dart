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
      topTransaction: (json['top_transaction'] as List<dynamic>)
          .map((e) => TopTransaction.fromJson(e as Map<String, dynamic>))
          .toList(),
      allTransaction: AllTransaction.fromJson(
          json['all_transaction'] as Map<String, dynamic>),
      total: Total.fromJson(json['totals'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FinanceDataToJson(FinanceData instance) =>
    <String, dynamic>{
      'finance': instance.items,
      'total_expenses': instance.totalExpenses,
      'total_incomes': instance.totalIncomes,
      'top_transaction': instance.topTransaction,
      'all_transaction': instance.allTransaction,
      'totals': instance.total,
    };

FinanceItem _$FinanceItemFromJson(Map<String, dynamic> json) => FinanceItem(
      id: json['id'] as int? ?? 0,
      userID: json['userID'] as int? ?? 0,
      totalbalance: json['totalbalance'] as String? ?? '',
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

Total _$TotalFromJson(Map<String, dynamic> json) => Total(
      week1: Week.fromJson(json['Week 1'] as Map<String, dynamic>),
      week2: Week.fromJson(json['Week 2'] as Map<String, dynamic>),
      week3: Week.fromJson(json['Week 3'] as Map<String, dynamic>),
      week4: Week.fromJson(json['Week 4'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TotalToJson(Total instance) => <String, dynamic>{
      'Week 1': instance.week1,
      'Week 2': instance.week2,
      'Week 3': instance.week3,
      'Week 4': instance.week4,
    };

Week _$WeekFromJson(Map<String, dynamic> json) => Week(
      totalIncome: (json['total_income'] as num?)?.toDouble() ?? 0,
      totalExpense: (json['total_expense'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$WeekToJson(Week instance) => <String, dynamic>{
      'total_income': instance.totalIncome,
      'total_expense': instance.totalExpense,
    };
