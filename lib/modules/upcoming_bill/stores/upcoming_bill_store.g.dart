// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upcoming_bill_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UpcomingBillStore on _UpcomingBillStoreBase, Store {
  late final _$upcomingBillAtom =
      Atom(name: '_UpcomingBillStoreBase.upcomingBill', context: context);

  @override
  UpcomingBill get upcomingBill {
    _$upcomingBillAtom.reportRead();
    return super.upcomingBill;
  }

  @override
  set upcomingBill(UpcomingBill value) {
    _$upcomingBillAtom.reportWrite(value, super.upcomingBill, () {
      super.upcomingBill = value;
    });
  }

  late final _$statusAtom =
      Atom(name: '_UpcomingBillStoreBase.status', context: context);

  @override
  LoadingStatusEnum get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(LoadingStatusEnum value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  late final _$readAsyncAction =
      AsyncAction('_UpcomingBillStoreBase.read', context: context);

  @override
  Future<dynamic> read() {
    return _$readAsyncAction.run(() => super.read());
  }

  @override
  String toString() {
    return '''
upcomingBill: ${upcomingBill},
status: ${status}
    ''';
  }
}
