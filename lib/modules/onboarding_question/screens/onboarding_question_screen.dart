import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/modules/onboarding_question/screens/onboarding_question_main_screen.dart';
import 'package:finwise/modules/onboarding_question/stores/onboarding_question_store.dart';
import 'package:finwise/modules/onboarding_question/widgets/start_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnboardingQuestionScreen extends StatefulWidget {
  const OnboardingQuestionScreen({super.key});

  @override
  State<OnboardingQuestionScreen> createState() =>
      _OnboardingQuestionScreenState();
}

class _OnboardingQuestionScreenState extends State<OnboardingQuestionScreen> {
  late OnboardingQuestionStore store = context.read<OnboardingQuestionStore>();
  int _currentIndex = 0;

  void nextPage() {
    setState(() {
      _currentIndex += 1;
    });
  }

  void previousPage() => setState(() {
        _currentIndex -= 1;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AnimatedSwitcher(
            duration: const Duration(microseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(
                scale: animation,
                child: child,
              );
            },
            child: _getCurrentWidget(),
          ),
        ),
      ),
    );
  }

  Widget _getCurrentWidget() {
    switch (_currentIndex) {
      case 0:
        return StartPage(
          nextPage: nextPage,
        );
      case 1:
        return OnboardingQuestionMainScreen(
          startPage: previousPage,
        );
      default:
        return Container();
    }
  }
}
