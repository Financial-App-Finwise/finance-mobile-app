import 'package:finwise/core/constants/text_style_constants/auth_text_style_constant.dart';
import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/modules/auth/layouts/auth_screen_layout.dart';
import 'package:finwise/modules/auth/models/user_post_model/user_post_model.dart';
import 'package:finwise/modules/auth/screens/auth_loading_data_screen.dart';
import 'package:finwise/modules/auth/widgets/sign_loading_widget.dart';
import 'package:finwise/modules/auth/stores/auth_store.dart';
import 'package:finwise/modules/auth/widgets/auth_form_widget.dart';
import 'package:finwise/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({
    super.key,
    this.changeScreen,
  });

  final void Function()? changeScreen;

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late final AuthStore authStore = context.read<AuthStore>();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const SignLoadingWidget()
        : AuthScreenLayout(
            // appBar: ,
            title: 'Welcome Back',
            subtitle: 'Please enter your email and password to sign in',
            buttonLabel: 'Sign in',
            bottomContent: _buildBottomContent(),
            isFormFilled: _isFormFilled,
            formArea: _buildTextFields(),
            onButtonTap: () async {
              setState(() {
                _loading = true;
              });
              bool success = await authStore.signIn(
                UserSignIn(
                  email: _emailController.text,
                  password: _passwordController.text,
                ),
              );

              if (success) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const AuthLoadingDataScreen()));
              }
            },
          );
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Widget _buildTextFields() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextLabel(text: 'Email'),
          FormWidget(
            hintText: 'Email',
            controller: _emailController,
            prefixIcon:
                const Icon(Icons.email_outlined, color: ColorConstant.mainText),
            onChanged: (value) => setState(() => _isFormFilled),
          ),
          const SizedBox(height: 24),
          _buildTextLabel(text: 'Password'),
          FormWidget(
            obscureText: true,
            hintText: 'Password',
            prefixIcon:
                const Icon(Icons.lock_outline, color: ColorConstant.mainText),
            controller: _passwordController,
            onChanged: (value) => setState(() => _isFormFilled),
          ),
        ],
      ),
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
      _emailController.value.text.isNotEmpty &&
      _passwordController.value.text.isNotEmpty;

  Widget _buildBottomContent() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Observer(
                    builder: (context) {
                      return Checkbox(
                        value: authStore.rememberMe,
                        onChanged: (value) => authStore.toggleRememberMe(),
                      );
                    },
                  ),
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
          const SizedBox(height: 48),
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
                  Navigator.of(context).pushReplacementNamed(RouteName.signUp);
                },
              ),
            ],
          ),
          InkWell(
            child: Text(
              'Verify Email',
              style: AuthScreenTextStyle.boldLink,
            ),
            onTap: () {
              Navigator.of(context).pushNamed(RouteName.verifyEmail);
            },
          ),
        ],
      ),
    );
  }
}
