// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duration_drop_down_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DurationDropDownStore on _DurationDropDownStoreBase, Store {
  late final _$itemsAtom =
      Atom(name: '_DurationDropDownStoreBase.items', context: context);

  @override
  List<Map<String, String>> get items {
    _$itemsAtom.reportRead();
    return super.items;
  }

  @override
  set items(List<Map<String, String>> value) {
    _$itemsAtom.reportWrite(value, super.items, () {
      super.items = value;
    });
  }

  late final _$selectedValueAtom =
      Atom(name: '_DurationDropDownStoreBase.selectedValue', context: context);

  @override
  String get selectedValue {
    _$selectedValueAtom.reportRead();
    return super.selectedValue;
  }

  @override
  set selectedValue(String value) {
    _$selectedValueAtom.reportWrite(value, super.selectedValue, () {
      super.selectedValue = value;
    });
  }

  late final _$_DurationDropDownStoreBaseActionController =
      ActionController(name: '_DurationDropDownStoreBase', context: context);

  @override
  void setValue(String value) {
    final _$actionInfo = _$_DurationDropDownStoreBaseActionController
        .startAction(name: '_DurationDropDownStoreBase.setValue');
    try {
      return super.setValue(value);
    } finally {
      _$_DurationDropDownStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
items: ${items},
selectedValue: ${selectedValue}
    ''';
  }
}
