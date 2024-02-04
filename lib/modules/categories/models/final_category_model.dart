import 'package:finwise/modules/categories/models/categories_model.dart';

class FinalCategoryData {
  int id;
  int userID;
  String name;
  bool isIncome;
  int parentID;
  int level;
  bool isOnboarding;
  String createdAt;
  String updatedAt;
  List<CategoryData> subcategory;

  FinalCategoryData({
    this.id = 0,
    this.userID = 0,
    this.name = 'no name',
    this.isIncome = false,
    this.parentID = 0,
    this.level = 0,
    this.isOnboarding = false,
    this.createdAt = "no date",
    this.updatedAt = "no date",
    this.subcategory = const [],
  });
}
