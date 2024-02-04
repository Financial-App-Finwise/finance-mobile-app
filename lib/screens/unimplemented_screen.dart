import 'package:finwise/core/constants/auth_text_style_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:flutter/material.dart';

class UnimplementedScreen extends StatelessWidget {
  const UnimplementedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              width: 190,
              height: 190,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff75DBFF),
                      Color(0xff22BAF4),
                      Color(0xff00ADEF),
                    ],
                    stops: [0, 0.5, 1],
                  )),
              child: IconConstant.getBottomUser(),
            ),
            const SizedBox(height: 16),
            // Text('Just a moment', style: AuthScreenTextStyle.loadingTitle),
            const SizedBox(height: 16),
            const Text(
              'This function has not been developed yet.',
              textAlign: TextAlign.center,
              style: AuthScreenTextStyle.formLabel,
            ),
          ],
        ),
      ),
    );
  }
}
