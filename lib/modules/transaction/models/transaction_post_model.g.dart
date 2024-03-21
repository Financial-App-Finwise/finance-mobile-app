// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionPost _$TransactionPostFromJson(Map<String, dynamic> json) =>
    TransactionPost(
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      date: json['date'] as String? ?? '',
      note: json['note'] as String? ?? '',
    );

Map<String, dynamic> _$TransactionPostToJson(TransactionPost instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'date': instance.date,
      'note': instance.note,
    };

TransactionPostExpense _$TransactionPostExpenseFromJson(
        Map<String, dynamic> json) =>
    TransactionPostExpense(
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      note: json['note'] as String? ?? '',
      date: json['date'] as String? ?? '',
      categoryID: json['categoryID'] as int? ?? 0,
    );

Map<String, dynamic> _$TransactionPostExpenseToJson(
        TransactionPostExpense instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'date': instance.date,
      'note': instance.note,
      'categoryID': instance.categoryID,
    };

TransactionPostExpenseBudgetPlan _$TransactionPostExpenseBudgetPlanFromJson(
        Map<String, dynamic> json) =>
    TransactionPostExpenseBudgetPlan(
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      note: json['note'] as String? ?? '',
      date: json['date'] as String? ?? '',
      budgetplanID: json['budgetplanID'] as int? ?? 0,
    );

Map<String, dynamic> _$TransactionPostExpenseBudgetPlanToJson(
        TransactionPostExpenseBudgetPlan instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'date': instance.date,
      'note': instance.note,
      'budgetplanID': instance.budgetplanID,
    };

TransactionPostExpenseUpcomingBill _$TransactionPostExpenseUpcomingBillFromJson(
        Map<String, dynamic> json) =>
    TransactionPostExpenseUpcomingBill(
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      note: json['note'] as String? ?? '',
      date: json['date'] as String? ?? '',
      upcomingbillID: json['upcomingbillID'] as int? ?? 0,
    );

Map<String, dynamic> _$TransactionPostExpenseUpcomingBillToJson(
        TransactionPostExpenseUpcomingBill instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'date': instance.date,
      'note': instance.note,
      'upcomingbillID': instance.upcomingbillID,
    };

TransactionPostIncome _$TransactionPostIncomeFromJson(
        Map<String, dynamic> json) =>
    TransactionPostIncome(
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      note: json['note'] as String? ?? '',
      date: json['date'] as String? ?? '',
      categoryID: json['categoryID'] as int? ?? 0,
    );

Map<String, dynamic> _$TransactionPostIncomeToJson(
        TransactionPostIncome instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'date': instance.date,
      'note': instance.note,
      'categoryID': instance.categoryID,
    };

TransactionPostGoalContribution _$TransactionPostGoalContributionFromJson(
        Map<String, dynamic> json) =>
    TransactionPostGoalContribution(
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      note: json['note'] as String? ?? '',
      date: json['date'] as String? ?? '',
      categoryID: json['categoryID'] as int? ?? 0,
      goalID: json['goalID'] as int? ?? 0,
      contributionAmount:
          (json['contributionAmount'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$TransactionPostGoalContributionToJson(
        TransactionPostGoalContribution instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'date': instance.date,
      'note': instance.note,
      'categoryID': instance.categoryID,
      'goalID': instance.goalID,
      'contributionAmount': instance.contributionAmount,
    };
