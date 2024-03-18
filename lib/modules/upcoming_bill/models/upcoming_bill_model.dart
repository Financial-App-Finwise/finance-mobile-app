import 'package:finwise/modules/budget_plan/widgets/budget_plan_detail/this_month_content.dart';
import 'package:json_annotation/json_annotation.dart';

part 'upcoming_bill_model.g.dart';

UpcomingBill getUpcomingBill(Map<String, dynamic> json) {
  return UpcomingBill.fromJson(json);
}

@JsonSerializable()
class UpcomingBill {
  @JsonKey(name: 'totalUpcomingBills')
  late int totalUpcomingBills;

  @JsonKey(name: 'upcomingBills')
  late List<UpcomingBillData> data;

  late TotalData totals;

  late LinkData links;

  UpcomingBill({
    this.totalUpcomingBills = 0,
    required this.data,
    required this.totals,
    required this.links,
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

  // @JsonKey(fromJson: _stringToDouble)
  late int amount;
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
    this.amount = 0,
    this.date = 'no date',
    this.name = 'no name',
    this.note = "You don't have any note.",
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
class TotalData {
  late int thisMonth;
  late int nextMonth;
  late int next6Months;
  late int thisYear;
  late int nextYear;

  TotalData({
    this.thisMonth = 0,
    this.nextMonth = 0,
    this.next6Months = 0,
    this.thisYear = 0,
    this.nextYear = 0,
  });

  factory TotalData.fromJson(Map<String, dynamic> json) =>
      _$TotalDataFromJson(json);

  Map<String, dynamic> toJson() => _$TotalDataToJson(this);
}

@JsonSerializable()
class LinkData {
  late String prev;
  late String next;

  LinkData({
    this.prev = 'no link',
    this.next = 'no link',
  });

  factory LinkData.fromJson(Map<String, dynamic> json) =>
      _$LinkDataFromJson(json);

  Map<String, dynamic> toJson() => _$LinkDataToJson(this);
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