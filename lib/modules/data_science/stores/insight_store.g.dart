// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insight_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$InsightStore on _InsightStoreBase, Store {
  late final _$controllerAtom =
      Atom(name: '_InsightStoreBase.controller', context: context);

  @override
  WebViewController get controller {
    _$controllerAtom.reportRead();
    return super.controller;
  }

  @override
  set controller(WebViewController value) {
    _$controllerAtom.reportWrite(value, super.controller, () {
      super.controller = value;
    });
  }

  late final _$doneAtom =
      Atom(name: '_InsightStoreBase.done', context: context);

  @override
  bool get done {
    _$doneAtom.reportRead();
    return super.done;
  }

  @override
  set done(bool value) {
    _$doneAtom.reportWrite(value, super.done, () {
      super.done = value;
    });
  }

  late final _$loadingPercentageAtom =
      Atom(name: '_InsightStoreBase.loadingPercentage', context: context);

  @override
  int get loadingPercentage {
    _$loadingPercentageAtom.reportRead();
    return super.loadingPercentage;
  }

  @override
  set loadingPercentage(int value) {
    _$loadingPercentageAtom.reportWrite(value, super.loadingPercentage, () {
      super.loadingPercentage = value;
    });
  }

  late final _$_InsightStoreBaseActionController =
      ActionController(name: '_InsightStoreBase', context: context);

  @override
  void loadWebPage() {
    final _$actionInfo = _$_InsightStoreBaseActionController.startAction(
        name: '_InsightStoreBase.loadWebPage');
    try {
      return super.loadWebPage();
    } finally {
      _$_InsightStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void dispose() {
    final _$actionInfo = _$_InsightStoreBaseActionController.startAction(
        name: '_InsightStoreBase.dispose');
    try {
      return super.dispose();
    } finally {
      _$_InsightStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
controller: ${controller},
done: ${done},
loadingPercentage: ${loadingPercentage}
    ''';
  }
}
