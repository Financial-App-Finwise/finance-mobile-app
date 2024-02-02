import "package:json_annotation/json_annotation.dart";

part 'categories_model.g.dart';

CategoryModel getCategoryModel(Map<String, dynamic> json) =>
    CategoryModel.fromJson(json);

@JsonSerializable()
class CategoryModel {
  @JsonKey(name: 'data')
  late List<CategoryData> categoryDataList;

  CategoryModel({
    required this.categoryDataList,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}

@JsonSerializable()
class CategoryData {
  late int id;
  late int userID;
  late String name;

  @JsonKey(fromJson: _intToBool)
  late bool isIncome;
  late int parentID;
  late int level;

  @JsonKey(fromJson: _intToBool)
  late bool isOnboarding;

  @JsonKey(name: "created_at")
  late String createdAt;

  @JsonKey(name: "updated_at")
  late String updatedAt;

  CategoryData({
    this.id = 0,
    this.userID = 0,
    this.name = 'no name',
    this.isIncome = false,
    this.parentID = 0,
    this.level = 0,
    this.isOnboarding = false,
    this.createdAt = "no date",
    this.updatedAt = "no date",
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) =>
      _$CategoryDataFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryDataToJson(this);

  static bool _intToBool(int value) => 1 == value;
}


            // "id": 1,
            // "userID": 1,
            // "name": "Food and Beverage",
            // "isIncome": 0,
            // "parentID": null,
            // "level": 2,
            // "isOnboarding": 0,
            // "created_at": "2024-01-31T04:29:50.000000Z",
            // "updated_at": "2024-01-31T04:29:50.000000Z"