import 'package:finwise/modules/transaction/models/transaction_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'smart_goal_detail_model.g.dart';

SmartGoalDetailModel getSmartGoalDetailModel(Map<String, dynamic> json) =>
    SmartGoalDetailModel.fromJson(json);

@JsonSerializable()
class SmartGoalDetailModel {
  @JsonKey(name: 'data')
  late SmartGoalDetail smartGoalDetail;

  SmartGoalDetailModel({required this.smartGoalDetail});

  factory SmartGoalDetailModel.fromJson(Map<String, dynamic> json) =>
      _$SmartGoalDetailModelFromJson(json);
}

@JsonSerializable()
class SmartGoalDetail {
  SmartGoalDetail({
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
    required this.transactions,
    required this.contributions,
    this.averageContribution = 0,
    this.totalContributionLastMonth = 0,
  });

  @JsonKey(includeToJson: false)
  late int id;

  @JsonKey(includeToJson: false)
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

  String? startDate;
  String? endDate;

  @JsonKey(fromJson: _stringToDouble)
  late double monthlyContribution;

  @JsonKey(name: 'created_at', includeToJson: false)
  late String createdAt;

  @JsonKey(name: 'updated_at', includeToJson: false)
  late String updatedAt;

  // "transactions_count": 0,
  @JsonKey(name: 'transactions_count', includeToJson: false)
  late int transactionCount;

  // "transactions": [],
  @JsonKey(name: 'transactions', includeToJson: false, fromJson: _toMap)
  late Map<String, dynamic> transactions;

  // "contribution_amounts_last_6_months": [],
  @JsonKey(name: 'contribution_amounts_last_6_months', includeToJson: false)
  late List<dynamic> contributions;

  //       "average_total_contribution": 0,
  @JsonKey(
    name: 'average_total_contribution',
    includeToJson: false,
    fromJson: _stringToDouble,
  )
  late double averageContribution;

  //       "total_contribution_last_month": 0
  @JsonKey(
    name: 'total_contribution_last_month',
    includeToJson: false,
    fromJson: _stringToDouble,
  )
  late double totalContributionLastMonth;

  factory SmartGoalDetail.fromJson(Map<String, dynamic> json) =>
      _$SmartGoalDetailFromJson(json);

  static bool _intToBool(int value) => 1 == value;

  static double _stringToDouble(dynamic value) =>
      double.parse(value.toString());

  static Map<String, dynamic> _toMap(dynamic value) {
    if (value.runtimeType == [].runtimeType) {
      return <String, dynamic>{};
    }
    return value;
  }
}

@JsonSerializable()
class ContributionItem {
  // {
  //               "year": 2024,
  //               "month": "February",
  //               "totalContribution": "10.00",
  //               "laravel_through_key": 31
  //           }
}
