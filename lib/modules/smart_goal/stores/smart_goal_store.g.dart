// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smart_goal_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SmartGoalStore on _SmartGoalStoreBase, Store {
  Computed<ObservableList<SmartGoalData>>? _$inProgressComputed;

  @override
  ObservableList<SmartGoalData> get inProgress => (_$inProgressComputed ??=
          Computed<ObservableList<SmartGoalData>>(() => super.inProgress,
              name: '_SmartGoalStoreBase.inProgress'))
      .value;
  Computed<ObservableList<SmartGoalData>>? _$achievedComputed;

  @override
  ObservableList<SmartGoalData> get achieved => (_$achievedComputed ??=
          Computed<ObservableList<SmartGoalData>>(() => super.achieved,
              name: '_SmartGoalStoreBase.achieved'))
      .value;
  Computed<ObservableList<SmartGoalData>>? _$filteredGoalsComputed;

  @override
  ObservableList<SmartGoalData> get filteredGoals =>
      (_$filteredGoalsComputed ??= Computed<ObservableList<SmartGoalData>>(
              () => super.filteredGoals,
              name: '_SmartGoalStoreBase.filteredGoals'))
          .value;
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: '_SmartGoalStoreBase.isLoading'))
          .value;

  late final _$currentProgressStatusAtom =
      Atom(name: '_SmartGoalStoreBase.currentProgressStatus', context: context);

  @override
  SmartGoalStatusEnum get currentProgressStatus {
    _$currentProgressStatusAtom.reportRead();
    return super.currentProgressStatus;
  }

  @override
  set currentProgressStatus(SmartGoalStatusEnum value) {
    _$currentProgressStatusAtom.reportWrite(value, super.currentProgressStatus,
        () {
      super.currentProgressStatus = value;
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

  late final _$currentPageAtom =
      Atom(name: '_SmartGoalStoreBase.currentPage', context: context);

  @override
  int get currentPage {
    _$currentPageAtom.reportRead();
    return super.currentPage;
  }

  @override
  set currentPage(int value) {
    _$currentPageAtom.reportWrite(value, super.currentPage, () {
      super.currentPage = value;
    });
  }

  late final _$paginatedGoalsAtom =
      Atom(name: '_SmartGoalStoreBase.paginatedGoals', context: context);

  @override
  ObservableList<SmartGoalData> get paginatedGoals {
    _$paginatedGoalsAtom.reportRead();
    return super.paginatedGoals;
  }

  @override
  set paginatedGoals(ObservableList<SmartGoalData> value) {
    _$paginatedGoalsAtom.reportWrite(value, super.paginatedGoals, () {
      super.paginatedGoals = value;
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

  late final _$postAsyncAction =
      AsyncAction('_SmartGoalStoreBase.post', context: context);

  @override
  Future<bool> post(SmartGoalData smartGoalData) {
    return _$postAsyncAction.run(() => super.post(smartGoalData));
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
  void changeProgressStatus(SmartGoalStatusEnum status) {
    final _$actionInfo = _$_SmartGoalStoreBaseActionController.startAction(
        name: '_SmartGoalStoreBase.changeProgressStatus');
    try {
      return super.changeProgressStatus(status);
    } finally {
      _$_SmartGoalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

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
currentProgressStatus: ${currentProgressStatus},
smartGoal: ${smartGoal},
loadingStatus: ${loadingStatus},
currentPage: ${currentPage},
paginatedGoals: ${paginatedGoals},
inProgress: ${inProgress},
achieved: ${achieved},
filteredGoals: ${filteredGoals},
isLoading: ${isLoading}
    ''';
  }
}
