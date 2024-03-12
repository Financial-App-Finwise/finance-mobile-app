// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finance_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FinanceStore on _FinanceStoreBase, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: '_FinanceStoreBase.isLoading'))
          .value;
  Computed<String>? _$queryParemeterComputed;

  @override
  String get queryParemeter =>
      (_$queryParemeterComputed ??= Computed<String>(() => super.queryParemeter,
              name: '_FinanceStoreBase.queryParemeter'))
          .value;
  Computed<String>? _$queryParemeterIncomeComputed;

  @override
  String get queryParemeterIncome => (_$queryParemeterIncomeComputed ??=
          Computed<String>(() => super.queryParemeterIncome,
              name: '_FinanceStoreBase.queryParemeterIncome'))
      .value;
  Computed<String>? _$queryParemeterExpenseComputed;

  @override
  String get queryParemeterExpense => (_$queryParemeterExpenseComputed ??=
          Computed<String>(() => super.queryParemeterExpense,
              name: '_FinanceStoreBase.queryParemeterExpense'))
      .value;
  Computed<Finance>? _$filteredFinanceComputed;

  @override
  Finance get filteredFinance => (_$filteredFinanceComputed ??=
          Computed<Finance>(() => super.filteredFinance,
              name: '_FinanceStoreBase.filteredFinance'))
      .value;
  Computed<Finance>? _$incomeFinanceComputed;

  @override
  Finance get incomeFinance =>
      (_$incomeFinanceComputed ??= Computed<Finance>(() => super.incomeFinance,
              name: '_FinanceStoreBase.incomeFinance'))
          .value;
  Computed<Finance>? _$expenseFinanceComputed;

  @override
  Finance get expenseFinance => (_$expenseFinanceComputed ??= Computed<Finance>(
          () => super.expenseFinance,
          name: '_FinanceStoreBase.expenseFinance'))
      .value;
  Computed<FinanceItem>? _$dollarAccountComputed;

  @override
  FinanceItem get dollarAccount => (_$dollarAccountComputed ??=
          Computed<FinanceItem>(() => super.dollarAccount,
              name: '_FinanceStoreBase.dollarAccount'))
      .value;

  late final _$loadingStatusAtom =
      Atom(name: '_FinanceStoreBase.loadingStatus', context: context);

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

  late final _$barChartLoadingAtom =
      Atom(name: '_FinanceStoreBase.barChartLoading', context: context);

  @override
  LoadingStatusEnum get barChartLoading {
    _$barChartLoadingAtom.reportRead();
    return super.barChartLoading;
  }

  @override
  set barChartLoading(LoadingStatusEnum value) {
    _$barChartLoadingAtom.reportWrite(value, super.barChartLoading, () {
      super.barChartLoading = value;
    });
  }

  late final _$financeAtom =
      Atom(name: '_FinanceStoreBase.finance', context: context);

  @override
  Finance get finance {
    _$financeAtom.reportRead();
    return super.finance;
  }

  @override
  set finance(Finance value) {
    _$financeAtom.reportWrite(value, super.finance, () {
      super.finance = value;
    });
  }

  late final _$isIncomeAtom =
      Atom(name: '_FinanceStoreBase.isIncome', context: context);

  @override
  int get isIncome {
    _$isIncomeAtom.reportRead();
    return super.isIncome;
  }

  @override
  set isIncome(int value) {
    _$isIncomeAtom.reportWrite(value, super.isIncome, () {
      super.isIncome = value;
    });
  }

  late final _$periodAtom =
      Atom(name: '_FinanceStoreBase.period', context: context);

  @override
  String get period {
    _$periodAtom.reportRead();
    return super.period;
  }

  @override
  set period(String value) {
    _$periodAtom.reportWrite(value, super.period, () {
      super.period = value;
    });
  }

  late final _$filteredFinanceMapAtom =
      Atom(name: '_FinanceStoreBase.filteredFinanceMap', context: context);

  @override
  ObservableMap<String, Finance> get filteredFinanceMap {
    _$filteredFinanceMapAtom.reportRead();
    return super.filteredFinanceMap;
  }

  @override
  set filteredFinanceMap(ObservableMap<String, Finance> value) {
    _$filteredFinanceMapAtom.reportWrite(value, super.filteredFinanceMap, () {
      super.filteredFinanceMap = value;
    });
  }

  late final _$previousBarDataAtom =
      Atom(name: '_FinanceStoreBase.previousBarData', context: context);

  @override
  ObservableMap<String, IncomeExpenseCompare> get previousBarData {
    _$previousBarDataAtom.reportRead();
    return super.previousBarData;
  }

  @override
  set previousBarData(ObservableMap<String, IncomeExpenseCompare> value) {
    _$previousBarDataAtom.reportWrite(value, super.previousBarData, () {
      super.previousBarData = value;
    });
  }

  late final _$loadingPieChartAtom =
      Atom(name: '_FinanceStoreBase.loadingPieChart', context: context);

  @override
  LoadingStatusEnum get loadingPieChart {
    _$loadingPieChartAtom.reportRead();
    return super.loadingPieChart;
  }

  @override
  set loadingPieChart(LoadingStatusEnum value) {
    _$loadingPieChartAtom.reportWrite(value, super.loadingPieChart, () {
      super.loadingPieChart = value;
    });
  }

  late final _$loadingUpdateAtom =
      Atom(name: '_FinanceStoreBase.loadingUpdate', context: context);

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

  late final _$readAsyncAction =
      AsyncAction('_FinanceStoreBase.read', context: context);

  @override
  Future<dynamic> read({bool? isIncome}) {
    return _$readAsyncAction.run(() => super.read(isIncome: isIncome));
  }

  late final _$postAsyncAction =
      AsyncAction('_FinanceStoreBase.post', context: context);

  @override
  Future<bool> post(FinancePost data) {
    return _$postAsyncAction.run(() => super.post(data));
  }

  late final _$updateAsyncAction =
      AsyncAction('_FinanceStoreBase.update', context: context);

  @override
  Future<bool> update(double totalbalance) {
    return _$updateAsyncAction.run(() => super.update(totalbalance));
  }

  late final _$_FinanceStoreBaseActionController =
      ActionController(name: '_FinanceStoreBase', context: context);

  @override
  void setLoadingStatus(LoadingStatusEnum status) {
    final _$actionInfo = _$_FinanceStoreBaseActionController.startAction(
        name: '_FinanceStoreBase.setLoadingStatus');
    try {
      return super.setLoadingStatus(status);
    } finally {
      _$_FinanceStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void initialize(String key) {
    final _$actionInfo = _$_FinanceStoreBaseActionController.startAction(
        name: '_FinanceStoreBase.initialize');
    try {
      return super.initialize(key);
    } finally {
      _$_FinanceStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loadingStatus: ${loadingStatus},
barChartLoading: ${barChartLoading},
finance: ${finance},
isIncome: ${isIncome},
period: ${period},
filteredFinanceMap: ${filteredFinanceMap},
previousBarData: ${previousBarData},
loadingPieChart: ${loadingPieChart},
loadingUpdate: ${loadingUpdate},
isLoading: ${isLoading},
queryParemeter: ${queryParemeter},
queryParemeterIncome: ${queryParemeterIncome},
queryParemeterExpense: ${queryParemeterExpense},
filteredFinance: ${filteredFinance},
incomeFinance: ${incomeFinance},
expenseFinance: ${expenseFinance},
dollarAccount: ${dollarAccount}
    ''';
  }
}
