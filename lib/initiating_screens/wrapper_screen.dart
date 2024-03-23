import 'package:finwise/modules/auth/models/user_model/user_model.dart';
import 'package:finwise/modules/auth/stores/auth_store.dart';
import 'package:finwise/initiating_screens/index_screen.dart';
import 'package:finwise/modules/onboarding_question/screens/onboarding_question_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

// handle between the authentication part and the index screen
class WrapperScreen extends StatefulWidget {
  const WrapperScreen({super.key});

  @override
  State<WrapperScreen> createState() => _WrapperScreenState();
}

class _WrapperScreenState extends State<WrapperScreen> {
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      UserModel? user = context.watch<AuthStore>().user;
      if (user == null) {
        return const OnboardingQuestionScreen();
      }
      return const IndexScreen();
    });
  }
}
