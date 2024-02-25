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
  Computed<String>? _$queryParemeterComputed;

  @override
  String get queryParemeter =>
      (_$queryParemeterComputed ??= Computed<String>(() => super.queryParemeter,
              name: '_TransactionStoreBase.queryParemeter'))
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

  late final _$transactionAtom =
      Atom(name: '_TransactionStoreBase.transaction', context: context);

  @override
  Transaction get transaction {
    _$transactionAtom.reportRead();
    return super.transaction;
  }

  @override
  set transaction(Transaction value) {
    _$transactionAtom.reportWrite(value, super.transaction, () {
      super.transaction = value;
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

  late final _$filteredTransactionAtom =
      Atom(name: '_TransactionStoreBase.filteredTransaction', context: context);

  @override
  ObservableMap<String, Transaction> get filteredTransaction {
    _$filteredTransactionAtom.reportRead();
    return super.filteredTransaction;
  }

  @override
  set filteredTransaction(ObservableMap<String, Transaction> value) {
    _$filteredTransactionAtom.reportWrite(value, super.filteredTransaction, () {
      super.filteredTransaction = value;
    });
  }

  late final _$readByPageAsyncAction =
      AsyncAction('_TransactionStoreBase.readByPage', context: context);

  @override
  Future<dynamic> readByPage({bool refreshed = false}) {
    return _$readByPageAsyncAction
        .run(() => super.readByPage(refreshed: refreshed));
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
transaction: ${transaction},
filteredType: ${filteredType},
filteredPeriod: ${filteredPeriod},
filteredTransaction: ${filteredTransaction},
isLoading: ${isLoading},
queryParemeter: ${queryParemeter}
    ''';
  }
}
