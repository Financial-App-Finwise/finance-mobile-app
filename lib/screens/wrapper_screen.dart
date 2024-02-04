import 'package:finwise/modules/auth/models/user_model/user_model.dart';
import 'package:finwise/modules/auth/screens/auth_wrapper_screen.dart';
import 'package:finwise/modules/auth/stores/auth_store.dart';
import 'package:finwise/screens/index_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class WrapperScreen extends StatefulWidget {
  const WrapperScreen({super.key});

  @override
  State<WrapperScreen> createState() => _WrapperScreenState();
}

class _WrapperScreenState extends State<WrapperScreen> {
  // @override
  // void dispose() {
  //   debugPrint('--> START: dispose, wrapper screen');
  //   Future.delayed(Duration.zero, () async {
  //     if (context.read<AuthStore>().user != null) {
  //       if (!context.read<AuthStore>().rememberMe) {
  //         // if not remember me
  //         // sign out to remove the token
  //         await context.read<AuthStore>().signOut();
  //       }
  //     }
  //   });
  //   super.dispose();
  //   debugPrint('<-- END: dispose, wrapper screen');
  // }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      UserModel? user = context.watch<AuthStore>().user;
      if (user == null) {
        return AuthWrapperScreen();
      }
      return IndexScreen();
    });
  }
}
