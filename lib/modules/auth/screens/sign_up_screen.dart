import 'package:email_validator/email_validator.dart';
import 'package:finwise/core/constants/auth_text_style_constant.dart';
import 'package:finwise/modules/auth/layouts/auth_screen_layout.dart';
import 'package:finwise/modules/auth/models/user_post_model/user_post_model.dart';
import 'package:finwise/modules/auth/screens/sign_in_screen.dart';
import 'package:finwise/modules/auth/widgets/sign_loading_widget.dart';
import 'package:finwise/modules/auth/stores/auth_store.dart';
import 'package:finwise/modules/auth/widgets/auth_form_widget.dart';
import 'package:finwise/route.dart';
import 'package:flutter/material.dart';
import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/font_constant.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({
    super.key,
    this.changeScreen,
  });

  void Function()? changeScreen;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    AuthStore authStore = context.read<AuthStore>();

    return Observer(builder: (context) {
      return authStore.isLoading
          ? SignLoadingWidget()
          : AuthScreenLayout(
              title: 'Create Account',
              subtitle: 'Please enter your email and password to sign up',
              buttonLabel: 'Sign up',
              bottomContent: _buildBottomContent(),
              isFormFilled: _isFormFilled,
              formArea: _buildTextFields(),
              onButtonTap: () async {
                if (_formKey.currentState!.validate()) {
                  bool success = await authStore.signUp(
                    UserPost(
                      name: _nameController.text,
                      email: _emailController.text,
                      password: _passwordController.text,
                      passwordConfirmation: _passwordConfirmController.text,
                    ),
                  );
                  if (success) {
                    if (success) {
                      Navigator.pushNamed(context, RouteName.verifyEmail);
                    } else {}
                  }
                }
              },
            );
    });
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  Color formColor = const Color(0xffF2F3F7);

  final _formKey = GlobalKey<FormState>();

  Widget _buildTextFields() {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextLabel(text: 'Name'),
            FormWidget(
                hintText: 'Name',
                prefixIcon:
                    Icon(Icons.lock_outline, color: ColorConstant.mainText),
                controller: _nameController,
                onChanged: (value) => setState(() => _isFormFilled),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                }),
            const SizedBox(height: 24),
            _buildTextLabel(text: 'Email'),
            FormWidget(
                hintText: 'Email',
                prefixIcon:
                    Icon(Icons.email_outlined, color: ColorConstant.mainText),
                controller: _emailController,
                onChanged: (value) => setState(() => _isFormFilled),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!EmailValidator.validate(value)) {
                    return 'Email must be a valid email';
                  }
                  return null;
                }),
            const SizedBox(height: 24),
            _buildTextLabel(text: 'Password'),
            FormWidget(
                hintText: 'Password',
                prefixIcon:
                    Icon(Icons.lock_outline, color: ColorConstant.mainText),
                obscureText: true,
                controller: _passwordController,
                onChanged: (value) => setState(() => _isFormFilled),
                validator: (value) {
                  if (value!.length < 8) {
                    return 'Password must be of length at least 8';
                  }
                  return null;
                }),
            const SizedBox(height: 24),
            _buildTextLabel(text: 'Confirm Password'),
            FormWidget(
                hintText: 'Confirm Password',
                prefixIcon:
                    Icon(Icons.lock_outline, color: ColorConstant.mainText),
                obscureText: true,
                controller: _passwordConfirmController,
                onChanged: (value) => setState(() => _isFormFilled),
                validator: (value) {
                  if (value! != _passwordController.text) {
                    return 'Passwords are not the same';
                  }
                  return null;
                }),
          ],
        ),
      ),
    );
  }

  Widget _buildTextLabel({required String text}) {
    return Container(
      padding: const EdgeInsets.only(left: 8, bottom: 8),
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
      _nameController.value.text.isNotEmpty &&
      _emailController.value.text.isNotEmpty &&
      _passwordController.value.text.isNotEmpty &&
      _passwordConfirmController.text.isNotEmpty;

  Widget _buildBottomContent() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 12),
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
          const SizedBox(height: 48),
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
                  // Navigator.of(context).pushReplacementNamed(RouteName.signIn);
                  if (widget.changeScreen != null) {
                    widget.changeScreen!();
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
