// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_plan_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BudgetPlanStore on _BudgetPlanStoreBase, Store {
  Computed<String>? _$queryParameterComputed;

  @override
  String get queryParameter =>
      (_$queryParameterComputed ??= Computed<String>(() => super.queryParameter,
              name: '_BudgetPlanStoreBase.queryParameter'))
          .value;

  late final _$budgetPlanAtom =
      Atom(name: '_BudgetPlanStoreBase.budgetPlan', context: context);

  @override
  BudgetPlan get budgetPlan {
    _$budgetPlanAtom.reportRead();
    return super.budgetPlan;
  }

  @override
  set budgetPlan(BudgetPlan value) {
    _$budgetPlanAtom.reportWrite(value, super.budgetPlan, () {
      super.budgetPlan = value;
    });
  }

  late final _$budgetPlanYearlyAtom =
      Atom(name: '_BudgetPlanStoreBase.budgetPlanYearly', context: context);

  @override
  BudgetPlanYearly get budgetPlanYearly {
    _$budgetPlanYearlyAtom.reportRead();
    return super.budgetPlanYearly;
  }

  @override
  set budgetPlanYearly(BudgetPlanYearly value) {
    _$budgetPlanYearlyAtom.reportWrite(value, super.budgetPlanYearly, () {
      super.budgetPlanYearly = value;
    });
  }

  late final _$statusAtom =
      Atom(name: '_BudgetPlanStoreBase.status', context: context);

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

  late final _$selectedDateAtom =
      Atom(name: '_BudgetPlanStoreBase.selectedDate', context: context);

  @override
  DateTime get selectedDate {
    _$selectedDateAtom.reportRead();
    return super.selectedDate;
  }

  @override
  set selectedDate(DateTime value) {
    _$selectedDateAtom.reportWrite(value, super.selectedDate, () {
      super.selectedDate = value;
    });
  }

  late final _$filterAtom =
      Atom(name: '_BudgetPlanStoreBase.filter', context: context);

  @override
  BudgetPlanFilterEnum get filter {
    _$filterAtom.reportRead();
    return super.filter;
  }

  @override
  set filter(BudgetPlanFilterEnum value) {
    _$filterAtom.reportWrite(value, super.filter, () {
      super.filter = value;
    });
  }

  late final _$createStatusAtom =
      Atom(name: '_BudgetPlanStoreBase.createStatus', context: context);

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

  late final _$editStatusAtom =
      Atom(name: '_BudgetPlanStoreBase.editStatus', context: context);

  @override
  LoadingStatusEnum get editStatus {
    _$editStatusAtom.reportRead();
    return super.editStatus;
  }

  @override
  set editStatus(LoadingStatusEnum value) {
    _$editStatusAtom.reportWrite(value, super.editStatus, () {
      super.editStatus = value;
    });
  }

  late final _$predictionAtom =
      Atom(name: '_BudgetPlanStoreBase.prediction', context: context);

  @override
  Prediction get prediction {
    _$predictionAtom.reportRead();
    return super.prediction;
  }

  @override
  set prediction(Prediction value) {
    _$predictionAtom.reportWrite(value, super.prediction, () {
      super.prediction = value;
    });
  }

  late final _$predictionStatusAtom =
      Atom(name: '_BudgetPlanStoreBase.predictionStatus', context: context);

  @override
  LoadingStatusEnum get predictionStatus {
    _$predictionStatusAtom.reportRead();
    return super.predictionStatus;
  }

  @override
  set predictionStatus(LoadingStatusEnum value) {
    _$predictionStatusAtom.reportWrite(value, super.predictionStatus, () {
      super.predictionStatus = value;
    });
  }

  late final _$readYearlyAsyncAction =
      AsyncAction('_BudgetPlanStoreBase.readYearly', context: context);

  @override
  Future<dynamic> readYearly() {
    return _$readYearlyAsyncAction.run(() => super.readYearly());
  }

  late final _$readAsyncAction =
      AsyncAction('_BudgetPlanStoreBase.read', context: context);

  @override
  Future<dynamic> read({bool refreshed = false}) {
    return _$readAsyncAction.run(() => super.read(refreshed: refreshed));
  }

  late final _$postAsyncAction =
      AsyncAction('_BudgetPlanStoreBase.post', context: context);

  @override
  Future<bool> post(BudgetPlanData budgetPlanData) {
    return _$postAsyncAction.run(() => super.post(budgetPlanData));
  }

  late final _$editAsyncAction =
      AsyncAction('_BudgetPlanStoreBase.edit', context: context);

  @override
  Future<bool> edit(BudgetPlanData budgetPlanData) {
    return _$editAsyncAction.run(() => super.edit(budgetPlanData));
  }

  late final _$deleteAsyncAction =
      AsyncAction('_BudgetPlanStoreBase.delete', context: context);

  @override
  Future<bool> delete(BudgetPlanData budgetPlanData) {
    return _$deleteAsyncAction.run(() => super.delete(budgetPlanData));
  }

  late final _$readPredictionAsyncAction =
      AsyncAction('_BudgetPlanStoreBase.readPrediction', context: context);

  @override
  Future<dynamic> readPrediction() {
    return _$readPredictionAsyncAction.run(() => super.readPrediction());
  }

  late final _$_BudgetPlanStoreBaseActionController =
      ActionController(name: '_BudgetPlanStoreBase', context: context);

  @override
  void setLoadingStatus(LoadingStatusEnum status) {
    final _$actionInfo = _$_BudgetPlanStoreBaseActionController.startAction(
        name: '_BudgetPlanStoreBase.setLoadingStatus');
    try {
      return super.setLoadingStatus(status);
    } finally {
      _$_BudgetPlanStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedDate(DateTime date) {
    final _$actionInfo = _$_BudgetPlanStoreBaseActionController.startAction(
        name: '_BudgetPlanStoreBase.setSelectedDate');
    try {
      return super.setSelectedDate(date);
    } finally {
      _$_BudgetPlanStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addSelectedDateYear({bool addYear = true}) {
    final _$actionInfo = _$_BudgetPlanStoreBaseActionController.startAction(
        name: '_BudgetPlanStoreBase.addSelectedDateYear');
    try {
      return super.addSelectedDateYear(addYear: addYear);
    } finally {
      _$_BudgetPlanStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFilter(BudgetPlanFilterEnum type) {
    final _$actionInfo = _$_BudgetPlanStoreBaseActionController.startAction(
        name: '_BudgetPlanStoreBase.setFilter');
    try {
      return super.setFilter(type);
    } finally {
      _$_BudgetPlanStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
budgetPlan: ${budgetPlan},
budgetPlanYearly: ${budgetPlanYearly},
status: ${status},
selectedDate: ${selectedDate},
filter: ${filter},
createStatus: ${createStatus},
editStatus: ${editStatus},
prediction: ${prediction},
predictionStatus: ${predictionStatus},
queryParameter: ${queryParameter}
    ''';
  }
}
