import 'package:json_annotation/json_annotation.dart';

part 'upcoming_bill_model.g.dart';

UpcomingBill getUpcomingBill(Map<String, dynamic> json) {
  return UpcomingBill.fromJson(json);
}

@JsonSerializable()
class UpcomingBill {
  late List<UpcomingBillData> data;
  late UpcomingBillMeta meta;

  UpcomingBill({
    required this.data,
    required this.meta,
  });

  factory UpcomingBill.fromJson(Map<String, dynamic> json) =>
      _$UpcomingBillFromJson(json);

  Map<String, dynamic> toJson() => _$UpcomingBillToJson(this);
}

@JsonSerializable()
class UpcomingBillData {
  @JsonKey(includeToJson: false)
  late int id;
  late int userID;
  late int categoryID;

  @JsonKey(fromJson: _stringToDouble)
  late double amount;
  late String date;
  late String name;
  late String note;
  late String status;

  @JsonKey(name: 'created_at', includeToJson: false)
  late String createdAt;

  @JsonKey(name: 'updated_at', includeToJson: false)
  late String updatedAt;

  UpcomingBillData({
    this.id = 0,
    this.userID = 0,
    this.categoryID = 0,
    this.amount = 0.0,
    this.date = 'no date',
    this.name = 'no name',
    this.note = 'no note',
    this.status = 'no status',
    this.createdAt = 'no date',
    this.updatedAt = 'no date',
  });

  factory UpcomingBillData.fromJson(Map<String, dynamic> json) =>
      _$UpcomingBillDataFromJson(json);

  Map<String, dynamic> toJson() => _$UpcomingBillDataToJson(this);

  static double _stringToDouble(String value) => double.parse(value);
}

@JsonSerializable()
class UpcomingBillMeta {
  @JsonKey(name: 'current_page')
  late int currentPage;
  late int total;

  @JsonKey(name: 'per_page')
  late int perPage;

  UpcomingBillMeta({
    this.currentPage = 0,
    this.total = 0,
    this.perPage = 0,
  });

  factory UpcomingBillMeta.fromJson(Map<String, dynamic> json) =>
      _$UpcomingBillMetaFromJson(json);

  Map<String, dynamic> toJson() => _$UpcomingBillMetaToJson(this);
}

// {
//     "id": 1,
//     "userID": 1,
//     "categoryID": 15,
//     "amount": "100.00",
//     "date": "2024-02-01 12:00:00",
//     "name": "Electricity Bill",
//     "note": "Monthly electricity bill",
//     "created_at": "2024-02-04T08:42:40.000000Z",
//     "updated_at": "2024-02-04T08:42:40.000000Z"
// },