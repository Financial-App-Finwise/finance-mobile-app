import 'package:finwise/core/constants/auth_text_style_constant.dart';
import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/modules/auth/layouts/auth_screen_layout.dart';
import 'package:finwise/modules/auth/screens/sign_up_screen.dart';
import 'package:finwise/modules/auth/widgets/auth_form_widget.dart';
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
      isFormFilled: _isFormFilled,
      formArea: _buildTextFields(),
    );
  }

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Widget _buildTextFields() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextLabel(text: 'Email'),
          FormWidget(
            hintText: 'Email',
            controller: _emailController,
            prefixIcon:
                Icon(Icons.email_outlined, color: ColorConstant.mainText),
            onChanged: (value) => setState(() => _isFormFilled),
          ),
          SizedBox(height: 24),
          _buildTextLabel(text: 'Password'),
          FormWidget(
            obscureText: true,
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
        style: AuthScreenTextStyle.formLabel,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(value: true, onChanged: (value) {}),
                  Text(
                    'Remember me',
                    style: AuthScreenTextStyle.medium,
                  ),
                ],
              ),
              Text(
                'Forget Password?',
                style: AuthScreenTextStyle.boldLink,
              ),
            ],
          ),
          SizedBox(height: 48),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't have an account? ",
                  style: AuthScreenTextStyle.regular),
              InkWell(
                child: Text(
                  'Sign Up',
                  style: AuthScreenTextStyle.boldLink,
                ),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()));
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
