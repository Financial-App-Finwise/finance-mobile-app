// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CategoryStore on _CategoryStoreBase, Store {
  Computed<ObservableList<CategoryData>>? _$onboardingCategoryComputed;

  @override
  ObservableList<CategoryData> get onboardingCategory =>
      (_$onboardingCategoryComputed ??= Computed<ObservableList<CategoryData>>(
              () => super.onboardingCategory,
              name: '_CategoryStoreBase.onboardingCategory'))
          .value;
  Computed<ObservableList<CategoryData>>? _$filterCategoryComputed;

  @override
  ObservableList<CategoryData> get filterCategory =>
      (_$filterCategoryComputed ??= Computed<ObservableList<CategoryData>>(
              () => super.filterCategory,
              name: '_CategoryStoreBase.filterCategory'))
          .value;
  Computed<ObservableList<CategoryData>>? _$searchCategoryComputed;

  @override
  ObservableList<CategoryData> get searchCategory =>
      (_$searchCategoryComputed ??= Computed<ObservableList<CategoryData>>(
              () => super.searchCategory,
              name: '_CategoryStoreBase.searchCategory'))
          .value;

  late final _$categoryModelAtom =
      Atom(name: '_CategoryStoreBase.categoryModel', context: context);

  @override
  CategoryModel get categoryModel {
    _$categoryModelAtom.reportRead();
    return super.categoryModel;
  }

  @override
  set categoryModel(CategoryModel value) {
    _$categoryModelAtom.reportWrite(value, super.categoryModel, () {
      super.categoryModel = value;
    });
  }

  late final _$statusAtom =
      Atom(name: '_CategoryStoreBase.status', context: context);

  @override
  LoadingStatus get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(LoadingStatus value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  late final _$isIncomeAtom =
      Atom(name: '_CategoryStoreBase.isIncome', context: context);

  @override
  bool get isIncome {
    _$isIncomeAtom.reportRead();
    return super.isIncome;
  }

  @override
  set isIncome(bool value) {
    _$isIncomeAtom.reportWrite(value, super.isIncome, () {
      super.isIncome = value;
    });
  }

  late final _$searchTextAtom =
      Atom(name: '_CategoryStoreBase.searchText', context: context);

  @override
  String get searchText {
    _$searchTextAtom.reportRead();
    return super.searchText;
  }

  @override
  set searchText(String value) {
    _$searchTextAtom.reportWrite(value, super.searchText, () {
      super.searchText = value;
    });
  }

  late final _$createStatusAtom =
      Atom(name: '_CategoryStoreBase.createStatus', context: context);

  @override
  LoadingStatusEnum get createStatus {
    _$createStatusAtom.reportRead();
    return super.createStatus;
  }

  @override
  set createStatus(LoadingStatusEnum value) {
    _$createStatusAtom.reportWrite(value, super.createStatus, () {
      super.createStatus = value;
    });
  }

  late final _$readAsyncAction =
      AsyncAction('_CategoryStoreBase.read', context: context);

  @override
  Future<dynamic> read() {
    return _$readAsyncAction.run(() => super.read());
  }

  late final _$postAsyncAction =
      AsyncAction('_CategoryStoreBase.post', context: context);

  @override
  Future<bool> post(CategoryData categoryData) {
    return _$postAsyncAction.run(() => super.post(categoryData));
  }

  late final _$_CategoryStoreBaseActionController =
      ActionController(name: '_CategoryStoreBase', context: context);

  @override
  void setIsIncome(bool filter) {
    final _$actionInfo = _$_CategoryStoreBaseActionController.startAction(
        name: '_CategoryStoreBase.setIsIncome');
    try {
      return super.setIsIncome(filter);
    } finally {
      _$_CategoryStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSearchText(String query) {
    final _$actionInfo = _$_CategoryStoreBaseActionController.startAction(
        name: '_CategoryStoreBase.setSearchText');
    try {
      return super.setSearchText(query);
    } finally {
      _$_CategoryStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
categoryModel: ${categoryModel},
status: ${status},
isIncome: ${isIncome},
searchText: ${searchText},
createStatus: ${createStatus},
onboardingCategory: ${onboardingCategory},
filterCategory: ${filterCategory},
searchCategory: ${searchCategory}
    ''';
  }
}
