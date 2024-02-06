// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_plan_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BudgetPlanStore on _BudgetPlanStoreBase, Store {
  late final _$budgetPlanAtom =
      Atom(name: '_BudgetPlanStoreBase.budgetPlan', context: context);

  @override
  BudgetPlan get budgetPlan {
    _$budgetPlanAtom.reportRead();
    return super.budgetPlan;
  }

  @override
  set budgetPlan(BudgetPlan value) {
    _$budgetPlanAtom.reportWrite(value, super.budgetPlan, () {
      super.budgetPlan = value;
    });
  }

  late final _$statusAtom =
      Atom(name: '_BudgetPlanStoreBase.status', context: context);

  @override
  LoadingStatus get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(LoadingStatus value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  late final _$readAsyncAction =
      AsyncAction('_BudgetPlanStoreBase.read', context: context);

  @override
  Future<dynamic> read() {
    return _$readAsyncAction.run(() => super.read());
  }

  @override
  String toString() {
    return '''
budgetPlan: ${budgetPlan},
status: ${status}
    ''';
  }
}
