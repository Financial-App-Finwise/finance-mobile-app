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
      totalExpense: (json['total_expenses'] as num?)?.toDouble() ?? 0,
      totalIncome: (json['total_incomes'] as num?)?.toDouble() ?? 0,
      filteredExpense: (json['filtered_expenses'] as num?)?.toDouble() ?? 0,
      filteredIncome: (json['filtered_incomes'] as num?)?.toDouble() ?? 0,
      topCategories: (json['top_transactions'] as List<dynamic>)
          .map((e) => TopCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
      allTransactions: AllTransaction.fromJson(
          json['all_transactions'] as Map<String, dynamic>),
      total: FinanceData._totalFromJson(json['totals']),
    );

Map<String, dynamic> _$FinanceDataToJson(FinanceData instance) =>
    <String, dynamic>{
      'finance': instance.items,
      'filtered_expenses': instance.filteredExpense,
      'filtered_incomes': instance.filteredIncome,
      'total_expenses': instance.totalExpense,
      'total_incomes': instance.totalIncome,
      'top_transactions': instance.topCategories,
      'all_transactions': instance.allTransactions,
      'totals': instance.total,
    };

FinanceItem _$FinanceItemFromJson(Map<String, dynamic> json) => FinanceItem(
      id: json['id'] as int? ?? 0,
      userID: json['userID'] as int? ?? 0,
      totalbalance: (json['totalbalance'] as num?)?.toDouble() ?? 0,
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

TopCategory _$TopCategoryFromJson(Map<String, dynamic> json) => TopCategory(
      category: CategoryData.fromJson(json['category'] as Map<String, dynamic>),
      amount: (json['amount'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$TopCategoryToJson(TopCategory instance) =>
    <String, dynamic>{
      'category': instance.category,
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
