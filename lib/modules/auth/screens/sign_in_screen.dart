import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/font_constant.dart';
import 'package:finwise/modules/auth/layouts/auth_screen_layout.dart';
import 'package:finwise/modules/auth/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return AuthScreenLayout(
      // appBar: ,
      title: 'Welcome Back',
      subtitle: 'Please enter your email and password to sign in',
      buttonLabel: 'Sign in',
      bottomContent: _buildBottomContent(),
    );
  }

  late TextTheme _textTheme = Theme.of(context).textTheme;

  Widget _buildBottomContent() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(value: true, onChanged: (value) {}),
                  Text(
                    'Remember me',
                    style: _textTheme.bodyMedium!.copyWith(
                      fontFamily: FontConstant.balooThambi2Medium,
                    ),
                  ),
                ],
              ),
              Text(
                'Forget Password?',
                style: _textTheme.bodyMedium!.copyWith(
                    fontFamily: FontConstant.balooThambi2Medium,
                    color: ColorConstant.boldLink),
              ),
            ],
          ),
          SizedBox(height: 48),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't have an account? ", style: _textTheme.bodyMedium),
              InkWell(
                child: Text(
                  'Sign Up',
                  style: _textTheme.bodyMedium!.copyWith(
                      fontFamily: FontConstant.balooThambi2Medium,
                      color: ColorConstant.boldLink),
                ),
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}