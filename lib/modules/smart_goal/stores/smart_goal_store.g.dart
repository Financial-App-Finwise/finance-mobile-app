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
  Computed<bool>? _$isLoadingCreateComputed;

  @override
  bool get isLoadingCreate =>
      (_$isLoadingCreateComputed ??= Computed<bool>(() => super.isLoadingCreate,
              name: '_SmartGoalStoreBase.isLoadingCreate'))
          .value;
  Computed<bool>? _$isLoadingUpdateComputed;

  @override
  bool get isLoadingUpdate =>
      (_$isLoadingUpdateComputed ??= Computed<bool>(() => super.isLoadingUpdate,
              name: '_SmartGoalStoreBase.isLoadingUpdate'))
          .value;
  Computed<bool>? _$isLoadingYearlyComputed;

  @override
  bool get isLoadingYearly =>
      (_$isLoadingYearlyComputed ??= Computed<bool>(() => super.isLoadingYearly,
              name: '_SmartGoalStoreBase.isLoadingYearly'))
          .value;
  Computed<String>? _$dateQueryComputed;

  @override
  String get dateQuery =>
      (_$dateQueryComputed ??= Computed<String>(() => super.dateQuery,
              name: '_SmartGoalStoreBase.dateQuery'))
          .value;
  Computed<String>? _$queryParemeterComputed;

  @override
  String get queryParemeter =>
      (_$queryParemeterComputed ??= Computed<String>(() => super.queryParemeter,
              name: '_SmartGoalStoreBase.queryParemeter'))
          .value;
  Computed<String>? _$queryParemeterInProgressComputed;

  @override
  String get queryParemeterInProgress => (_$queryParemeterInProgressComputed ??=
          Computed<String>(() => super.queryParemeterInProgress,
              name: '_SmartGoalStoreBase.queryParemeterInProgress'))
      .value;
  Computed<String>? _$queryParemeterAchievedComputed;

  @override
  String get queryParemeterAchieved => (_$queryParemeterAchievedComputed ??=
          Computed<String>(() => super.queryParemeterAchieved,
              name: '_SmartGoalStoreBase.queryParemeterAchieved'))
      .value;
  Computed<SmartGoal>? _$filteredSmartGoalComputed;

  @override
  SmartGoal get filteredSmartGoal => (_$filteredSmartGoalComputed ??=
          Computed<SmartGoal>(() => super.filteredSmartGoal,
              name: '_SmartGoalStoreBase.filteredSmartGoal'))
      .value;
  Computed<SmartGoal>? _$inProgressSmartGoalComputed;

  @override
  SmartGoal get inProgressSmartGoal => (_$inProgressSmartGoalComputed ??=
          Computed<SmartGoal>(() => super.inProgressSmartGoal,
              name: '_SmartGoalStoreBase.inProgressSmartGoal'))
      .value;
  Computed<SmartGoal>? _$achievedSmartGoalComputed;

  @override
  SmartGoal get achievedSmartGoal => (_$achievedSmartGoalComputed ??=
          Computed<SmartGoal>(() => super.achievedSmartGoal,
              name: '_SmartGoalStoreBase.achievedSmartGoal'))
      .value;
  Computed<bool>? _$isLoadingDetailComputed;

  @override
  bool get isLoadingDetail =>
      (_$isLoadingDetailComputed ??= Computed<bool>(() => super.isLoadingDetail,
              name: '_SmartGoalStoreBase.isLoadingDetail'))
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

  late final _$loadingCreateAtom =
      Atom(name: '_SmartGoalStoreBase.loadingCreate', context: context);

  @override
  LoadingStatusEnum get loadingCreate {
    _$loadingCreateAtom.reportRead();
    return super.loadingCreate;
  }

  @override
  set loadingCreate(LoadingStatusEnum value) {
    _$loadingCreateAtom.reportWrite(value, super.loadingCreate, () {
      super.loadingCreate = value;
    });
  }

  late final _$loadingUpdateAtom =
      Atom(name: '_SmartGoalStoreBase.loadingUpdate', context: context);

  @override
  LoadingStatusEnum get loadingUpdate {
    _$loadingUpdateAtom.reportRead();
    return super.loadingUpdate;
  }

  @override
  set loadingUpdate(LoadingStatusEnum value) {
    _$loadingUpdateAtom.reportWrite(value, super.loadingUpdate, () {
      super.loadingUpdate = value;
    });
  }

  late final _$loadingYearlyAtom =
      Atom(name: '_SmartGoalStoreBase.loadingYearly', context: context);

  @override
  LoadingStatusEnum get loadingYearly {
    _$loadingYearlyAtom.reportRead();
    return super.loadingYearly;
  }

  @override
  set loadingYearly(LoadingStatusEnum value) {
    _$loadingYearlyAtom.reportWrite(value, super.loadingYearly, () {
      super.loadingYearly = value;
    });
  }

  late final _$smartGoalAtom =
      Atom(name: '_SmartGoalStoreBase.smartGoal', context: context);

  @override
  SmartGoal get smartGoal {
    _$smartGoalAtom.reportRead();
    return super.smartGoal;
  }

  bool _smartGoalIsInitialized = false;

  @override
  set smartGoal(SmartGoal value) {
    _$smartGoalAtom.reportWrite(
        value, _smartGoalIsInitialized ? super.smartGoal : null, () {
      super.smartGoal = value;
      _smartGoalIsInitialized = true;
    });
  }

  late final _$endDateGTEAtom =
      Atom(name: '_SmartGoalStoreBase.endDateGTE', context: context);

  @override
  DateTime? get endDateGTE {
    _$endDateGTEAtom.reportRead();
    return super.endDateGTE;
  }

  bool _endDateGTEIsInitialized = false;

  @override
  set endDateGTE(DateTime? value) {
    _$endDateGTEAtom.reportWrite(
        value, _endDateGTEIsInitialized ? super.endDateGTE : null, () {
      super.endDateGTE = value;
      _endDateGTEIsInitialized = true;
    });
  }

  late final _$endDateLTEAtom =
      Atom(name: '_SmartGoalStoreBase.endDateLTE', context: context);

  @override
  DateTime? get endDateLTE {
    _$endDateLTEAtom.reportRead();
    return super.endDateLTE;
  }

  bool _endDateLTEIsInitialized = false;

  @override
  set endDateLTE(DateTime? value) {
    _$endDateLTEAtom.reportWrite(
        value, _endDateLTEIsInitialized ? super.endDateLTE : null, () {
      super.endDateLTE = value;
      _endDateLTEIsInitialized = true;
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

  late final _$filteredSmartGoalMapAtom =
      Atom(name: '_SmartGoalStoreBase.filteredSmartGoalMap', context: context);

  @override
  ObservableMap<String, SmartGoal> get filteredSmartGoalMap {
    _$filteredSmartGoalMapAtom.reportRead();
    return super.filteredSmartGoalMap;
  }

  @override
  set filteredSmartGoalMap(ObservableMap<String, SmartGoal> value) {
    _$filteredSmartGoalMapAtom.reportWrite(value, super.filteredSmartGoalMap,
        () {
      super.filteredSmartGoalMap = value;
    });
  }

  late final _$metaAtom =
      Atom(name: '_SmartGoalStoreBase.meta', context: context);

  @override
  SmartGoalMeta get meta {
    _$metaAtom.reportRead();
    return super.meta;
  }

  @override
  set meta(SmartGoalMeta value) {
    _$metaAtom.reportWrite(value, super.meta, () {
      super.meta = value;
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

  late final _$smartGoalDetailAtom =
      Atom(name: '_SmartGoalStoreBase.smartGoalDetail', context: context);

  @override
  SmartGoalDetailModel get smartGoalDetail {
    _$smartGoalDetailAtom.reportRead();
    return super.smartGoalDetail;
  }

  @override
  set smartGoalDetail(SmartGoalDetailModel value) {
    _$smartGoalDetailAtom.reportWrite(value, super.smartGoalDetail, () {
      super.smartGoalDetail = value;
    });
  }

  late final _$loadingDetailAtom =
      Atom(name: '_SmartGoalStoreBase.loadingDetail', context: context);

  @override
  LoadingStatusEnum get loadingDetail {
    _$loadingDetailAtom.reportRead();
    return super.loadingDetail;
  }

  @override
  set loadingDetail(LoadingStatusEnum value) {
    _$loadingDetailAtom.reportWrite(value, super.loadingDetail, () {
      super.loadingDetail = value;
    });
  }

  late final _$readAsyncAction =
      AsyncAction('_SmartGoalStoreBase.read', context: context);

  @override
  Future<dynamic> read({SmartGoalStatusEnum status = SmartGoalStatusEnum.all}) {
    return _$readAsyncAction.run(() => super.read(status: status));
  }

  late final _$readByPageAsyncAction =
      AsyncAction('_SmartGoalStoreBase.readByPage', context: context);

  @override
  Future<dynamic> readByPage(
      {bool refreshed = false,
      VoidCallback? setLoading,
      bool updateScreen = false}) {
    return _$readByPageAsyncAction.run(() => super.readByPage(
        refreshed: refreshed,
        setLoading: setLoading,
        updateScreen: updateScreen));
  }

  late final _$readYearlyAsyncAction =
      AsyncAction('_SmartGoalStoreBase.readYearly', context: context);

  @override
  Future<dynamic> readYearly() {
    return _$readYearlyAsyncAction.run(() => super.readYearly());
  }

  late final _$showAsyncAction =
      AsyncAction('_SmartGoalStoreBase.show', context: context);

  @override
  Future<dynamic> show(int id) {
    return _$showAsyncAction.run(() => super.show(id));
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
loadingCreate: ${loadingCreate},
loadingUpdate: ${loadingUpdate},
loadingYearly: ${loadingYearly},
smartGoal: ${smartGoal},
endDateGTE: ${endDateGTE},
endDateLTE: ${endDateLTE},
filteredProgress: ${filteredProgress},
filteredSmartGoalMap: ${filteredSmartGoalMap},
meta: ${meta},
smartGoalYearly: ${smartGoalYearly},
year: ${year},
smartGoalDetail: ${smartGoalDetail},
loadingDetail: ${loadingDetail},
isLoading: ${isLoading},
isLoadingCreate: ${isLoadingCreate},
isLoadingUpdate: ${isLoadingUpdate},
isLoadingYearly: ${isLoadingYearly},
dateQuery: ${dateQuery},
queryParemeter: ${queryParemeter},
queryParemeterInProgress: ${queryParemeterInProgress},
queryParemeterAchieved: ${queryParemeterAchieved},
filteredSmartGoal: ${filteredSmartGoal},
inProgressSmartGoal: ${inProgressSmartGoal},
achievedSmartGoal: ${achievedSmartGoal},
isLoadingDetail: ${isLoadingDetail}
    ''';
  }
}
