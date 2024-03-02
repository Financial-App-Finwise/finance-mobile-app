import 'package:finwise/modules/transaction/models/transaction_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'finance_model.g.dart';

Finance getFinanceModel(Map<String, dynamic> json) => Finance.fromJson(json);

@JsonSerializable()
class Finance {
  Finance({
    this.success = '',
    required this.data,
  });

  late final String success;
  late final FinanceData data;

  factory Finance.fromJson(Map<String, dynamic> json) =>
      _$FinanceFromJson(json);

  Map<String, dynamic> toJson() => _$FinanceToJson(this);
}

@JsonSerializable()
class FinanceData {
  FinanceData({
    required this.items,
    this.totalExpenses = 0,
    this.totalIncomes = 0,
    required this.topTransaction,
    required this.allTransaction,
    required this.total,
  });

  @JsonKey(name: 'finance')
  late final List<FinanceItem> items;

  @JsonKey(name: 'total_expenses')
  late final double totalExpenses;

  @JsonKey(name: 'total_incomes')
  late final double totalIncomes;

  @JsonKey(name: 'top_transaction')
  late final List<TopTransaction> topTransaction;

  @JsonKey(name: 'all_transaction')
  late final AllTransaction allTransaction;

  @JsonKey(name: 'totals', fromJson: _totalFromJson)
  late final dynamic total;

  factory FinanceData.fromJson(Map<String, dynamic> json) =>
      _$FinanceDataFromJson(json);

  Map<String, dynamic> toJson() => _$FinanceDataToJson(this);

  static dynamic _totalFromJson(dynamic json) {
    if (json.runtimeType.toString() == "_Map<String, dynamic>") {
      Map<String, dynamic> map = json;
      return map.map(
        (key, value) => MapEntry(
          key,
          IncomeExpenseCompare.fromJson(value),
        ),
      );
    }
    return [];
  }
}

@JsonSerializable()
class FinanceItem {
  FinanceItem({
    this.id = 0,
    this.userID = 0,
    this.totalbalance = 0,
    required this.currency,
  });

  late final int id;
  late final int userID;

  @JsonKey(fromJson: _stringToDouble)
  late final double totalbalance;
  late final Currency currency;

  factory FinanceItem.fromJson(Map<String, dynamic> json) =>
      _$FinanceItemFromJson(json);

  Map<String, dynamic> toJson() => _$FinanceItemToJson(this);

  static double _stringToDouble(String value) =>
      double.tryParse(value) == null ? 0 : double.parse(value);
}

@JsonSerializable()
class Currency {
  Currency({
    this.id = 0,
    this.code = '',
    this.name = '',
  });

  late final int id;
  late final String code;
  late final String name;

  factory Currency.fromJson(Map<String, dynamic> json) =>
      _$CurrencyFromJson(json);

  Map<String, dynamic> toJson() => _$CurrencyToJson(this);
}

@JsonSerializable()
class TopTransaction {
  TopTransaction({
    required this.note,
    required this.amount,
  });

  late final String note;
  late final int amount;

  factory TopTransaction.fromJson(Map<String, dynamic> json) =>
      _$TopTransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TopTransactionToJson(this);
}

@JsonSerializable()
class AllTransaction {
  AllTransaction({
    required this.today,
    required this.yesterday,
  });

  late final List<TransactionData> today;
  late final List<TransactionData> yesterday;

  factory AllTransaction.fromJson(Map<String, dynamic> json) =>
      _$AllTransactionFromJson(json);

  Map<String, dynamic> toJson() => _$AllTransactionToJson(this);
}

// @JsonSerializable()
// class Total {
//   Total({
//     required this.week1,
//     required this.week2,
//     required this.week3,
//     required this.week4,
//   });

//   @JsonKey(name: 'Week 1')
//   late final IncomeExpenseCompare week1;

//   @JsonKey(name: 'Week 2')
//   late final IncomeExpenseCompare week2;

//   @JsonKey(name: 'Week 3')
//   late final IncomeExpenseCompare week3;

//   @JsonKey(name: 'Week 4')
//   late final IncomeExpenseCompare week4;

//   factory Total.fromJson(Map<String, dynamic> json) => _$TotalFromJson(json);

//   Map<String, dynamic> toJson() => _$TotalToJson(this);
// }

@JsonSerializable()
class IncomeExpenseCompare {
  IncomeExpenseCompare({
    this.totalIncome = 0,
    this.totalExpense = 0,
  });

  @JsonKey(name: 'total_income')
  late final double totalIncome;

  @JsonKey(name: 'total_expense')
  late final double totalExpense;

  factory IncomeExpenseCompare.fromJson(Map<String, dynamic> json) =>
      _$IncomeExpenseCompareFromJson(json);

  Map<String, dynamic> toJson() => _$IncomeExpenseCompareToJson(this);
}
