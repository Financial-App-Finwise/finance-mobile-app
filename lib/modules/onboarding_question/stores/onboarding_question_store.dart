import 'package:dio/dio.dart';
import 'package:finwise/core/enums/loading_status_enum.dart';
import 'package:finwise/core/services/api_service.dart';
import 'package:finwise/modules/categories/models/categories_model.dart';
import 'package:finwise/modules/onboarding_question/models/budgeting_model.dart';
import 'package:finwise/modules/onboarding_question/models/radio_button_model.dart';
import 'package:finwise/modules/onboarding_question/models/spending_model.dart';
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
  int personalQuestionMaxPage = 4;
  @observable
  int financialSnapshotIndex = 1;
  int financialSnapshotMaxPage = 4;
  @observable
  int budgetingIndex = 1;
  int budgetingMaxPage = 1;
  @observable
  int smartGoalIndex = 1;
  int smartGoalMaxPage = 4;
  @observable
  int accountCreationIndex = 1;
  int accountCreationMaxPage = 4;

  @action
  void nextPage() {
    if (currentIndex != 2 &&
        currentIndex != 4 &&
        currentIndex != 6 &&
        currentIndex != 8 &&
        currentIndex != 10) {
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
    } else if (currentIndex == 8) {
      if (smartGoalIndex < smartGoalMaxPage) {
        smartGoalIndex += 1;
      } else {
        currentIndex += 1;
      }
    } else if (currentIndex == 10) {
      if (accountCreationIndex < accountCreationMaxPage) {
        accountCreationIndex += 1;
      } else {
        currentIndex += 1;
      }
    }
  }

  void previousPage() {
    if (currentIndex <= 1) {
      mainIndex = 0;
    } else if (currentIndex != 2 &&
        currentIndex != 4 &&
        currentIndex != 6 &&
        currentIndex != 8 &&
        currentIndex != 10) {
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
    } else if (currentIndex == 8) {
      if (smartGoalIndex > 1) {
        smartGoalIndex -= 1;
      } else {
        currentIndex -= 1;
      }
    } else if (currentIndex == 10) {
      if (accountCreationIndex > 1) {
        accountCreationIndex -= 1;
      } else {
        currentIndex -= 1;
      }
    }
  }

  // Personal questions
  @observable
  RadioButtonModel gender = RadioButtonModel();
  @observable
  TextEditingController age = TextEditingController();
  @observable
  RadioButtonModel martialStatus = RadioButtonModel();
  @observable
  RadioButtonModel profression = RadioButtonModel();

  // Financial snapshots
  @observable
  TextEditingController networth = TextEditingController();
  @observable
  SpendingModel expense = SpendingModel();
  @observable
  SpendingModel income = SpendingModel();
  @observable
  ObservableList<CategoryData> categories = ObservableList();

  // Budgeting
  @observable
  late SpendingModel budgetingType = SpendingModel();
  @observable
  double housing = 0;
  @observable
  double food = 0;
  @observable
  double utilities = 0;

  // Smart goal
  @observable
  TextEditingController financialGoal = TextEditingController();
  @observable
  TextEditingController saveForGoal = TextEditingController();
  @observable
  int saveForGoalMoneyOption = 0;
  @observable
  TextEditingController goalDate = TextEditingController();
  @observable
  DateTime goalDateDay = DateTime.now();

  // Account creation
  @observable
  TextEditingController email = TextEditingController();
  @observable
  TextEditingController username = TextEditingController();
  @observable
  TextEditingController password = TextEditingController();
  @observable
  TextEditingController passwordConfirmation = TextEditingController();

  @action
  void setCategory(CategoryData category) {
    if (categories.contains(category)) {
      categories.remove(category);
    } else {
      categories.add(category);
    }
  }

  @action
  void setSaveForGoalMoneyOption(int value) {
    saveForGoalMoneyOption = value;
    saveForGoal.text = value.toString();
  }

  @computed
  double get incomeAmount {
    return moneyConverter(
      income.type,
      double.parse(income.controller.text),
    );
  }

  @computed
  double get incomeAfterBudget {
    double housingAmount = (housing * incomeAmount) / 100;
    double foodAmount = (food * incomeAmount) / 100;
    double utilitiesAmount = (utilities * incomeAmount) / 100;
    double totalBudgeting = moneyConverter(
        budgetingType.type, housingAmount + foodAmount + utilitiesAmount);

    return incomeAmount - totalBudgeting;
  }

  double moneyConverter(String type, double value) {
    switch (type) {
      case 'Weekly':
        return value * 4;
      case 'Daily':
        return value * 30;
      default:
        return value;
    }
  }

  @observable
  LoadingStatusEnum loadingStatus = LoadingStatusEnum.none;

  // Create onboarding quesitons
  @action
  Future<bool> post(Map<String, dynamic> data) async {
    debugPrint('--> START: post, onboarding questions');
    loadingStatus = LoadingStatusEnum.loading;
    bool success = false;

    try {
      Response response = await ApiService.dio.post(
        'onboardinginfo/create',
        data: data,
      );
    } catch (e) {
      debugPrint('${e.runtimeType}: ${e.toString()}');
      success = false;
      loadingStatus = LoadingStatusEnum.error;
    } finally {
      debugPrint('<-- END: post, finance');
    }

    return success;
  }
}
