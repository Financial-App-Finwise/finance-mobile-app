import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/modules/onboarding_question/models/budgeting_model.dart';
import 'package:finwise/modules/onboarding_question/models/radio_button_model.dart';
import 'package:finwise/modules/onboarding_question/models/spending_model.dart';
import 'package:finwise/modules/onboarding_question/stores/onboarding_question_store.dart';
import 'package:finwise/modules/onboarding_question/widgets/budgeting/main_budgeting.dart';
import 'package:finwise/modules/onboarding_question/widgets/budgeting/start_budgeting.dart';
import 'package:finwise/modules/onboarding_question/widgets/continue_button.dart';
import 'package:finwise/modules/onboarding_question/widgets/finance_snapshots/main_finance_snapshot.dart';
import 'package:finwise/modules/onboarding_question/widgets/finance_snapshots/start_finance_snapshot.dart';
import 'package:finwise/modules/onboarding_question/widgets/onboarding_header.dart';
import 'package:finwise/modules/onboarding_question/widgets/personal_questions/main_personal_question.dart';
import 'package:finwise/modules/onboarding_question/widgets/personal_questions/start_personal_questions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnboardingQuestionMainScreen extends StatefulWidget {
  final VoidCallback startPage;

  const OnboardingQuestionMainScreen({
    super.key,
    required this.startPage,
  });

  @override
  State<OnboardingQuestionMainScreen> createState() =>
      _OnboardingQuestionMainScreenState();
}

class _OnboardingQuestionMainScreenState
    extends State<OnboardingQuestionMainScreen> {
  late OnboardingQuestionStore store = context.read<OnboardingQuestionStore>();

  int _currentIndex = 1;

  // Index and max page for personal questions
  int _personalQuestionIndex = 1;
  final int _personalQuestionPage = 4;

  // Index and max page for financial snapshot
  int _financialSnapShotIndex = 1;
  final int _financialSnapShotPage = 4;

  // Index and max page for budgeting
  int _budgetingIndex = 1;
  final int _budgetingPage = 4;

  void nextPage() {
    if (_currentIndex != 2 && _currentIndex != 4 && _currentIndex != 6) {
      setState(() {
        _currentIndex += 1;
      });
    } else if (_currentIndex == 2) {
      if (_personalQuestionIndex < _personalQuestionPage) {
        setState(() {
          _personalQuestionIndex += 1;
        });
      } else {
        setState(() {
          _currentIndex += 1;
        });
      }
    } else if (_currentIndex == 4) {
      if (_financialSnapShotIndex < _financialSnapShotPage) {
        setState(() {
          _financialSnapShotIndex += 1;
        });
      } else {
        setState(() {
          _currentIndex += 1;
        });
      }
    } else if (_currentIndex == 6) {
      if (_budgetingIndex < _budgetingPage) {
        setState(() {
          _budgetingIndex += 1;
        });
      } else {
        setState(() {
          _currentIndex += 1;
        });
      }
    }
  }

  void previousPage() {
    if (_currentIndex <= 1) {
      widget.startPage();
    } else if (_currentIndex != 2 && _currentIndex != 4 && _currentIndex != 6) {
      setState(() {
        _currentIndex -= 1;
      });
    } else if (_currentIndex == 2) {
      if (_personalQuestionIndex > 1) {
        setState(() {
          _personalQuestionIndex -= 1;
        });
      } else {
        setState(() {
          _currentIndex -= 1;
        });
      }
    } else if (_currentIndex == 4) {
      if (_financialSnapShotIndex > 1) {
        setState(() {
          _financialSnapShotIndex -= 1;
        });
      } else {
        setState(() {
          _currentIndex -= 1;
        });
      }
    } else if (_currentIndex == 6) {
      if (_budgetingIndex > 1) {
        setState(() {
          _budgetingIndex -= 1;
        });
      } else {
        setState(() {
          _currentIndex -= 1;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      body: SafeArea(
        child: Container(
          height: fullHeight,
          child: Column(
            children: [
              OnboardingHeader(previousPage: previousPage),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 8),
                  alignment: Alignment.topCenter,
                  width: double.infinity,
                  child: AnimatedSwitcher(
                    duration: const Duration(microseconds: 500),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return ScaleTransition(
                        scale: animation,
                        child: child,
                      );
                    },
                    child: _getCurrentWidget(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Personal questions
  RadioButtonModel _gender = RadioButtonModel();
  TextEditingController _age = TextEditingController();
  RadioButtonModel _martialStatus = RadioButtonModel();
  RadioButtonModel _profession = RadioButtonModel();

  // Financial snapshots
  TextEditingController _netWorth = TextEditingController();
  TextEditingController _expenseController = TextEditingController();
  late final SpendingModel _expense = SpendingModel(
    type: 'Daily',
    controller: _expenseController,
  );
  TextEditingController _incomeController = TextEditingController();
  late final SpendingModel _income = SpendingModel(
    type: 'Daily',
    controller: _incomeController,
  );

  // Budgeting
  BudgetingModel _budgeting = BudgetingModel();

  Widget _getCurrentWidget() {
    switch (_currentIndex) {
      case 1:
        return StartPersonalQuestion(
          nextPage: nextPage,
        );
      case 2:
        return MainPersonalQuestion(
          previousPage: previousPage,
          nextPage: nextPage,
          currentPage: _personalQuestionIndex,
          maxPage: _personalQuestionPage,
          selectedGender: _gender,
          selectGender: (gender) {
            setState(() {
              _gender = gender;
            });
          },
          ageController: _age,
          selectedMartialStatus: _martialStatus,
          selectMartialStatus: (martialStatus) {
            setState(() {
              _martialStatus = martialStatus;
            });
          },
          selectedProfression: _profession,
          selectProfression: (profression) {
            setState(() {
              _profession = profression;
            });
          },
        );
      case 3:
        return StartFinanceSnapshot(
          nextPage: nextPage,
        );
      case 4:
        return MainFinanceSnapshot(
          previousPage: previousPage,
          nextPage: nextPage,
          currentPage: _financialSnapShotIndex,
          maxPage: _financialSnapShotPage,
          netWorth: _netWorth,
          expense: _expense,
          income: _income,
        );
      case 5:
        return StartBudgeting(nextPage: nextPage);
      case 6:
        return MainBudgeting(
          previousPage: previousPage,
          nextPage: nextPage,
          currentPage: _budgetingIndex,
          maxPage: _budgetingPage,
          income: _income,
          budgeting: _budgeting,
        );
      default:
        return Container();
    }
  }
}
