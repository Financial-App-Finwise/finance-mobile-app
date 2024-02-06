// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smart_goal_ui_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SmartGoalUIStore on _SmartGoalUIStoreBase, Store {
  late final _$showGridAtom =
      Atom(name: '_SmartGoalUIStoreBase.showGrid', context: context);

  @override
  bool get showGrid {
    _$showGridAtom.reportRead();
    return super.showGrid;
  }

  @override
  set showGrid(bool value) {
    _$showGridAtom.reportWrite(value, super.showGrid, () {
      super.showGrid = value;
    });
  }

  late final _$_SmartGoalUIStoreBaseActionController =
      ActionController(name: '_SmartGoalUIStoreBase', context: context);

  @override
  void toggleShowGrid() {
    final _$actionInfo = _$_SmartGoalUIStoreBaseActionController.startAction(
        name: '_SmartGoalUIStoreBase.toggleShowGrid');
    try {
      return super.toggleShowGrid();
    } finally {
      _$_SmartGoalUIStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
showGrid: ${showGrid}
    ''';
  }
}
