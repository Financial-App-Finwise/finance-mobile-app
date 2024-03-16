import 'package:json_annotation/json_annotation.dart';

part 'prediction_model.g.dart';

Prediction getPrediction(Map<String, dynamic> json) {
  return Prediction.fromJson(json);
}

@JsonSerializable()
class Prediction {
  late PredictionData data;

  Prediction({required this.data});

  factory Prediction.fromJson(Map<String, dynamic> json) =>
      _$PredictionFromJson(json);
}

@JsonSerializable()
class PredictionData {
  late int id;
  late int userID;
  @JsonKey(name: 'predicted_budget')
  late String predictedBudget;

  PredictionData({
    this.id = 0,
    this.userID = 0,
    this.predictedBudget = '0',
  });

  factory PredictionData.fromJson(Map<String, dynamic> json) =>
      _$PredictionDataFromJson(json);
}
