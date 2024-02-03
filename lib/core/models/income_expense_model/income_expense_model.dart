import 'package:json_annotation/json_annotation.dart';

part 'income_expense_model.g.dart';

List<IncomeExpense> getIncomeExpenseList(List<Map<String, dynamic>> json) =>
    json.map((e) => IncomeExpense.fromJson(e)).toList();

@JsonSerializable()
class IncomeExpense {
  late String category;
  late double amount;

  IncomeExpense({
    this.category = 'no category',
    this.amount = 0,
  });

  factory IncomeExpense.fromJson(Map<String, dynamic> json) =>
      _$IncomeExpenseFromJson(json);
}
