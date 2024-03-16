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
  Computed<bool>? _$isLoadingBarChartComputed;

  @override
  bool get isLoadingBarChart => (_$isLoadingBarChartComputed ??= Computed<bool>(
          () => super.isLoadingBarChart,
          name: '_FinanceStoreBase.isLoadingBarChart'))
      .value;
  Computed<bool>? _$isLoadingPieChartComputed;

  @override
  bool get isLoadingPieChart => (_$isLoadingPieChartComputed ??= Computed<bool>(
          () => super.isLoadingPieChart,
          name: '_FinanceStoreBase.isLoadingPieChart'))
      .value;
  Computed<bool>? _$isLoadingUpdateComputed;

  @override
  bool get isLoadingUpdate =>
      (_$isLoadingUpdateComputed ??= Computed<bool>(() => super.isLoadingUpdate,
              name: '_FinanceStoreBase.isLoadingUpdate'))
          .value;
  Computed<FinanceItem>? _$dollarAccountComputed;

  @override
  FinanceItem get dollarAccount => (_$dollarAccountComputed ??=
          Computed<FinanceItem>(() => super.dollarAccount,
              name: '_FinanceStoreBase.dollarAccount'))
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

  late final _$loadingBarChartAtom =
      Atom(name: '_FinanceStoreBase.loadingBarChart', context: context);

  @override
  LoadingStatusEnum get loadingBarChart {
    _$loadingBarChartAtom.reportRead();
    return super.loadingBarChart;
  }

  @override
  set loadingBarChart(LoadingStatusEnum value) {
    _$loadingBarChartAtom.reportWrite(value, super.loadingBarChart, () {
      super.loadingBarChart = value;
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

  late final _$financeAtom =
      Atom(name: '_FinanceStoreBase.finance', context: context);

  @override
  Finance get finance {
    _$financeAtom.reportRead();
    return super.finance;
  }

  bool _financeIsInitialized = false;

  @override
  set finance(Finance value) {
    _$financeAtom
        .reportWrite(value, _financeIsInitialized ? super.finance : null, () {
      super.finance = value;
      _financeIsInitialized = true;
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

  late final _$_hasReadOnceAtom =
      Atom(name: '_FinanceStoreBase._hasReadOnce', context: context);

  @override
  bool get _hasReadOnce {
    _$_hasReadOnceAtom.reportRead();
    return super._hasReadOnce;
  }

  @override
  set _hasReadOnce(bool value) {
    _$_hasReadOnceAtom.reportWrite(value, super._hasReadOnce, () {
      super._hasReadOnce = value;
    });
  }

  late final _$readAsyncAction =
      AsyncAction('_FinanceStoreBase.read', context: context);

  @override
  Future<dynamic> read(
      {bool? isIncome, VoidCallback? setLoading, bool updateFinance = false}) {
    return _$readAsyncAction.run(() => super.read(
        isIncome: isIncome,
        setLoading: setLoading,
        updateFinance: updateFinance));
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
loadingBarChart: ${loadingBarChart},
loadingPieChart: ${loadingPieChart},
loadingUpdate: ${loadingUpdate},
finance: ${finance},
previousBarData: ${previousBarData},
isIncome: ${isIncome},
period: ${period},
filteredFinanceMap: ${filteredFinanceMap},
isLoading: ${isLoading},
isLoadingBarChart: ${isLoadingBarChart},
isLoadingPieChart: ${isLoadingPieChart},
isLoadingUpdate: ${isLoadingUpdate},
dollarAccount: ${dollarAccount},
queryParemeter: ${queryParemeter},
queryParemeterIncome: ${queryParemeterIncome},
queryParemeterExpense: ${queryParemeterExpense},
filteredFinance: ${filteredFinance},
incomeFinance: ${incomeFinance},
expenseFinance: ${expenseFinance}
    ''';
  }
}
