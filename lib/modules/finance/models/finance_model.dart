import 'package:json_annotation/json_annotation.dart';

part 'finance_model.g.dart';

Finance getFinanceModel(Map<String, dynamic> json) => Finance.fromJson(json);

@JsonSerializable()
class Finance {
  @JsonKey(name: 'data')
  late List<FinanceData> items;

  Finance({
    required this.items,
  });

  factory Finance.fromJson(Map<String, dynamic> json) => _$FinanceFromJson(json);
}

@JsonSerializable()
class FinanceData {
  late int id;
  late int userID;

  @JsonKey(fromJson: _stringToDouble)
  late double totalbalance;
  
  late Currency currency;

  @JsonKey(name: 'created_at')
  late String createdAt;

  @JsonKey(name: 'updated_at')
  late String updatedAt;

  FinanceData({
    this.id = 0,
    this.userID = 0,
    this.totalbalance = 0,
    required this.currency,
    this.createdAt = '',
    this.updatedAt = '',
  });

  factory FinanceData.fromJson(Map<String, dynamic> json) =>
      _$FinanceDataFromJson(json);

  static double _stringToDouble(String value) => double.parse(value);
}

@JsonSerializable()
class Currency {
  late int id;
  late String code;
  late String name;

  @JsonKey(name: 'created_at')
  late String createdAt;

  @JsonKey(name: 'updated_at')
  late String updatedAt;

  Currency({
    this.id = 0,
    this.code = '',
    this.name = '',
    this.createdAt = '',
    this.updatedAt = '',
  });

  factory Currency.fromJson(Map<String, dynamic> json) =>
      _$CurrencyFromJson(json);
}