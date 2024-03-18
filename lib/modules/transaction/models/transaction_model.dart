import 'package:finwise/modules/categories/models/categories_model.dart';
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

//  {
//             "id": 88,
//             "userID": 1,
//             "categoryID": 2,
//             "category": {
//                 "id": 2,
//                 "name": "Transportation",
//                 "isIncome": 0,
//                 "parentCategory": null
//             },
//             "isIncome": 0,
//             "amount": 20,
//             "hasContributed": 0,
//             "upcomingBill": {
//                 "id": 1,
//                 "categoryID": 2,
//                 "category": {
//                     "id": 2,
//                     "name": "Transportation",
//                     "isIncome": 0,
//                     "parentCategory": null
//                 },
//                 "amount": 20,
//                 "date": "2024-03-07T05:00:00.000000Z",
//                 "name": "Electricity",
//                 "note": "lorem ipsum",
//                 "status": "paid"
//             },
//             "budgetPlan": null,
//             "expenseType": "Upcoming Bill",
//             "date": "2024-03-17 18:13:20",
//             "note": null,
//             "transactionGoal": null
//         },
@JsonSerializable()
class TransactionData {
  @JsonKey(includeToJson: false)
  late int id;

  @JsonKey(includeToJson: false)
  late int userID;

  late int categoryID;

  @JsonKey(name: 'category', includeToJson: false)
  late CategoryData? categoryData;

  @JsonKey(fromJson: _intToBool, toJson: _boolToInt)
  late bool isIncome;

  @JsonKey(fromJson: _stringToDouble)
  late double amount;

  @JsonKey(fromJson: _intToBool, toJson: _boolToInt)
  late bool hasContributed;

  late int? upcomingbillID;
  late int? budgetplanID;
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
    this.categoryData,
    this.isIncome = true,
    this.amount = 0,
    this.hasContributed = false,
    this.upcomingbillID,
    this.budgetplanID,
    this.expenseType = '',
    this.date = '',
    this.note = '',
    this.createdAt = '',
    this.updatedAt = '',
  });

  factory TransactionData.fromJson(Map<String, dynamic> json) =>
      _$TransactionDataFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionDataToJson(this);

  static double _stringToDouble(dynamic value) =>
      double.parse(value.toString());

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
