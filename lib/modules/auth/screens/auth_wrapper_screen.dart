import 'package:finwise/modules/auth/screens/sign_in_screen.dart';
import 'package:finwise/modules/auth/screens/sign_up_screen.dart';
import 'package:finwise/modules/auth/screens/verify_email_screen.dart';
import 'package:flutter/material.dart';

class AuthWrapperScreen extends StatefulWidget {
  const AuthWrapperScreen({super.key});

  @override
  State<AuthWrapperScreen> createState() => _AuthWrapperScreenState();
}

class _AuthWrapperScreenState extends State<AuthWrapperScreen> {
  @override
  Widget build(BuildContext context) {
    print('--> START: build auth screen');
    return Scaffold(
      body: _buildBody(),
    );
  }

  PageController _pageController = PageController();

  Widget _buildBody() {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: [
        SignInScreen(changeScreen: () {
          _pageController.jumpToPage(1);
        }),
        SignUpScreen(changeScreen: () {
          _pageController.jumpToPage(0);
        }),
        VerifyEmailScreen(changeScreen: () {
          _pageController.jumpToPage(0);
        }),
      ],
    );
  }
}
