// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TransactionStore on _TransactionStoreBase, Store {
  Computed<ObservableList<TransactionData>>? _$incomeTransactionsComputed;

  @override
  ObservableList<TransactionData> get incomeTransactions =>
      (_$incomeTransactionsComputed ??=
              Computed<ObservableList<TransactionData>>(
                  () => super.incomeTransactions,
                  name: '_TransactionStoreBase.incomeTransactions'))
          .value;
  Computed<ObservableList<TransactionData>>? _$expenseTransactionsComputed;

  @override
  ObservableList<TransactionData> get expenseTransactions =>
      (_$expenseTransactionsComputed ??=
              Computed<ObservableList<TransactionData>>(
                  () => super.expenseTransactions,
                  name: '_TransactionStoreBase.expenseTransactions'))
          .value;
  Computed<ObservableList<TransactionData>>? _$typeFilteredTransactionsComputed;

  @override
  ObservableList<TransactionData> get typeFilteredTransactions =>
      (_$typeFilteredTransactionsComputed ??=
              Computed<ObservableList<TransactionData>>(
                  () => super.typeFilteredTransactions,
                  name: '_TransactionStoreBase.typeFilteredTransactions'))
          .value;

  late final _$transactionsAtom =
      Atom(name: '_TransactionStoreBase.transactions', context: context);

  @override
  ObservableList<TransactionData> get transactions {
    _$transactionsAtom.reportRead();
    return super.transactions;
  }

  @override
  set transactions(ObservableList<TransactionData> value) {
    _$transactionsAtom.reportWrite(value, super.transactions, () {
      super.transactions = value;
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

  late final _$_TransactionStoreBaseActionController =
      ActionController(name: '_TransactionStoreBase', context: context);

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
  void getTransaction() {
    final _$actionInfo = _$_TransactionStoreBaseActionController.startAction(
        name: '_TransactionStoreBase.getTransaction');
    try {
      return super.getTransaction();
    } finally {
      _$_TransactionStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
transactions: ${transactions},
filteredType: ${filteredType},
incomeTransactions: ${incomeTransactions},
expenseTransactions: ${expenseTransactions},
typeFilteredTransactions: ${typeFilteredTransactions}
    ''';
  }
}
