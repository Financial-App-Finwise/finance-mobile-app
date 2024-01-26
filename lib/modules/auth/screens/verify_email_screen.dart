import 'package:finwise/modules/auth/layouts/auth_screen_layout.dart';
import 'package:finwise/modules/auth/models/user_post_model/user_post_model.dart';
import 'package:finwise/modules/auth/widgets/sign_loading_widget.dart';
import 'package:finwise/modules/auth/stores/auth_store.dart';
import 'package:finwise/modules/auth/widgets/auth_form_widget.dart';
import 'package:finwise/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class VerifyEmailScreen extends StatefulWidget {
  VerifyEmailScreen({
    super.key,
    this.changeScreen,
  });

  void Function()? changeScreen;

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  late AuthStore authStore = context.read<AuthStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return authStore.isLoading
          ? SignLoadingWidget()
          : AuthScreenLayout(
              title: "You've got the mail",
              subtitle:
                  'We have sent the verification code to your email address. Check your email and enter the code below.',
              formArea: _buildTextFields(),
              bottomContent: SizedBox(),
              buttonLabel: 'Verify',
              isFormFilled: _isFormFilled(),
              onButtonTap: _verify,
            );
    });
  }

  TextEditingController _emailController = TextEditingController();
  TextEditingController _codeController = TextEditingController();

  Widget _buildTextFields() {
    return Column(
      children: [
        FormWidget(
          hintText: 'Enter your email',
          controller: _emailController,
          prefixIcon: SizedBox(),
          onChanged: (value) {
            setState(() {
              _isFormFilled();
            });
          },
          onEditingComplete: _verify,
        ),
        const SizedBox(height: 24),
        FormWidget(
          hintText: 'Enter your code',
          controller: _codeController,
          prefixIcon: SizedBox(),
          onChanged: (value) {
            setState(() {
              _isFormFilled();
            });
          },
          onEditingComplete: _verify,
        ),
      ],
    );
  }

  bool _isFormFilled() => _codeController.text.isNotEmpty;

  Future _verify() async {
    bool success = await authStore.verifyEmail(
      model: VerifyEmailModel(
        email: _emailController.text,
        code: _codeController.text,
      ),
    );
    if (success) {
      // Navigator.pushReplacementNamed(context, RouteName.signIn);
      if (widget.changeScreen != null) {
        widget.changeScreen!();
      }
    }
  }
}
