// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prediction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Prediction _$PredictionFromJson(Map<String, dynamic> json) => Prediction(
      data: PredictionData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PredictionToJson(Prediction instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

PredictionData _$PredictionDataFromJson(Map<String, dynamic> json) =>
    PredictionData(
      id: json['id'] as int? ?? 0,
      userID: json['userID'] as int? ?? 0,
      predictedBudget: (json['predicted_budget'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$PredictionDataToJson(PredictionData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userID': instance.userID,
      'predicted_budget': instance.predictedBudget,
    };
