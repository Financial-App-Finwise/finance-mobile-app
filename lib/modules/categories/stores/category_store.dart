import 'package:dio/dio.dart';
import 'package:finwise/core/constants/loading_status_constant.dart';
import 'package:finwise/core/enums/loading_status_enum.dart';
import 'package:finwise/core/services/api_service.dart';
import 'package:finwise/modules/categories/models/categories_model.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

part 'category_store.g.dart';

class CategoryStore = _CategoryStoreBase with _$CategoryStore;

abstract class _CategoryStoreBase with Store {
  @observable
  CategoryModel categoryModel = CategoryModel(categoryDataList: []);

  @observable
  LoadingStatus status = LoadingStatus.none;

  @action
  Future read({defaultCat = false}) async {
    debugPrint('--> Start fetching category');
    status = LoadingStatus.loading;

    String url = 'categories';
    if (defaultCat) {
      url = 'default_categories';
    }

    try {
      Response response = await ApiService.dio.get(url);
      if (response.statusCode == 200) {
        categoryModel = await compute(
            getCategoryModel, response.data as Map<String, dynamic>);
        status = LoadingStatus.done;
      }
    } catch (e) {
      debugPrint('--> ${e.runtimeType}, ${e.toString()}');
    } finally {
      debugPrint('<-- End: fetching category');
    }
  }

  // Get onboarding categories
  @computed
  ObservableList<CategoryData> get onboardingCategory {
    return ObservableList.of(
      categoryModel.categoryDataList.where((e) => e.isIncome == false),
    );
  }

  @observable
  bool isIncome = false;

  @action
  void setIsIncome(bool filter) {
    isIncome = filter;
  }

  @computed
  ObservableList<CategoryData> get filterCategory {
    return ObservableList.of(
      categoryModel.categoryDataList.where((e) => e.isIncome == isIncome),
    );
  }

  @observable
  String searchText = '';

  @action
  void setSearchText(String query) {
    searchText = query;
  }

  @computed
  ObservableList<CategoryData> get searchCategory {
    if (searchText == '') {
      return ObservableList.of(filterCategory);
    }

    return ObservableList.of(filterCategory
        .where((e) => e.name.toLowerCase().contains(searchText.toLowerCase())));
  }

  @observable
  LoadingStatusEnum createStatus = LoadingStatusEnum.none;

  @action
  Future<bool> post(CategoryData categoryData) async {
    debugPrint('-->START: post, category');
    createStatus = LoadingStatusEnum.loading;
    bool success = false;
    try {
      Map<String, dynamic> jsonData;
      if (categoryData.id != 0) {
        jsonData = categoryData.toJson();
      } else {
        jsonData = {
          'name': categoryData.name,
          'isIncome': categoryData.isIncome
        };
      }
      Response response =
          await ApiService.dio.post('categories', data: jsonData);
      if (response.statusCode == 201) {
        success = true;
        createStatus = LoadingStatusEnum.done;
      } else {
        debugPrint('Something went wrong, code: ${response.statusCode}');
        success = false;
        createStatus = LoadingStatusEnum.error;
      }
    } catch (e) {
      debugPrint('--> ${e.runtimeType}, ${e.toString()}');
      createStatus = LoadingStatusEnum.error;
    } finally {
      debugPrint('<-- End: posting categories');
    }

    return success;
  }
}
