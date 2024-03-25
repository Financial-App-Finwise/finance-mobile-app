import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/modules/auth/screens/sign_in_screen.dart';
import 'package:finwise/modules/onboarding_question/screens/onboarding_question_screen.dart';
import 'package:finwise/modules/onboarding_question/widgets/full_height_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          height: 40,
          color: ColorConstant.secondary,
        ),
        getStarted(),
      ],
    ));
  }

  Widget getStarted() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Image.asset(
            'assets/images/get_started.png',
            fit: BoxFit.fill,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Set up your personalized budget plan and take control of your money',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              height: 1.5,
              letterSpacing: 1,
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: navigateButton(),
        ),
      ],
    );
  }

  Widget navigateButton() {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const OnboardingQuestionScreen(),
              ),
            );
          },
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 24,
            ),
            decoration: BoxDecoration(
              color: ColorConstant.secondary,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: ColorConstant.secondary,
              ),
            ),
            child: const Text(
              'Get Started',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                letterSpacing: 1,
                color: ColorConstant.white,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SignInScreen(),
              ),
            );
          },
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 24,
            ),
            decoration: BoxDecoration(
              color: ColorConstant.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: ColorConstant.secondary,
              ),
            ),
            child: const Text(
              'I Already Have Account',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                letterSpacing: 1,
                color: ColorConstant.secondary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
