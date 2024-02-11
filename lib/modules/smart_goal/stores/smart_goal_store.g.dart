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

  late final _$statusAtom =
      Atom(name: '_SmartGoalStoreBase.status', context: context);

  @override
  LoadingStatusEnum get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(LoadingStatusEnum value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
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

  late final _$_SmartGoalStoreBaseActionController =
      ActionController(name: '_SmartGoalStoreBase', context: context);

  @override
  void setStatus(LoadingStatusEnum status) {
    final _$actionInfo = _$_SmartGoalStoreBaseActionController.startAction(
        name: '_SmartGoalStoreBase.setStatus');
    try {
      return super.setStatus(status);
    } finally {
      _$_SmartGoalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
smartGoal: ${smartGoal},
status: ${status},
currentPage: ${currentPage},
paginatedGoals: ${paginatedGoals},
inProgress: ${inProgress},
achieved: ${achieved}
    ''';
  }
}
