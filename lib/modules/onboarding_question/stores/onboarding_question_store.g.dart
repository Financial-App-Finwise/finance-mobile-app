// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_question_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OnboardingQuestionStore on _OnboardingQuestionStoreBase, Store {
  Computed<double>? _$incomeAmountComputed;

  @override
  double get incomeAmount =>
      (_$incomeAmountComputed ??= Computed<double>(() => super.incomeAmount,
              name: '_OnboardingQuestionStoreBase.incomeAmount'))
          .value;
  Computed<double>? _$incomeAfterBudgetComputed;

  @override
  double get incomeAfterBudget => (_$incomeAfterBudgetComputed ??=
          Computed<double>(() => super.incomeAfterBudget,
              name: '_OnboardingQuestionStoreBase.incomeAfterBudget'))
      .value;

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

  late final _$smartGoalIndexAtom = Atom(
      name: '_OnboardingQuestionStoreBase.smartGoalIndex', context: context);

  @override
  int get smartGoalIndex {
    _$smartGoalIndexAtom.reportRead();
    return super.smartGoalIndex;
  }

  @override
  set smartGoalIndex(int value) {
    _$smartGoalIndexAtom.reportWrite(value, super.smartGoalIndex, () {
      super.smartGoalIndex = value;
    });
  }

  late final _$accountCreationIndexAtom = Atom(
      name: '_OnboardingQuestionStoreBase.accountCreationIndex',
      context: context);

  @override
  int get accountCreationIndex {
    _$accountCreationIndexAtom.reportRead();
    return super.accountCreationIndex;
  }

  @override
  set accountCreationIndex(int value) {
    _$accountCreationIndexAtom.reportWrite(value, super.accountCreationIndex,
        () {
      super.accountCreationIndex = value;
    });
  }

  late final _$genderAtom =
      Atom(name: '_OnboardingQuestionStoreBase.gender', context: context);

  @override
  RadioButtonModel get gender {
    _$genderAtom.reportRead();
    return super.gender;
  }

  @override
  set gender(RadioButtonModel value) {
    _$genderAtom.reportWrite(value, super.gender, () {
      super.gender = value;
    });
  }

  late final _$ageAtom =
      Atom(name: '_OnboardingQuestionStoreBase.age', context: context);

  @override
  TextEditingController get age {
    _$ageAtom.reportRead();
    return super.age;
  }

  @override
  set age(TextEditingController value) {
    _$ageAtom.reportWrite(value, super.age, () {
      super.age = value;
    });
  }

  late final _$martialStatusAtom = Atom(
      name: '_OnboardingQuestionStoreBase.martialStatus', context: context);

  @override
  RadioButtonModel get martialStatus {
    _$martialStatusAtom.reportRead();
    return super.martialStatus;
  }

  @override
  set martialStatus(RadioButtonModel value) {
    _$martialStatusAtom.reportWrite(value, super.martialStatus, () {
      super.martialStatus = value;
    });
  }

  late final _$profressionAtom =
      Atom(name: '_OnboardingQuestionStoreBase.profression', context: context);

  @override
  RadioButtonModel get profression {
    _$profressionAtom.reportRead();
    return super.profression;
  }

  @override
  set profression(RadioButtonModel value) {
    _$profressionAtom.reportWrite(value, super.profression, () {
      super.profression = value;
    });
  }

  late final _$networthAtom =
      Atom(name: '_OnboardingQuestionStoreBase.networth', context: context);

  @override
  TextEditingController get networth {
    _$networthAtom.reportRead();
    return super.networth;
  }

  @override
  set networth(TextEditingController value) {
    _$networthAtom.reportWrite(value, super.networth, () {
      super.networth = value;
    });
  }

  late final _$expenseAtom =
      Atom(name: '_OnboardingQuestionStoreBase.expense', context: context);

  @override
  SpendingModel get expense {
    _$expenseAtom.reportRead();
    return super.expense;
  }

  @override
  set expense(SpendingModel value) {
    _$expenseAtom.reportWrite(value, super.expense, () {
      super.expense = value;
    });
  }

  late final _$incomeAtom =
      Atom(name: '_OnboardingQuestionStoreBase.income', context: context);

  @override
  SpendingModel get income {
    _$incomeAtom.reportRead();
    return super.income;
  }

  @override
  set income(SpendingModel value) {
    _$incomeAtom.reportWrite(value, super.income, () {
      super.income = value;
    });
  }

  late final _$categoriesAtom =
      Atom(name: '_OnboardingQuestionStoreBase.categories', context: context);

  @override
  ObservableList<CategoryData> get categories {
    _$categoriesAtom.reportRead();
    return super.categories;
  }

  @override
  set categories(ObservableList<CategoryData> value) {
    _$categoriesAtom.reportWrite(value, super.categories, () {
      super.categories = value;
    });
  }

  late final _$budgetingTypeAtom = Atom(
      name: '_OnboardingQuestionStoreBase.budgetingType', context: context);

  @override
  SpendingModel get budgetingType {
    _$budgetingTypeAtom.reportRead();
    return super.budgetingType;
  }

  bool _budgetingTypeIsInitialized = false;

  @override
  set budgetingType(SpendingModel value) {
    _$budgetingTypeAtom.reportWrite(
        value, _budgetingTypeIsInitialized ? super.budgetingType : null, () {
      super.budgetingType = value;
      _budgetingTypeIsInitialized = true;
    });
  }

  late final _$housingAtom =
      Atom(name: '_OnboardingQuestionStoreBase.housing', context: context);

  @override
  double get housing {
    _$housingAtom.reportRead();
    return super.housing;
  }

  @override
  set housing(double value) {
    _$housingAtom.reportWrite(value, super.housing, () {
      super.housing = value;
    });
  }

  late final _$foodAtom =
      Atom(name: '_OnboardingQuestionStoreBase.food', context: context);

  @override
  double get food {
    _$foodAtom.reportRead();
    return super.food;
  }

  @override
  set food(double value) {
    _$foodAtom.reportWrite(value, super.food, () {
      super.food = value;
    });
  }

  late final _$utilitiesAtom =
      Atom(name: '_OnboardingQuestionStoreBase.utilities', context: context);

  @override
  double get utilities {
    _$utilitiesAtom.reportRead();
    return super.utilities;
  }

  @override
  set utilities(double value) {
    _$utilitiesAtom.reportWrite(value, super.utilities, () {
      super.utilities = value;
    });
  }

  late final _$financialGoalAtom = Atom(
      name: '_OnboardingQuestionStoreBase.financialGoal', context: context);

  @override
  TextEditingController get financialGoal {
    _$financialGoalAtom.reportRead();
    return super.financialGoal;
  }

  @override
  set financialGoal(TextEditingController value) {
    _$financialGoalAtom.reportWrite(value, super.financialGoal, () {
      super.financialGoal = value;
    });
  }

  late final _$saveForGoalAtom =
      Atom(name: '_OnboardingQuestionStoreBase.saveForGoal', context: context);

  @override
  TextEditingController get saveForGoal {
    _$saveForGoalAtom.reportRead();
    return super.saveForGoal;
  }

  @override
  set saveForGoal(TextEditingController value) {
    _$saveForGoalAtom.reportWrite(value, super.saveForGoal, () {
      super.saveForGoal = value;
    });
  }

  late final _$saveForGoalMoneyOptionAtom = Atom(
      name: '_OnboardingQuestionStoreBase.saveForGoalMoneyOption',
      context: context);

  @override
  int get saveForGoalMoneyOption {
    _$saveForGoalMoneyOptionAtom.reportRead();
    return super.saveForGoalMoneyOption;
  }

  @override
  set saveForGoalMoneyOption(int value) {
    _$saveForGoalMoneyOptionAtom
        .reportWrite(value, super.saveForGoalMoneyOption, () {
      super.saveForGoalMoneyOption = value;
    });
  }

  late final _$goalDateAtom =
      Atom(name: '_OnboardingQuestionStoreBase.goalDate', context: context);

  @override
  TextEditingController get goalDate {
    _$goalDateAtom.reportRead();
    return super.goalDate;
  }

  @override
  set goalDate(TextEditingController value) {
    _$goalDateAtom.reportWrite(value, super.goalDate, () {
      super.goalDate = value;
    });
  }

  late final _$goalDateDayAtom =
      Atom(name: '_OnboardingQuestionStoreBase.goalDateDay', context: context);

  @override
  DateTime get goalDateDay {
    _$goalDateDayAtom.reportRead();
    return super.goalDateDay;
  }

  @override
  set goalDateDay(DateTime value) {
    _$goalDateDayAtom.reportWrite(value, super.goalDateDay, () {
      super.goalDateDay = value;
    });
  }

  late final _$emailAtom =
      Atom(name: '_OnboardingQuestionStoreBase.email', context: context);

  @override
  TextEditingController get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(TextEditingController value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$usernameAtom =
      Atom(name: '_OnboardingQuestionStoreBase.username', context: context);

  @override
  TextEditingController get username {
    _$usernameAtom.reportRead();
    return super.username;
  }

  @override
  set username(TextEditingController value) {
    _$usernameAtom.reportWrite(value, super.username, () {
      super.username = value;
    });
  }

  late final _$passwordAtom =
      Atom(name: '_OnboardingQuestionStoreBase.password', context: context);

  @override
  TextEditingController get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(TextEditingController value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  late final _$passwordConfirmationAtom = Atom(
      name: '_OnboardingQuestionStoreBase.passwordConfirmation',
      context: context);

  @override
  TextEditingController get passwordConfirmation {
    _$passwordConfirmationAtom.reportRead();
    return super.passwordConfirmation;
  }

  @override
  set passwordConfirmation(TextEditingController value) {
    _$passwordConfirmationAtom.reportWrite(value, super.passwordConfirmation,
        () {
      super.passwordConfirmation = value;
    });
  }

  late final _$loadingStatusAtom = Atom(
      name: '_OnboardingQuestionStoreBase.loadingStatus', context: context);

  @override
  LoadingStatusEnum get loadingStatus {
    _$loadingStatusAtom.reportRead();
    return super.loadingStatus;
  }

  @override
  set loadingStatus(LoadingStatusEnum value) {
    _$loadingStatusAtom.reportWrite(value, super.loadingStatus, () {
      super.loadingStatus = value;
    });
  }

  late final _$postAsyncAction =
      AsyncAction('_OnboardingQuestionStoreBase.post', context: context);

  @override
  Future<bool> post(List<CategoryData> cat) {
    return _$postAsyncAction.run(() => super.post(cat));
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
  void setCategory(CategoryData category) {
    final _$actionInfo = _$_OnboardingQuestionStoreBaseActionController
        .startAction(name: '_OnboardingQuestionStoreBase.setCategory');
    try {
      return super.setCategory(category);
    } finally {
      _$_OnboardingQuestionStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSaveForGoalMoneyOption(int value) {
    final _$actionInfo =
        _$_OnboardingQuestionStoreBaseActionController.startAction(
            name: '_OnboardingQuestionStoreBase.setSaveForGoalMoneyOption');
    try {
      return super.setSaveForGoalMoneyOption(value);
    } finally {
      _$_OnboardingQuestionStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  double moneyConverter(String type, double value) {
    final _$actionInfo = _$_OnboardingQuestionStoreBaseActionController
        .startAction(name: '_OnboardingQuestionStoreBase.moneyConverter');
    try {
      return super.moneyConverter(type, value);
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
financialSnapshotIndex: ${financialSnapshotIndex},
budgetingIndex: ${budgetingIndex},
smartGoalIndex: ${smartGoalIndex},
accountCreationIndex: ${accountCreationIndex},
gender: ${gender},
age: ${age},
martialStatus: ${martialStatus},
profression: ${profression},
networth: ${networth},
expense: ${expense},
income: ${income},
categories: ${categories},
budgetingType: ${budgetingType},
housing: ${housing},
food: ${food},
utilities: ${utilities},
financialGoal: ${financialGoal},
saveForGoal: ${saveForGoal},
saveForGoalMoneyOption: ${saveForGoalMoneyOption},
goalDate: ${goalDate},
goalDateDay: ${goalDateDay},
email: ${email},
username: ${username},
password: ${password},
passwordConfirmation: ${passwordConfirmation},
loadingStatus: ${loadingStatus},
incomeAmount: ${incomeAmount},
incomeAfterBudget: ${incomeAfterBudget}
    ''';
  }
}
