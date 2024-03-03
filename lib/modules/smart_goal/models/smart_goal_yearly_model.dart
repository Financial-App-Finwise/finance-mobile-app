import 'package:json_annotation/json_annotation.dart';

part 'smart_goal_yearly_model.g.dart';

Map<String, SmartGoalMonth> getSmartGoalMap(Map<String, dynamic> json) {
  return json
      .map((key, value) => MapEntry(key, SmartGoalMonth.fromJson(value)));
}

@JsonSerializable()
class SmartGoalMonth {
  @JsonKey(name: 'Number of goals', includeToJson: false)
  late int numberOfGoals;

  SmartGoalMonth({
    this.numberOfGoals = 0,
  });

  factory SmartGoalMonth.fromJson(Map<String, dynamic> json) =>
      _$SmartGoalMonthFromJson(json);
}
