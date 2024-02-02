import 'package:dio/dio.dart';
import 'package:finwise/core/services/api_service.dart';
import 'package:finwise/modules/categories/models/categories_model.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

part 'category_store.g.dart';

class CategoryStore = _CategoryStoreBase with _$CategoryStore;

abstract class _CategoryStoreBase with Store {
  @observable
  CategoryModel categoryModel = CategoryModel(categoryDataList: []);

  @action
  Future read() async {
    debugPrint('--> Start fetching category');
    try {
      Response response = await ApiService.dio.get('categories');
      if (response.statusCode == 200) {
        categoryModel = await compute(
            getCategoryModel, response.data as Map<String, dynamic>);
      }
    } catch (e) {
      debugPrint('--> ${e.runtimeType}, ${e.toString()}');
    } finally {
      debugPrint('<-- End: fetching category');
    }
  }
}
