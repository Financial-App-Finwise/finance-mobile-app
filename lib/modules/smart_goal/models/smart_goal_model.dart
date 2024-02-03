import 'package:json_annotation/json_annotation.dart';

part 'smart_goal_model.g.dart';

SmartGoal getSmartGoal(Map<String, dynamic> json) => SmartGoal.fromJson(json);

@JsonSerializable()
class SmartGoal {
  late List<SmartGoalData> data;

  SmartGoal({required this.data});

  factory SmartGoal.fromJson(Map<String, dynamic> json) =>
      _$SmartGoalFromJson(json);

  Map<String, dynamic> toJson() => _$SmartGoalToJson(this);
}

@JsonSerializable()
class SmartGoalData {
  late int id;
  late int userID;
  late String name;

  @JsonKey(fromJson: _stringToDouble)
  late double amount;

  @JsonKey(fromJson: _stringToDouble)
  late double currentSave;

  @JsonKey(fromJson: _stringToDouble)
  late double remainingSave;

  @JsonKey(fromJson: _intToBool)
  late bool setDate;

  late String startDate;
  late String endDate;

  @JsonKey(fromJson: _stringToDouble)
  late double monthlyContribution;

  @JsonKey(name: 'created_at')
  late String createdAt;
  
  @JsonKey(name: 'updated_at')
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
  });

  factory SmartGoalData.fromJson(Map<String, dynamic> json) =>
      _$SmartGoalDataFromJson(json);

  Map<String, dynamic> toJson() => _$SmartGoalDataToJson(this);

  static double _stringToDouble(String value) => double.parse(value);

  static bool _intToBool(int value) => 1 == value;
}

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