// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upcoming_bill_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UpcomingBillStore on _UpcomingBillStoreBase, Store {
  Computed<DateTime>? _$endDateComputed;

  @override
  DateTime get endDate =>
      (_$endDateComputed ??= Computed<DateTime>(() => super.endDate,
              name: '_UpcomingBillStoreBase.endDate'))
          .value;
  Computed<String>? _$queryParameterComputed;

  @override
  String get queryParameter =>
      (_$queryParameterComputed ??= Computed<String>(() => super.queryParameter,
              name: '_UpcomingBillStoreBase.queryParameter'))
          .value;

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

  late final _$startDateAtom =
      Atom(name: '_UpcomingBillStoreBase.startDate', context: context);

  @override
  DateTime get startDate {
    _$startDateAtom.reportRead();
    return super.startDate;
  }

  @override
  set startDate(DateTime value) {
    _$startDateAtom.reportWrite(value, super.startDate, () {
      super.startDate = value;
    });
  }

  late final _$filterAtom =
      Atom(name: '_UpcomingBillStoreBase.filter', context: context);

  @override
  UpcomingBillFilterEnum get filter {
    _$filterAtom.reportRead();
    return super.filter;
  }

  @override
  set filter(UpcomingBillFilterEnum value) {
    _$filterAtom.reportWrite(value, super.filter, () {
      super.filter = value;
    });
  }

  late final _$upcomingBillYearlyAtom =
      Atom(name: '_UpcomingBillStoreBase.upcomingBillYearly', context: context);

  @override
  ObservableMap<String, UpcomingBillMonth> get upcomingBillYearly {
    _$upcomingBillYearlyAtom.reportRead();
    return super.upcomingBillYearly;
  }

  @override
  set upcomingBillYearly(ObservableMap<String, UpcomingBillMonth> value) {
    _$upcomingBillYearlyAtom.reportWrite(value, super.upcomingBillYearly, () {
      super.upcomingBillYearly = value;
    });
  }

  late final _$yearlyStatusAtom =
      Atom(name: '_UpcomingBillStoreBase.yearlyStatus', context: context);

  @override
  LoadingStatusEnum get yearlyStatus {
    _$yearlyStatusAtom.reportRead();
    return super.yearlyStatus;
  }

  @override
  set yearlyStatus(LoadingStatusEnum value) {
    _$yearlyStatusAtom.reportWrite(value, super.yearlyStatus, () {
      super.yearlyStatus = value;
    });
  }

  late final _$totalUpcomingBillsAtom =
      Atom(name: '_UpcomingBillStoreBase.totalUpcomingBills', context: context);

  @override
  int get totalUpcomingBills {
    _$totalUpcomingBillsAtom.reportRead();
    return super.totalUpcomingBills;
  }

  bool _totalUpcomingBillsIsInitialized = false;

  @override
  set totalUpcomingBills(int value) {
    _$totalUpcomingBillsAtom.reportWrite(value,
        _totalUpcomingBillsIsInitialized ? super.totalUpcomingBills : null, () {
      super.totalUpcomingBills = value;
      _totalUpcomingBillsIsInitialized = true;
    });
  }

  late final _$currentPageAtom =
      Atom(name: '_UpcomingBillStoreBase.currentPage', context: context);

  @override
  int get currentPage {
    _$currentPageAtom.reportRead();
    return super.currentPage;
  }

  @override
  set currentPage(int value) {
    _$currentPageAtom.reportWrite(value, super.currentPage, () {
      super.currentPage = value;
    });
  }

  late final _$createStatusAtom =
      Atom(name: '_UpcomingBillStoreBase.createStatus', context: context);

  @override
  LoadingStatusEnum get createStatus {
    _$createStatusAtom.reportRead();
    return super.createStatus;
  }

  @override
  set createStatus(LoadingStatusEnum value) {
    _$createStatusAtom.reportWrite(value, super.createStatus, () {
      super.createStatus = value;
    });
  }

  late final _$editStatusAtom =
      Atom(name: '_UpcomingBillStoreBase.editStatus', context: context);

  @override
  LoadingStatusEnum get editStatus {
    _$editStatusAtom.reportRead();
    return super.editStatus;
  }

  @override
  set editStatus(LoadingStatusEnum value) {
    _$editStatusAtom.reportWrite(value, super.editStatus, () {
      super.editStatus = value;
    });
  }

  late final _$readYearlyAsyncAction =
      AsyncAction('_UpcomingBillStoreBase.readYearly', context: context);

  @override
  Future<dynamic> readYearly() {
    return _$readYearlyAsyncAction.run(() => super.readYearly());
  }

  late final _$readAsyncAction =
      AsyncAction('_UpcomingBillStoreBase.read', context: context);

  @override
  Future<dynamic> read({bool refreshed = false}) {
    return _$readAsyncAction.run(() => super.read(refreshed: refreshed));
  }

  late final _$postAsyncAction =
      AsyncAction('_UpcomingBillStoreBase.post', context: context);

  @override
  Future<bool> post(UpcomingBillData upcomingBillData) {
    return _$postAsyncAction.run(() => super.post(upcomingBillData));
  }

  late final _$editAsyncAction =
      AsyncAction('_UpcomingBillStoreBase.edit', context: context);

  @override
  Future<bool> edit(UpcomingBillData upcomingBillData) {
    return _$editAsyncAction.run(() => super.edit(upcomingBillData));
  }

  late final _$deleteAsyncAction =
      AsyncAction('_UpcomingBillStoreBase.delete', context: context);

  @override
  Future<bool> delete(UpcomingBillData upcomingBillData) {
    return _$deleteAsyncAction.run(() => super.delete(upcomingBillData));
  }

  late final _$_UpcomingBillStoreBaseActionController =
      ActionController(name: '_UpcomingBillStoreBase', context: context);

  @override
  void setLoadingStatus(LoadingStatusEnum status) {
    final _$actionInfo = _$_UpcomingBillStoreBaseActionController.startAction(
        name: '_UpcomingBillStoreBase.setLoadingStatus');
    try {
      return super.setLoadingStatus(status);
    } finally {
      _$_UpcomingBillStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addSelectedDateYear({bool addYear = true}) {
    final _$actionInfo = _$_UpcomingBillStoreBaseActionController.startAction(
        name: '_UpcomingBillStoreBase.addSelectedDateYear');
    try {
      return super.addSelectedDateYear(addYear: addYear);
    } finally {
      _$_UpcomingBillStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setStartDate(DateTime date) {
    final _$actionInfo = _$_UpcomingBillStoreBaseActionController.startAction(
        name: '_UpcomingBillStoreBase.setStartDate');
    try {
      return super.setStartDate(date);
    } finally {
      _$_UpcomingBillStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFilter(UpcomingBillFilterEnum type) {
    final _$actionInfo = _$_UpcomingBillStoreBaseActionController.startAction(
        name: '_UpcomingBillStoreBase.setFilter');
    try {
      return super.setFilter(type);
    } finally {
      _$_UpcomingBillStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNextPage() {
    final _$actionInfo = _$_UpcomingBillStoreBaseActionController.startAction(
        name: '_UpcomingBillStoreBase.setNextPage');
    try {
      return super.setNextPage();
    } finally {
      _$_UpcomingBillStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
upcomingBill: ${upcomingBill},
status: ${status},
startDate: ${startDate},
filter: ${filter},
upcomingBillYearly: ${upcomingBillYearly},
yearlyStatus: ${yearlyStatus},
totalUpcomingBills: ${totalUpcomingBills},
currentPage: ${currentPage},
createStatus: ${createStatus},
editStatus: ${editStatus},
endDate: ${endDate},
queryParameter: ${queryParameter}
    ''';
  }
}
