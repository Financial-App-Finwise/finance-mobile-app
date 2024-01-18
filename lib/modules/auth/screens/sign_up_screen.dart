import 'package:finwise/core/constants/auth_text_style_constant.dart';
import 'package:finwise/modules/auth/layouts/auth_screen_layout.dart';
import 'package:finwise/modules/auth/screens/sign_in_screen.dart';
import 'package:finwise/modules/auth/widgets/auth_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/font_constant.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return AuthScreenLayout(
      title: 'Create Account',
      subtitle: 'Please enter your email and password to sign up',
      buttonLabel: 'Sign up',
      bottomContent: _buildBottomContent(),
      isFormFilled: _isFormFilled,
      formArea: _buildTextFields(),
    );
  }

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  Color formColor = Color(0xffF2F3F7);

  Widget _buildTextFields() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextLabel(text: 'Email'),
          FormWidget(
            hintText: 'Email',
            prefixIcon:
                Icon(Icons.email_outlined, color: ColorConstant.mainText),
            controller: _emailController,
            onChanged: (value) => setState(() => _isFormFilled),
          ),
          SizedBox(height: 24),
          _buildTextLabel(text: 'Password'),
          FormWidget(
            hintText: 'Password',
            prefixIcon: Icon(Icons.lock_outline, color: ColorConstant.mainText),
            controller: _passwordController,
            onChanged: (value) => setState(() => _isFormFilled),
          ),
        ],
      ),
    );
  }

  Widget _buildTextLabel({required String text}) {
    return Container(
      padding: EdgeInsets.only(left: 8, bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: ColorConstant.mainText,
          fontFamily: FontConstant.primary,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  bool get _isFormFilled =>
      _emailController.value.text.isNotEmpty &&
      _passwordController.value.text.isNotEmpty;

  Widget _buildBottomContent() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'I agree to Finwise ',
                style: AuthScreenTextStyle.medium,
              ),
              Text(
                'Terms and Policy.',
                style: AuthScreenTextStyle.boldLink,
              ),
            ],
          ),
          SizedBox(height: 48),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Already have an account? ',
                  style: AuthScreenTextStyle.regular),
              InkWell(
                child: Text(
                  'Sign In',
                  style: AuthScreenTextStyle.boldLink,
                ),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => SignInScreen()));
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
