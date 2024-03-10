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

  late final _$incomeFinanceAtom =
      Atom(name: '_FinanceStoreBase.incomeFinance', context: context);

  @override
  Finance get incomeFinance {
    _$incomeFinanceAtom.reportRead();
    return super.incomeFinance;
  }

  @override
  set incomeFinance(Finance value) {
    _$incomeFinanceAtom.reportWrite(value, super.incomeFinance, () {
      super.incomeFinance = value;
    });
  }

  late final _$expenseFinanceAtom =
      Atom(name: '_FinanceStoreBase.expenseFinance', context: context);

  @override
  Finance get expenseFinance {
    _$expenseFinanceAtom.reportRead();
    return super.expenseFinance;
  }

  @override
  set expenseFinance(Finance value) {
    _$expenseFinanceAtom.reportWrite(value, super.expenseFinance, () {
      super.expenseFinance = value;
    });
  }

  late final _$updateLoadingAtom =
      Atom(name: '_FinanceStoreBase.updateLoading', context: context);

  @override
  LoadingStatusEnum get updateLoading {
    _$updateLoadingAtom.reportRead();
    return super.updateLoading;
  }

  @override
  set updateLoading(LoadingStatusEnum value) {
    _$updateLoadingAtom.reportWrite(value, super.updateLoading, () {
      super.updateLoading = value;
    });
  }

  late final _$readAsyncAction =
      AsyncAction('_FinanceStoreBase.read', context: context);

  @override
  Future<dynamic> read() {
    return _$readAsyncAction.run(() => super.read());
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
  String toString() {
    return '''
loadingStatus: ${loadingStatus},
barChartLoading: ${barChartLoading},
finance: ${finance},
period: ${period},
isIncome: ${isIncome},
incomeFinance: ${incomeFinance},
expenseFinance: ${expenseFinance},
updateLoading: ${updateLoading},
isLoading: ${isLoading},
dollarAccount: ${dollarAccount}
    ''';
  }
}
