class BudgetCardModel {
  final String title;
  final int transaction;
  final int remain;
  final int spent;
  final int total;

  const BudgetCardModel({
    required this.title,
    required this.transaction,
    required this.remain,
    required this.spent,
    required this.total,
  });
}
