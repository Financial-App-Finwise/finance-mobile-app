import 'package:json_annotation/json_annotation.dart';
part 'transaction_post_model.g.dart';

// -------------------- General Class for Posting Transaction --------------------
@JsonSerializable()
class TransactionPost {
  late double amount;
  late String date;
  late String note;

  TransactionPost({
    this.amount = 0.0,
    this.date = '',
    this.note = '',
  });

  TransactionPostExpense toExpense(TransactionPostExpense expense) =>
      TransactionPostExpense(
        amount: amount,
        note: note,
        date: date,
        categoryID: expense.categoryID,
      );

  TransactionPostExpenseBudgetPlan toExpenseBudgetPlan(
          TransactionPostExpenseBudgetPlan budgetPlan) =>
      TransactionPostExpenseBudgetPlan(
          amount: amount,
          note: note,
          date: date,
          budgetplanID: budgetPlan.budgetplanID);

  TransactionPostExpenseUpcomingBill toExpenseUpcomingBill(
          TransactionPostExpenseUpcomingBill upcomingBill) =>
      TransactionPostExpenseUpcomingBill(
        amount: amount,
        note: note,
        date: date,
        upcomingbillID: upcomingBill.upcomingbillID,
      );

  TransactionPostIncome toIncome(TransactionPostIncome income) =>
      TransactionPostIncome(
        amount: amount,
        note: note,
        date: date,
        categoryID: income.categoryID,
      );

  Map<String, dynamic> toJson() => _$TransactionPostToJson(this);
}

// -------------------- Expense General --------------------
@JsonSerializable()
class TransactionPostExpense extends TransactionPost {
  late int categoryID;

  TransactionPostExpense({
    super.amount,
    super.note,
    super.date,
    this.categoryID = 0,
  });

  @override
  Map<String, dynamic> toJson() => _$TransactionPostExpenseToJson(this);
}

// -------------------- Expense Budget Plan --------------------
@JsonSerializable()
class TransactionPostExpenseBudgetPlan extends TransactionPost {
  late int budgetplanID;

  TransactionPostExpenseBudgetPlan({
    super.amount,
    super.note,
    super.date,
    this.budgetplanID = 0,
  });

  // factory TransactionPostExpenseBudgetPlan.fromParent(
  //         TransactionPost transactionPost) =>
  //     TransactionPostExpenseBudgetPlan(amount: transactionPost.amount);

  @override
  Map<String, dynamic> toJson() =>
      _$TransactionPostExpenseBudgetPlanToJson(this);
}

// -------------------- Expense Upcoming Bill --------------------
@JsonSerializable()
class TransactionPostExpenseUpcomingBill extends TransactionPost {
  late int upcomingbillID;

  TransactionPostExpenseUpcomingBill({
    super.amount = 0.0,
    super.note = '',
    super.date = '',
    this.upcomingbillID = 0,
  });

  @override
  Map<String, dynamic> toJson() =>
      _$TransactionPostExpenseUpcomingBillToJson(this);
}

// -------------------- Income --------------------
@JsonSerializable()
class TransactionPostIncome extends TransactionPost {
  late int categoryID;

  TransactionPostIncome({
    super.amount = 0.0,
    super.note = '',
    super.date = '',
    this.categoryID = 0,
  });

  TransactionPostGoalContribution toContribution(
          TransactionPostGoalContribution goalContribution) =>
      TransactionPostGoalContribution(
        amount: amount,
        note: note,
        date: date,
        categoryID: categoryID,
        contributions: goalContribution.contributions,
      );

  @override
  Map<String, dynamic> toJson() => _$TransactionPostIncomeToJson(this);
}

// -------------------- Income and Contribution --------------------
// "categoryID": 5,
//     "amount": 300,
//     "date": "2024-02-12 08:00:00",
//     "note": "Test GoalID 19",
//     "contributions": [
//         {"goalID": 20, "contributionAmount": 150 },
//         {"goalID": 21, "contributionAmount": 150 }
//     ]
@JsonSerializable()
class TransactionPostGoalContribution extends TransactionPostIncome {
  late List<GoalContribution> contributions;

  TransactionPostGoalContribution({
    super.amount = 0.0,
    super.note = '',
    super.date = '',
    super.categoryID,
    required this.contributions,
  });

  @override
  Map<String, dynamic> toJson() =>
      _$TransactionPostGoalContributionToJson(this);
}

@JsonSerializable()
class GoalContribution {
  late int goalID;
  late double contributionAmount;

  GoalContribution({
    this.goalID = 0,
    this.contributionAmount = 0,
  });

  Map<String, dynamic> toJson() => _$GoalContributionToJson(this);

  factory GoalContribution.fromJson(Map<String, dynamic> json) => _$GoalContributionFromJson(json);
}

abstract class ExpenseTypeJsonKey {
  static const category = 'categoryID';
  static const upcomingBill = 'upcomingbillID';
  static const budgetPlan = 'budgetplanID';
}
