import 'package:finwise/modules/transaction/models/transaction_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'smart_goal_model.g.dart';

SmartGoal getSmartGoal(Map<String, dynamic> json) => SmartGoal.fromJson(json);

@JsonSerializable()
class SmartGoal {
  @JsonKey(name: 'data')
  late List<SmartGoalData> items;

  @JsonKey(includeToJson: false)
  SmartGoalMeta meta;

  @JsonKey(includeFromJson: false, includeToJson: false)
  late int currentPage;

  SmartGoal({
    required this.items,
    required this.meta,
    this.currentPage = 0,
  });

  factory SmartGoal.fromJson(Map<String, dynamic> json) =>
      _$SmartGoalFromJson(json);

  Map<String, dynamic> toJson() => _$SmartGoalToJson(this);
}

@JsonSerializable()
class SmartGoalData {
  @JsonKey(includeToJson: false)
  late int id;

  @JsonKey(includeToJson: false)
  late int userID;

  late String name;
  late double amount;
  late double currentSave;
  late double remainingSave;

  @JsonKey(fromJson: _intToBool)
  late bool setDate;

  String? startDate;
  String? endDate;

  double? monthlyContribution;

  @JsonKey(includeToJson: false)
  late int transactionCount;

// "transactions_count": 0,
  @JsonKey(name: 'transactions_count', includeToJson: false)
  late int transactionCountDetail;

  //       "transactions": [],
  @JsonKey(name: 'transactions', includeToJson: false)
  late List<Transaction> transactions;

  //       "contribution_amounts_last_6_months": [],
  @JsonKey(name: 'contribution_amounts_last_6_months', includeToJson: false)
  late List<dynamic> contributions;

  //       "average_total_contribution": 0,
  @JsonKey(name: 'average_total_contribution', includeToJson: false)
  late double averageContribution;

  //       "total_contribution_last_month": 0
  @JsonKey(name: 'total_contribution_last_month', includeToJson: false)
  late double totalContributionLastMonth;

  @JsonKey(name: 'created_at', includeToJson: false)
  late String createdAt;

  @JsonKey(name: 'updated_at', includeToJson: false)
  late String updatedAt;

  SmartGoalData({
    this.id = 0,
    this.userID = 0,
    this.name = 'no name',
    this.amount = 0.0,
    this.currentSave = 0.0,
    this.remainingSave = 0.0,
    this.setDate = false,
    this.startDate = 'no date',
    this.endDate = 'no date',
    this.monthlyContribution = 0.0,
    this.createdAt = 'no date',
    this.updatedAt = 'no date',
    this.transactionCount = 0,
  });

  factory SmartGoalData.fromJson(Map<String, dynamic> json) =>
      _$SmartGoalDataFromJson(json);

  Map<String, dynamic> toJson() => _$SmartGoalDataToJson(this);

  static double _stringToDouble(String value) => double.parse(value);

  static bool _intToBool(int value) => 1 == value;
}

@JsonSerializable()
class SmartGoalMeta {
  late int total;

  SmartGoalMeta({
    this.total = 0,
  });

  factory SmartGoalMeta.fromJson(Map<String, dynamic> json) =>
      _$SmartGoalMetaFromJson(json);
}

// to map:
// {
//     "userID": 2,
//     "name": "New Learning Course",
//     "amount": 150.00,
//     "currentSave": 50.00,
//     "remainingSave": 100.00,
//     "setDate": true,
//     "startDate": "2024-01-01",
//     "endDate": "2024-01-28",
//     "monthlyContribution": 20.00
// }

// {
//     "data": [
//         {
//             "id": 4,
//             "userID": 1,
//             "name": "New Room Decoration",
//             "amount": "150.00",
//             "currentSave": "50.00",
//             "remainingSave": "100.00",
//             "setDate": 1,
//             "startDate": "2024-01-01",
//             "endDate": "2024-02-01",
//             "monthlyContribution": null,
//             "created_at": "2024-01-31T01:47:34.000000Z",
//             "updated_at": "2024-01-31T01:47:34.000000Z"
//         },
//         {
//             "id": 5,
//             "userID": 1,
//             "name": "Vietnam Trip",
//             "amount": "500.00",
//             "currentSave": "50.00",
//             "remainingSave": "450.00",
//             "setDate": 1,
//             "startDate": "2024-05-01",
//             "endDate": "2024-08-31",
//             "monthlyContribution": null,
//             "created_at": "2024-01-31T01:47:34.000000Z",
//             "updated_at": "2024-01-31T01:47:34.000000Z"
//         },
//         {
//             "id": 6,
//             "userID": 1,
//             "name": "Car",
//             "amount": "25000.00",
//             "currentSave": "500.00",
//             "remainingSave": "24500.00",
//             "setDate": 1,
//             "startDate": "2024-01-01",
//             "endDate": "2030-05-01",
//             "monthlyContribution": null,
//             "created_at": "2024-01-31T01:47:34.000000Z",
//             "updated_at": "2024-01-31T01:47:34.000000Z"
//         }
//     ],
//     "links": {
//         "first": "http://finwise-api-test.up.railway.app/api/goals?page=1",
//         "last": "http://finwise-api-test.up.railway.app/api/goals?page=1",
//         "prev": null,
//         "next": null
//     },
//     "meta": {
//         "current_page": 1,
//         "from": 1,
//         "last_page": 1,
//         "links": [
//             {
//                 "url": null,
//                 "label": "&laquo; Previous",
//                 "active": false
//             },
//             {
//                 "url": "http://finwise-api-test.up.railway.app/api/goals?page=1",
//                 "label": "1",
//                 "active": true
//             },
//             {
//                 "url": null,
//                 "label": "Next &raquo;",
//                 "active": false
//             }
//         ],
//         "path": "http://finwise-api-test.up.railway.app/api/goals",
//         "per_page": 15,
//         "to": 3,
//         "total": 3
//     }
// }