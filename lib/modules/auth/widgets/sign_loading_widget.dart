import 'package:finwise/core/constants/text_style_constants/auth_text_style_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:finwise/core/widgets/circular_progress/circular_progress_two_arches.dart';
import 'package:flutter/material.dart';

class SignLoadingWidget extends StatefulWidget {
  const SignLoadingWidget({super.key});

  @override
  State<SignLoadingWidget> createState() => _SignLoadingWidgetState();
}

class _SignLoadingWidgetState extends State<SignLoadingWidget> {
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
              child: IconConstant.getUser(),
            ),
            const SizedBox(height: 16),
            const Text('Just a moment', style: AuthScreenTextStyle.loadingTitle),
            const SizedBox(height: 16),
            const Text(
              'Please wait...\nWe are preparing for you...',
              textAlign: TextAlign.center,
              style: AuthScreenTextStyle.formLabel,
            ),
            const SizedBox(height: 16),
            // const SimpleCircularProgressBar(
            //   size: 50,
            //   progressStrokeWidth: 12,
            //   animationDuration: 3,
            //   backColor: Colors.white,
            //   progressColors: [
            //     Color(0xff75DBFF),
            //     Color(0xff22BAF4),
            //     Color(0xff00ADEF),
            //   ],
            // ),
            CircularProgressIndicatorTwoArcs(),
          ],
        ),
      ),
    );
  }
}
