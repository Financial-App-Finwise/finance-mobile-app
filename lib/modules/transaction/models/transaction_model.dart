import 'package:json_annotation/json_annotation.dart';

part 'transaction_model.g.dart';

@JsonSerializable()
class TransactionData {
  // late int userID;
  // late int categoryID;
  late bool isIncome;
  late bool hasContributed;
  late double amount;

  late String date;

  TransactionData({
    this.isIncome = true,
    this.hasContributed = false,
    this.amount = 0,
    this.date = 'no data',
  });

  factory TransactionData.fromJson(Map<String, dynamic> json) => _$TransactionDataFromJson(json);
}
