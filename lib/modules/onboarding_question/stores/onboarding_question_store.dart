import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'onboarding_question_store.g.dart';

class OnboardingQuestionStore = _OnboardingQuestionStoreBase
    with _$OnboardingQuestionStore;

abstract class _OnboardingQuestionStoreBase with Store {
  // Changing pages
  @observable
  int mainIndex = 0;
  @observable
  int currentIndex = 1;
  @observable
  int personalQuestionIndex = 1;
  @observable
  int personalQuestionMaxPage = 4;
  @observable
  int financialSnapshotIndex = 1;
  @observable
  int financialSnapshotMaxPage = 1;
  @observable
  int budgetingIndex = 1;
  int budgetingMaxPage = 4;

  @action
  void nextPage() {
    if (currentIndex != 2 && currentIndex != 4 && currentIndex != 6) {
      currentIndex += 1;
    } else if (currentIndex == 2) {
      if (personalQuestionIndex < personalQuestionMaxPage) {
        personalQuestionIndex += 1;
      } else {
        currentIndex += 1;
      }
    } else if (currentIndex == 4) {
      if (financialSnapshotIndex < financialSnapshotMaxPage) {
        financialSnapshotIndex += 1;
      } else {
        currentIndex += 1;
      }
    } else if (currentIndex == 6) {
      if (budgetingIndex < budgetingMaxPage) {
        budgetingIndex += 1;
      } else {
        currentIndex += 1;
      }
    }
    print('llll $currentIndex');
  }

  void previousPage() {
    if (currentIndex <= 1) {
      mainIndex = 0;
    } else if (currentIndex != 2 && currentIndex != 4 && currentIndex != 6) {
      currentIndex -= 1;
    } else if (currentIndex == 2) {
      if (personalQuestionIndex > 1) {
        personalQuestionIndex -= 1;
      } else {
        currentIndex -= 1;
      }
    } else if (currentIndex == 4) {
      if (financialSnapshotIndex > 1) {
        financialSnapshotIndex -= 1;
      } else {
        currentIndex -= 1;
      }
    } else if (currentIndex == 6) {
      if (budgetingIndex > 1) {
        budgetingIndex -= 1;
      } else {
        currentIndex -= 1;
      }
    }
  }
}
