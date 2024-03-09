import 'package:email_validator/email_validator.dart';
import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/text_style_constants/auth_text_style_constant.dart';
import 'package:finwise/core/widgets/custom_progess_bar.dart';
import 'package:finwise/modules/auth/widgets/auth_form_widget.dart';
import 'package:finwise/modules/onboarding_question/stores/onboarding_question_store.dart';
import 'package:finwise/modules/onboarding_question/widgets/continue_button.dart';
import 'package:finwise/modules/onboarding_question/widgets/custom_question_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class MainAccountCreation extends StatefulWidget {
  const MainAccountCreation({super.key});

  @override
  State<MainAccountCreation> createState() => _MainAccountCreationState();
}

class _MainAccountCreationState extends State<MainAccountCreation> {
  late OnboardingQuestionStore store = context.read<OnboardingQuestionStore>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: CustomProgressBar(
                        value: store.budgetingIndex / store.budgetingMaxPage,
                        gradient1: ColorConstant.secondary,
                        gradient2: ColorConstant.primary,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: AnimatedSwitcher(
                          duration: const Duration(microseconds: 500),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return ScaleTransition(
                              scale: animation,
                              child: child,
                            );
                          },
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: _getCurrentWidget(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ContinueButton(nextPage: store.nextPage)
          ],
        ),
      ),
    );
  }

  Widget _getCurrentWidget() {
    return Observer(builder: (context) {
      int accountCreationIndex = store.accountCreationIndex;

      switch (accountCreationIndex) {
        case 1:
          return _form();
        default:
          return Container();
      }
    });
  }

  Widget _form() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomQuestionText(text: 'Sign up'),
        const SizedBox(
          height: 32,
        ),
        _buildTextLabel(text: 'Name'),
        FormWidget(
          whiteBackground: true,
          hintText: 'Name',
          prefixIcon:
              const Icon(Icons.lock_outline, color: ColorConstant.mainText),
          controller: store.username,
          onChanged: (value) => setState(() => _isFormFilled),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your name';
            }
            return null;
          },
        ),
        const SizedBox(height: 24),
        _buildTextLabel(text: 'Email'),
        FormWidget(
          whiteBackground: true,
          hintText: 'Email',
          prefixIcon:
              const Icon(Icons.email_outlined, color: ColorConstant.mainText),
          controller: store.email,
          onChanged: (value) => setState(() => _isFormFilled),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            } else if (!EmailValidator.validate(value)) {
              return 'Email must be a valid email';
            }
            return null;
          },
        ),
        const SizedBox(height: 24),
        _buildTextLabel(text: 'Password'),
        FormWidget(
          whiteBackground: true,
          hintText: 'Password',
          prefixIcon:
              const Icon(Icons.lock_outline, color: ColorConstant.mainText),
          obscureText: true,
          controller: store.password,
          onChanged: (value) => setState(() => _isFormFilled),
          validator: (value) {
            if (value!.length < 8) {
              return 'Password must be of length at least 8';
            }
            return null;
          },
        ),
        const SizedBox(height: 24),
        _buildTextLabel(text: 'Confirm Password'),
        FormWidget(
          whiteBackground: true,
          hintText: 'Confirm Password',
          prefixIcon:
              const Icon(Icons.lock_outline, color: ColorConstant.mainText),
          obscureText: true,
          controller: store.passwordConfirmation,
          onChanged: (value) => setState(() => _isFormFilled),
          validator: (value) {
            if (value! != store.password.text) {
              return 'Passwords are not the same';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildTextLabel({required String text}) {
    return Container(
      padding: const EdgeInsets.only(left: 8, bottom: 8),
      child: Text(
        text,
        style: AuthScreenTextStyle.formLabel,
      ),
    );
  }

  bool get _isFormFilled =>
      store.email.value.text.isNotEmpty &&
      store.username.value.text.isNotEmpty &&
      store.password.value.text.isNotEmpty &&
      store.passwordConfirmation.value.text.isNotEmpty;
}
