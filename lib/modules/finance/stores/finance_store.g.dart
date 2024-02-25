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

  late final _$readAsyncAction =
      AsyncAction('_FinanceStoreBase.read', context: context);

  @override
  Future<dynamic> read() {
    return _$readAsyncAction.run(() => super.read());
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
finance: ${finance},
isLoading: ${isLoading},
dollarAccount: ${dollarAccount}
    ''';
  }
}
