import 'package:dio/dio.dart';
import 'package:finwise/core/constants/loading_status_constant.dart';
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
  Future read() async {
    debugPrint('--> Start fetching category');
    status = LoadingStatus.loading;
    debugPrint('$status');
    try {
      Response response = await ApiService.dio.get('categories');
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
}
