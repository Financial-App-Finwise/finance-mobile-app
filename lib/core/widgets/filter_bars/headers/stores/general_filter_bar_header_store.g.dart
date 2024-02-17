// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_filter_bar_header_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FilterBarHeaderStore on _FilterBarHeaderStoreBase, Store {
  late final _$currentValueAtom =
      Atom(name: '_FilterBarHeaderStoreBase.currentValue', context: context);

  @override
  dynamic get currentValue {
    _$currentValueAtom.reportRead();
    return super.currentValue;
  }

  @override
  set currentValue(dynamic value) {
    _$currentValueAtom.reportWrite(value, super.currentValue, () {
      super.currentValue = value;
    });
  }

  late final _$_FilterBarHeaderStoreBaseActionController =
      ActionController(name: '_FilterBarHeaderStoreBase', context: context);

  @override
  void changeCurrentValue(dynamic value) {
    final _$actionInfo = _$_FilterBarHeaderStoreBaseActionController
        .startAction(name: '_FilterBarHeaderStoreBase.changeCurrentValue');
    try {
      return super.changeCurrentValue(value);
    } finally {
      _$_FilterBarHeaderStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentValue: ${currentValue}
    ''';
  }
}
