import 'package:json_annotation/json_annotation.dart';

part 'upcoming_bill_yearly_model.g.dart';

Map<String, UpcomingBillMonth> getUpcomingBillYearly(
    Map<String, dynamic> json) {
  return json
      .map((key, value) => MapEntry(key, UpcomingBillMonth.fromJson(value)));
}

@JsonSerializable()
class UpcomingBillMonth {
  @JsonKey(name: 'Number of upcomingbills', includeToJson: false)
  late int numberOfGoals;

  UpcomingBillMonth({
    this.numberOfGoals = 0,
  });

  factory UpcomingBillMonth.fromJson(Map<String, dynamic> json) =>
      _$UpcomingBillMonthFromJson(json);
}
