// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smart_goal_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SmartGoalStore on _SmartGoalStoreBase, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: '_SmartGoalStoreBase.isLoading'))
          .value;
  Computed<String>? _$queryParemeterComputed;

  @override
  String get queryParemeter =>
      (_$queryParemeterComputed ??= Computed<String>(() => super.queryParemeter,
              name: '_SmartGoalStoreBase.queryParemeter'))
          .value;
  Computed<String>? _$dateQueryComputed;

  @override
  String get dateQuery =>
      (_$dateQueryComputed ??= Computed<String>(() => super.dateQuery,
              name: '_SmartGoalStoreBase.dateQuery'))
          .value;

  late final _$loadingStatusAtom =
      Atom(name: '_SmartGoalStoreBase.loadingStatus', context: context);

  @override
  LoadingStatusEnum get loadingStatus {
    _$loadingStatusAtom.reportRead();
    return super.loadingStatus;
  }

  @override
  set loadingStatus(LoadingStatusEnum value) {
    _$loadingStatusAtom.reportWrite(value, super.loadingStatus, () {
      super.loadingStatus = value;
    });
  }

  late final _$smartGoalAtom =
      Atom(name: '_SmartGoalStoreBase.smartGoal', context: context);

  @override
  SmartGoal get smartGoal {
    _$smartGoalAtom.reportRead();
    return super.smartGoal;
  }

  @override
  set smartGoal(SmartGoal value) {
    _$smartGoalAtom.reportWrite(value, super.smartGoal, () {
      super.smartGoal = value;
    });
  }

  late final _$filteredProgressAtom =
      Atom(name: '_SmartGoalStoreBase.filteredProgress', context: context);

  @override
  SmartGoalStatusEnum get filteredProgress {
    _$filteredProgressAtom.reportRead();
    return super.filteredProgress;
  }

  @override
  set filteredProgress(SmartGoalStatusEnum value) {
    _$filteredProgressAtom.reportWrite(value, super.filteredProgress, () {
      super.filteredProgress = value;
    });
  }

  late final _$startDateAtom =
      Atom(name: '_SmartGoalStoreBase.startDate', context: context);

  @override
  DateTime? get startDate {
    _$startDateAtom.reportRead();
    return super.startDate;
  }

  @override
  set startDate(DateTime? value) {
    _$startDateAtom.reportWrite(value, super.startDate, () {
      super.startDate = value;
    });
  }

  late final _$endDateAtom =
      Atom(name: '_SmartGoalStoreBase.endDate', context: context);

  @override
  DateTime? get endDate {
    _$endDateAtom.reportRead();
    return super.endDate;
  }

  @override
  set endDate(DateTime? value) {
    _$endDateAtom.reportWrite(value, super.endDate, () {
      super.endDate = value;
    });
  }

  late final _$filteredSmartGoalAtom =
      Atom(name: '_SmartGoalStoreBase.filteredSmartGoal', context: context);

  @override
  ObservableMap<String, SmartGoal> get filteredSmartGoal {
    _$filteredSmartGoalAtom.reportRead();
    return super.filteredSmartGoal;
  }

  @override
  set filteredSmartGoal(ObservableMap<String, SmartGoal> value) {
    _$filteredSmartGoalAtom.reportWrite(value, super.filteredSmartGoal, () {
      super.filteredSmartGoal = value;
    });
  }

  late final _$smartGoalYearlyAtom =
      Atom(name: '_SmartGoalStoreBase.smartGoalYearly', context: context);

  @override
  ObservableMap<String, SmartGoalMonth> get smartGoalYearly {
    _$smartGoalYearlyAtom.reportRead();
    return super.smartGoalYearly;
  }

  @override
  set smartGoalYearly(ObservableMap<String, SmartGoalMonth> value) {
    _$smartGoalYearlyAtom.reportWrite(value, super.smartGoalYearly, () {
      super.smartGoalYearly = value;
    });
  }

  late final _$yearAtom =
      Atom(name: '_SmartGoalStoreBase.year', context: context);

  @override
  int get year {
    _$yearAtom.reportRead();
    return super.year;
  }

  @override
  set year(int value) {
    _$yearAtom.reportWrite(value, super.year, () {
      super.year = value;
    });
  }

  late final _$readAsyncAction =
      AsyncAction('_SmartGoalStoreBase.read', context: context);

  @override
  Future<dynamic> read() {
    return _$readAsyncAction.run(() => super.read());
  }

  late final _$readByPageAsyncAction =
      AsyncAction('_SmartGoalStoreBase.readByPage', context: context);

  @override
  Future<dynamic> readByPage({bool refreshed = false}) {
    return _$readByPageAsyncAction
        .run(() => super.readByPage(refreshed: refreshed));
  }

  late final _$readYearlyAsyncAction =
      AsyncAction('_SmartGoalStoreBase.readYearly', context: context);

  @override
  Future<dynamic> readYearly() {
    return _$readYearlyAsyncAction.run(() => super.readYearly());
  }

  late final _$postAsyncAction =
      AsyncAction('_SmartGoalStoreBase.post', context: context);

  @override
  Future<bool> post(SmartGoalData smartGoalData) {
    return _$postAsyncAction.run(() => super.post(smartGoalData));
  }

  late final _$updateAsyncAction =
      AsyncAction('_SmartGoalStoreBase.update', context: context);

  @override
  Future<bool> update(SmartGoalData smartGoalData) {
    return _$updateAsyncAction.run(() => super.update(smartGoalData));
  }

  late final _$deleteAsyncAction =
      AsyncAction('_SmartGoalStoreBase.delete', context: context);

  @override
  Future<bool> delete(SmartGoalData smartGoalData) {
    return _$deleteAsyncAction.run(() => super.delete(smartGoalData));
  }

  late final _$_SmartGoalStoreBaseActionController =
      ActionController(name: '_SmartGoalStoreBase', context: context);

  @override
  void setLoadingStatus(LoadingStatusEnum status) {
    final _$actionInfo = _$_SmartGoalStoreBaseActionController.startAction(
        name: '_SmartGoalStoreBase.setLoadingStatus');
    try {
      return super.setLoadingStatus(status);
    } finally {
      _$_SmartGoalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeFilteredProgress(SmartGoalStatusEnum type) {
    final _$actionInfo = _$_SmartGoalStoreBaseActionController.startAction(
        name: '_SmartGoalStoreBase.changeFilteredProgress');
    try {
      return super.changeFilteredProgress(type);
    } finally {
      _$_SmartGoalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void initialize() {
    final _$actionInfo = _$_SmartGoalStoreBaseActionController.startAction(
        name: '_SmartGoalStoreBase.initialize');
    try {
      return super.initialize();
    } finally {
      _$_SmartGoalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void dispose() {
    final _$actionInfo = _$_SmartGoalStoreBaseActionController.startAction(
        name: '_SmartGoalStoreBase.dispose');
    try {
      return super.dispose();
    } finally {
      _$_SmartGoalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loadingStatus: ${loadingStatus},
smartGoal: ${smartGoal},
filteredProgress: ${filteredProgress},
startDate: ${startDate},
endDate: ${endDate},
filteredSmartGoal: ${filteredSmartGoal},
smartGoalYearly: ${smartGoalYearly},
year: ${year},
isLoading: ${isLoading},
queryParemeter: ${queryParemeter},
dateQuery: ${dateQuery}
    ''';
  }
}
