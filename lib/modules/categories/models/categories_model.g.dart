// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      categoryDataList: (json['data'] as List<dynamic>)
          .map((e) => CategoryData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'data': instance.categoryDataList,
    };

CategoryData _$CategoryDataFromJson(Map<String, dynamic> json) => CategoryData(
      id: json['id'] as int? ?? 0,
      userID: json['userID'] as int? ?? 0,
      name: json['name'] as String? ?? 'no name',
      isIncome: json['isIncome'] == null
          ? false
          : CategoryData._intToBool(json['isIncome'] as int),
      parentID: json['parentID'] as int? ?? 0,
      level: json['level'] as int? ?? 0,
      isOnboarding: json['isOnboarding'] == null
          ? false
          : CategoryData._intToBool(json['isOnboarding'] as int),
      createdAt: json['created_at'] as String? ?? "no date",
      updatedAt: json['updated_at'] as String? ?? "no date",
    );

Map<String, dynamic> _$CategoryDataToJson(CategoryData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userID': instance.userID,
      'name': instance.name,
      'isIncome': instance.isIncome,
      'parentID': instance.parentID,
      'level': instance.level,
      'isOnboarding': instance.isOnboarding,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
