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
  Computed<Finance>? _$financeExpenseComputed;

  @override
  Finance get financeExpense => (_$financeExpenseComputed ??= Computed<Finance>(
          () => super.financeExpense,
          name: '_FinanceStoreBase.financeExpense'))
      .value;
  Computed<Finance>? _$filteredFinanceIncomeComputed;

  @override
  Finance get filteredFinanceIncome => (_$filteredFinanceIncomeComputed ??=
          Computed<Finance>(() => super.filteredFinanceIncome,
              name: '_FinanceStoreBase.filteredFinanceIncome'))
      .value;
  Computed<Finance>? _$filteredFinanceExpenseComputed;

  @override
  Finance get filteredFinanceExpense => (_$filteredFinanceExpenseComputed ??=
          Computed<Finance>(() => super.filteredFinanceExpense,
              name: '_FinanceStoreBase.filteredFinanceExpense'))
      .value;
  Computed<String>? _$myFinanceQueryComputed;

  @override
  String get myFinanceQuery =>
      (_$myFinanceQueryComputed ??= Computed<String>(() => super.myFinanceQuery,
              name: '_FinanceStoreBase.myFinanceQuery'))
          .value;
  Computed<Finance>? _$myFinanceComputed;

  @override
  Finance get myFinance =>
      (_$myFinanceComputed ??= Computed<Finance>(() => super.myFinance,
              name: '_FinanceStoreBase.myFinance'))
          .value;
  Computed<FinanceItem>? _$dollarAccountComputed;

  @override
  FinanceItem get dollarAccount => (_$dollarAccountComputed ??=
          Computed<FinanceItem>(() => super.dollarAccount,
              name: '_FinanceStoreBase.dollarAccount'))
      .value;
  Computed<String>? _$barChartQueryComputed;

  @override
  String get barChartQuery =>
      (_$barChartQueryComputed ??= Computed<String>(() => super.barChartQuery,
              name: '_FinanceStoreBase.barChartQuery'))
          .value;
  Computed<Finance>? _$barChartFinanceComputed;

  @override
  Finance get barChartFinance => (_$barChartFinanceComputed ??=
          Computed<Finance>(() => super.barChartFinance,
              name: '_FinanceStoreBase.barChartFinance'))
      .value;
  Computed<String>? _$totalSpendQueryComputed;

  @override
  String get totalSpendQuery => (_$totalSpendQueryComputed ??= Computed<String>(
          () => super.totalSpendQuery,
          name: '_FinanceStoreBase.totalSpendQuery'))
      .value;
  Computed<Finance>? _$totalSpendFinanceComputed;

  @override
  Finance get totalSpendFinance => (_$totalSpendFinanceComputed ??=
          Computed<Finance>(() => super.totalSpendFinance,
              name: '_FinanceStoreBase.totalSpendFinance'))
      .value;
  Computed<String>? _$totalEarnQueryComputed;

  @override
  String get totalEarnQuery =>
      (_$totalEarnQueryComputed ??= Computed<String>(() => super.totalEarnQuery,
              name: '_FinanceStoreBase.totalEarnQuery'))
          .value;
  Computed<Finance>? _$totalEarnFinanceComputed;

  @override
  Finance get totalEarnFinance => (_$totalEarnFinanceComputed ??=
          Computed<Finance>(() => super.totalEarnFinance,
              name: '_FinanceStoreBase.totalEarnFinance'))
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

  late final _$myFinancePeriodAtom =
      Atom(name: '_FinanceStoreBase.myFinancePeriod', context: context);

  @override
  String get myFinancePeriod {
    _$myFinancePeriodAtom.reportRead();
    return super.myFinancePeriod;
  }

  @override
  set myFinancePeriod(String value) {
    _$myFinancePeriodAtom.reportWrite(value, super.myFinancePeriod, () {
      super.myFinancePeriod = value;
    });
  }

  late final _$barChartPeriodAtom =
      Atom(name: '_FinanceStoreBase.barChartPeriod', context: context);

  @override
  String get barChartPeriod {
    _$barChartPeriodAtom.reportRead();
    return super.barChartPeriod;
  }

  @override
  set barChartPeriod(String value) {
    _$barChartPeriodAtom.reportWrite(value, super.barChartPeriod, () {
      super.barChartPeriod = value;
    });
  }

  late final _$totalSpendPeriodAtom =
      Atom(name: '_FinanceStoreBase.totalSpendPeriod', context: context);

  @override
  String get totalSpendPeriod {
    _$totalSpendPeriodAtom.reportRead();
    return super.totalSpendPeriod;
  }

  @override
  set totalSpendPeriod(String value) {
    _$totalSpendPeriodAtom.reportWrite(value, super.totalSpendPeriod, () {
      super.totalSpendPeriod = value;
    });
  }

  late final _$totalEarnPeriodAtom =
      Atom(name: '_FinanceStoreBase.totalEarnPeriod', context: context);

  @override
  String get totalEarnPeriod {
    _$totalEarnPeriodAtom.reportRead();
    return super.totalEarnPeriod;
  }

  @override
  set totalEarnPeriod(String value) {
    _$totalEarnPeriodAtom.reportWrite(value, super.totalEarnPeriod, () {
      super.totalEarnPeriod = value;
    });
  }

  late final _$readAsyncAction =
      AsyncAction('_FinanceStoreBase.read', context: context);

  @override
  Future<dynamic> read(
      {bool? isIncome,
      VoidCallback? setLoading,
      bool updateFinance = false,
      String? queryParemeter}) {
    return _$readAsyncAction.run(() => super.read(
        isIncome: isIncome,
        setLoading: setLoading,
        updateFinance: updateFinance,
        queryParemeter: queryParemeter));
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
myFinancePeriod: ${myFinancePeriod},
barChartPeriod: ${barChartPeriod},
totalSpendPeriod: ${totalSpendPeriod},
totalEarnPeriod: ${totalEarnPeriod},
isLoading: ${isLoading},
isLoadingBarChart: ${isLoadingBarChart},
isLoadingPieChart: ${isLoadingPieChart},
isLoadingUpdate: ${isLoadingUpdate},
queryParemeter: ${queryParemeter},
queryParemeterIncome: ${queryParemeterIncome},
queryParemeterExpense: ${queryParemeterExpense},
filteredFinance: ${filteredFinance},
financeExpense: ${financeExpense},
filteredFinanceIncome: ${filteredFinanceIncome},
filteredFinanceExpense: ${filteredFinanceExpense},
myFinanceQuery: ${myFinanceQuery},
myFinance: ${myFinance},
dollarAccount: ${dollarAccount},
barChartQuery: ${barChartQuery},
barChartFinance: ${barChartFinance},
totalSpendQuery: ${totalSpendQuery},
totalSpendFinance: ${totalSpendFinance},
totalEarnQuery: ${totalEarnQuery},
totalEarnFinance: ${totalEarnFinance}
    ''';
  }
}
