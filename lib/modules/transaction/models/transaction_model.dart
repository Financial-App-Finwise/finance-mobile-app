import 'package:json_annotation/json_annotation.dart';

part 'transaction_model.g.dart';

Transaction getTransactionModel(Map<String, dynamic> json) =>
    Transaction.fromJson(json);

@JsonSerializable()
class Transaction {
  @JsonKey(name: 'data')
  late List<TransactionData> items;

  late TransactionMeta meta;

  @JsonKey(includeFromJson: false, includeToJson: false)
  late String queryParemeter;

  @JsonKey(includeFromJson: false, includeToJson: false)
  late int currentPage;

  Transaction({
    required this.items,
    required this.meta,
    this.queryParemeter = '',
    this.currentPage = 0,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}

@JsonSerializable()
class TransactionData {
  @JsonKey(includeToJson: false)
  late int id;

  @JsonKey(includeToJson: false)
  late int userID;

  late int categoryID;

  @JsonKey(fromJson: _intToBool, toJson: _boolToInt)
  late bool isIncome;

  @JsonKey(fromJson: _stringToDouble)
  late double amount;

  @JsonKey(fromJson: _intToBool, includeToJson: false)
  late bool hasContributed;

  // late int upcomingbillID;
  // late int budgetplanID;
  late String expenseType;
  late String date;
  late String note;

  @JsonKey(name: 'created_at', includeToJson: false)
  late String createdAt;

  @JsonKey(name: 'updated_at', includeToJson: false)
  late String updatedAt;

  TransactionData({
    this.id = 0,
    this.userID = 0,
    this.categoryID = 0,
    this.isIncome = true,
    this.amount = 0,
    this.hasContributed = false,
    this.expenseType = '',
    this.date = '',
    this.note = '',
    this.createdAt = '',
    this.updatedAt = '',
  });

  factory TransactionData.fromJson(Map<String, dynamic> json) =>
      _$TransactionDataFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionDataToJson(this);

  static double _stringToDouble(String value) => double.parse(value);

  static bool _intToBool(int value) => value == 1;

  static int _boolToInt(bool value) => value ? 1 : 0;
}

@JsonSerializable()
class TransactionLink {}

@JsonSerializable()
class TransactionMeta {
  late int total;

  TransactionMeta({
    this.total = 0,
  });

  factory TransactionMeta.fromJson(Map<String, dynamic> json) =>
      _$TransactionMetaFromJson(json);
}
