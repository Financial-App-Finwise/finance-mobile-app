// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TransactionStore on _TransactionStoreBase, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: '_TransactionStoreBase.isLoading'))
          .value;
  Computed<bool>? _$isLoadingCreateComputed;

  @override
  bool get isLoadingCreate =>
      (_$isLoadingCreateComputed ??= Computed<bool>(() => super.isLoadingCreate,
              name: '_TransactionStoreBase.isLoadingCreate'))
          .value;
  Computed<bool>? _$isLoadingUpdateComputed;

  @override
  bool get isLoadingUpdate =>
      (_$isLoadingUpdateComputed ??= Computed<bool>(() => super.isLoadingUpdate,
              name: '_TransactionStoreBase.isLoadingUpdate'))
          .value;
  Computed<bool>? _$isLoadingDeleteComputed;

  @override
  bool get isLoadingDelete =>
      (_$isLoadingDeleteComputed ??= Computed<bool>(() => super.isLoadingDelete,
              name: '_TransactionStoreBase.isLoadingDelete'))
          .value;
  Computed<String>? _$queryParemeterComputed;

  @override
  String get queryParemeter =>
      (_$queryParemeterComputed ??= Computed<String>(() => super.queryParemeter,
              name: '_TransactionStoreBase.queryParemeter'))
          .value;
  Computed<String>? _$queryParemeterIncomeComputed;

  @override
  String get queryParemeterIncome => (_$queryParemeterIncomeComputed ??=
          Computed<String>(() => super.queryParemeterIncome,
              name: '_TransactionStoreBase.queryParemeterIncome'))
      .value;
  Computed<String>? _$queryParemeterExpenseComputed;

  @override
  String get queryParemeterExpense => (_$queryParemeterExpenseComputed ??=
          Computed<String>(() => super.queryParemeterExpense,
              name: '_TransactionStoreBase.queryParemeterExpense'))
      .value;
  Computed<Transaction>? _$filteredTransactionComputed;

  @override
  Transaction get filteredTransaction => (_$filteredTransactionComputed ??=
          Computed<Transaction>(() => super.filteredTransaction,
              name: '_TransactionStoreBase.filteredTransaction'))
      .value;
  Computed<Transaction>? _$incomeTransactionComputed;

  @override
  Transaction get incomeTransaction => (_$incomeTransactionComputed ??=
          Computed<Transaction>(() => super.incomeTransaction,
              name: '_TransactionStoreBase.incomeTransaction'))
      .value;
  Computed<Transaction>? _$expenseTransactionComputed;

  @override
  Transaction get expenseTransaction => (_$expenseTransactionComputed ??=
          Computed<Transaction>(() => super.expenseTransaction,
              name: '_TransactionStoreBase.expenseTransaction'))
      .value;

  late final _$loadingStatusAtom =
      Atom(name: '_TransactionStoreBase.loadingStatus', context: context);

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
      Atom(name: '_TransactionStoreBase.loadingCreate', context: context);

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
      Atom(name: '_TransactionStoreBase.loadingUpdate', context: context);

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

  late final _$loadingDeleteAtom =
      Atom(name: '_TransactionStoreBase.loadingDelete', context: context);

  @override
  LoadingStatusEnum get loadingDelete {
    _$loadingDeleteAtom.reportRead();
    return super.loadingDelete;
  }

  @override
  set loadingDelete(LoadingStatusEnum value) {
    _$loadingDeleteAtom.reportWrite(value, super.loadingDelete, () {
      super.loadingDelete = value;
    });
  }

  late final _$transactionAtom =
      Atom(name: '_TransactionStoreBase.transaction', context: context);

  @override
  Transaction get transaction {
    _$transactionAtom.reportRead();
    return super.transaction;
  }

  bool _transactionIsInitialized = false;

  @override
  set transaction(Transaction value) {
    _$transactionAtom.reportWrite(
        value, _transactionIsInitialized ? super.transaction : null, () {
      super.transaction = value;
      _transactionIsInitialized = true;
    });
  }

  late final _$isIncomeAtom =
      Atom(name: '_TransactionStoreBase.isIncome', context: context);

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
      Atom(name: '_TransactionStoreBase.period', context: context);

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

  late final _$filteredTypeAtom =
      Atom(name: '_TransactionStoreBase.filteredType', context: context);

  @override
  TransactionTypeEnum get filteredType {
    _$filteredTypeAtom.reportRead();
    return super.filteredType;
  }

  @override
  set filteredType(TransactionTypeEnum value) {
    _$filteredTypeAtom.reportWrite(value, super.filteredType, () {
      super.filteredType = value;
    });
  }

  late final _$filteredPeriodAtom =
      Atom(name: '_TransactionStoreBase.filteredPeriod', context: context);

  @override
  TransactionPeriodEnum get filteredPeriod {
    _$filteredPeriodAtom.reportRead();
    return super.filteredPeriod;
  }

  @override
  set filteredPeriod(TransactionPeriodEnum value) {
    _$filteredPeriodAtom.reportWrite(value, super.filteredPeriod, () {
      super.filteredPeriod = value;
    });
  }

  late final _$filteredTransactionMapAtom = Atom(
      name: '_TransactionStoreBase.filteredTransactionMap', context: context);

  @override
  ObservableMap<String, Transaction> get filteredTransactionMap {
    _$filteredTransactionMapAtom.reportRead();
    return super.filteredTransactionMap;
  }

  @override
  set filteredTransactionMap(ObservableMap<String, Transaction> value) {
    _$filteredTransactionMapAtom
        .reportWrite(value, super.filteredTransactionMap, () {
      super.filteredTransactionMap = value;
    });
  }

  late final _$readByPageAsyncAction =
      AsyncAction('_TransactionStoreBase.readByPage', context: context);

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

  late final _$postAsyncAction =
      AsyncAction('_TransactionStoreBase.post', context: context);

  @override
  Future<bool> post(TransactionPost transactionPost) {
    return _$postAsyncAction.run(() => super.post(transactionPost));
  }

  late final _$updateAsyncAction =
      AsyncAction('_TransactionStoreBase.update', context: context);

  @override
  Future<bool> update(TransactionData transactionData) {
    return _$updateAsyncAction.run(() => super.update(transactionData));
  }

  late final _$deleteAsyncAction =
      AsyncAction('_TransactionStoreBase.delete', context: context);

  @override
  Future<bool> delete(TransactionData transactionData) {
    return _$deleteAsyncAction.run(() => super.delete(transactionData));
  }

  late final _$_TransactionStoreBaseActionController =
      ActionController(name: '_TransactionStoreBase', context: context);

  @override
  void setLoadingStatus(LoadingStatusEnum status) {
    final _$actionInfo = _$_TransactionStoreBaseActionController.startAction(
        name: '_TransactionStoreBase.setLoadingStatus');
    try {
      return super.setLoadingStatus(status);
    } finally {
      _$_TransactionStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeFilteredType(TransactionTypeEnum type) {
    final _$actionInfo = _$_TransactionStoreBaseActionController.startAction(
        name: '_TransactionStoreBase.changeFilteredType');
    try {
      return super.changeFilteredType(type);
    } finally {
      _$_TransactionStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeFilteredPeriod(TransactionPeriodEnum type) {
    final _$actionInfo = _$_TransactionStoreBaseActionController.startAction(
        name: '_TransactionStoreBase.changeFilteredPeriod');
    try {
      return super.changeFilteredPeriod(type);
    } finally {
      _$_TransactionStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void initialize() {
    final _$actionInfo = _$_TransactionStoreBaseActionController.startAction(
        name: '_TransactionStoreBase.initialize');
    try {
      return super.initialize();
    } finally {
      _$_TransactionStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loadingStatus: ${loadingStatus},
loadingCreate: ${loadingCreate},
loadingUpdate: ${loadingUpdate},
loadingDelete: ${loadingDelete},
transaction: ${transaction},
isIncome: ${isIncome},
period: ${period},
filteredType: ${filteredType},
filteredPeriod: ${filteredPeriod},
filteredTransactionMap: ${filteredTransactionMap},
isLoading: ${isLoading},
isLoadingCreate: ${isLoadingCreate},
isLoadingUpdate: ${isLoadingUpdate},
isLoadingDelete: ${isLoadingDelete},
queryParemeter: ${queryParemeter},
queryParemeterIncome: ${queryParemeterIncome},
queryParemeterExpense: ${queryParemeterExpense},
filteredTransaction: ${filteredTransaction},
incomeTransaction: ${incomeTransaction},
expenseTransaction: ${expenseTransaction}
    ''';
  }
}
