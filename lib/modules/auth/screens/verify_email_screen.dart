import 'package:finwise/modules/auth/layouts/auth_screen_layout.dart';
import 'package:finwise/modules/auth/models/user_post_model/user_post_model.dart';
import 'package:finwise/modules/auth/widgets/sign_loading_widget.dart';
import 'package:finwise/modules/auth/stores/auth_store.dart';
import 'package:finwise/modules/auth/widgets/auth_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({
    super.key,
    this.changeScreen,
  });

  final void Function()? changeScreen;

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  late AuthStore authStore = context.read<AuthStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return authStore.isLoading
          ? const SignLoadingWidget()
          : AuthScreenLayout(
              title: "You've got the mail",
              subtitle:
                  'We have sent the verification code to your email address. Check your email and enter the code below.',
              formArea: _buildTextFields(),
              bottomContent: const SizedBox(),
              buttonLabel: 'Verify',
              isFormFilled: _isFormFilled(),
              onButtonTap: _verify,
            );
    });
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  Widget _buildTextFields() {
    return Column(
      children: [
        FormWidget(
          hintText: 'Enter your email',
          controller: _emailController,
          prefixIcon: const SizedBox(),
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
          prefixIcon:const SizedBox(),
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
      Navigator.pop(context);
      // if (widget.changeScreen != null) {
      //   widget.changeScreen!();
      // }
    }
    Navigator.pop(context);
  }
}
