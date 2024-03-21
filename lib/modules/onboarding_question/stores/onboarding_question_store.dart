import 'package:dio/dio.dart';
import 'package:finwise/core/enums/loading_status_enum.dart';
import 'package:finwise/core/services/api_service.dart';
import 'package:finwise/modules/categories/models/categories_model.dart';
import 'package:finwise/modules/categories/stores/category_store.dart';
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
  int smartGoalMaxPage = 3;
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

  @action
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
  Future<bool> post(List<CategoryData> cat) async {
    debugPrint('--> START: post, onboarding questions');
    loadingStatus = LoadingStatusEnum.loading;
    bool success = false;
    double monthlyExpense = moneyConverter(
      expense.type,
      double.parse(
        expense.controller.text,
      ),
    );
    double monthlyIncome = moneyConverter(
      income.type,
      double.parse(
        income.controller.text,
      ),
    );
    List<Map<String, int>> categoryList = [];
    for (var category in categories) {
      categoryList.add({'categoryID': category.id});
    }

    List<Map<String, dynamic>> parentCategories = [];
    for (var category in cat) {
      if (category.name == 'Houseware') {
        parentCategories.add(
          {
            'parentID': category.id,
            'amount': housing,
          },
        );
      }
      if (category.name == 'Food and Beverage') {
        parentCategories.add(
          {
            'parentID': category.id,
            'amount': food,
          },
        );
      }
      if (category.name == 'Bill & Utilities') {
        parentCategories.add(
          {
            'parentID': category.id,
            'amount': utilities,
          },
        );
      }
    }

    List<String> components = goalDate.text.split("/");
    String postDate = "${components[2]}-${components[1]}-${components[0]}";

    Map<String, dynamic> data = {
      "gender": gender.name,
      "age": int.parse(age.text),
      "marital_status": martialStatus.name,
      "life_stage": profression.name,
      "net_worth": double.parse(networth.text),
      "currencyID": 1,
      "monthly_expense": monthlyExpense,
      "monthly_income": monthlyIncome,
      "categories": categoryList,
      "parentCategories": parentCategories,
      "financial_goal": financialGoal.text,
      "dream_amount": saveForGoal.text,
      "envision_date": postDate,
    };

    print('lulz $data');

    try {
      Response response = await ApiService.dio.post(
        'onboardinginfo/create',
        data: data,
      );
      if (response.statusCode == 200) {
        success = true;
      }
    } catch (e) {
      debugPrint('${e.runtimeType}: ${e.toString()}');
      success = false;
      loadingStatus = LoadingStatusEnum.error;
    } finally {
      debugPrint('<-- END: post, onboarding questions');
    }

    return success;
  }
}
