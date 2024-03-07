// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_question_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OnboardingQuestionStore on _OnboardingQuestionStoreBase, Store {
  late final _$mainIndexAtom =
      Atom(name: '_OnboardingQuestionStoreBase.mainIndex', context: context);

  @override
  int get mainIndex {
    _$mainIndexAtom.reportRead();
    return super.mainIndex;
  }

  @override
  set mainIndex(int value) {
    _$mainIndexAtom.reportWrite(value, super.mainIndex, () {
      super.mainIndex = value;
    });
  }

  late final _$currentIndexAtom =
      Atom(name: '_OnboardingQuestionStoreBase.currentIndex', context: context);

  @override
  int get currentIndex {
    _$currentIndexAtom.reportRead();
    return super.currentIndex;
  }

  @override
  set currentIndex(int value) {
    _$currentIndexAtom.reportWrite(value, super.currentIndex, () {
      super.currentIndex = value;
    });
  }

  late final _$personalQuestionIndexAtom = Atom(
      name: '_OnboardingQuestionStoreBase.personalQuestionIndex',
      context: context);

  @override
  int get personalQuestionIndex {
    _$personalQuestionIndexAtom.reportRead();
    return super.personalQuestionIndex;
  }

  @override
  set personalQuestionIndex(int value) {
    _$personalQuestionIndexAtom.reportWrite(value, super.personalQuestionIndex,
        () {
      super.personalQuestionIndex = value;
    });
  }

  late final _$personalQuestionMaxPageAtom = Atom(
      name: '_OnboardingQuestionStoreBase.personalQuestionMaxPage',
      context: context);

  @override
  int get personalQuestionMaxPage {
    _$personalQuestionMaxPageAtom.reportRead();
    return super.personalQuestionMaxPage;
  }

  @override
  set personalQuestionMaxPage(int value) {
    _$personalQuestionMaxPageAtom
        .reportWrite(value, super.personalQuestionMaxPage, () {
      super.personalQuestionMaxPage = value;
    });
  }

  late final _$financialSnapshotIndexAtom = Atom(
      name: '_OnboardingQuestionStoreBase.financialSnapshotIndex',
      context: context);

  @override
  int get financialSnapshotIndex {
    _$financialSnapshotIndexAtom.reportRead();
    return super.financialSnapshotIndex;
  }

  @override
  set financialSnapshotIndex(int value) {
    _$financialSnapshotIndexAtom
        .reportWrite(value, super.financialSnapshotIndex, () {
      super.financialSnapshotIndex = value;
    });
  }

  late final _$financialSnapshotMaxPageAtom = Atom(
      name: '_OnboardingQuestionStoreBase.financialSnapshotMaxPage',
      context: context);

  @override
  int get financialSnapshotMaxPage {
    _$financialSnapshotMaxPageAtom.reportRead();
    return super.financialSnapshotMaxPage;
  }

  @override
  set financialSnapshotMaxPage(int value) {
    _$financialSnapshotMaxPageAtom
        .reportWrite(value, super.financialSnapshotMaxPage, () {
      super.financialSnapshotMaxPage = value;
    });
  }

  late final _$budgetingIndexAtom = Atom(
      name: '_OnboardingQuestionStoreBase.budgetingIndex', context: context);

  @override
  int get budgetingIndex {
    _$budgetingIndexAtom.reportRead();
    return super.budgetingIndex;
  }

  @override
  set budgetingIndex(int value) {
    _$budgetingIndexAtom.reportWrite(value, super.budgetingIndex, () {
      super.budgetingIndex = value;
    });
  }

  late final _$_OnboardingQuestionStoreBaseActionController =
      ActionController(name: '_OnboardingQuestionStoreBase', context: context);

  @override
  void nextPage() {
    final _$actionInfo = _$_OnboardingQuestionStoreBaseActionController
        .startAction(name: '_OnboardingQuestionStoreBase.nextPage');
    try {
      return super.nextPage();
    } finally {
      _$_OnboardingQuestionStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
mainIndex: ${mainIndex},
currentIndex: ${currentIndex},
personalQuestionIndex: ${personalQuestionIndex},
personalQuestionMaxPage: ${personalQuestionMaxPage},
financialSnapshotIndex: ${financialSnapshotIndex},
financialSnapshotMaxPage: ${financialSnapshotMaxPage},
budgetingIndex: ${budgetingIndex}
    ''';
  }
}
