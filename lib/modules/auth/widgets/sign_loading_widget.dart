import 'package:custom_circular_progress/custom_circular_progress.dart';
import 'package:custom_circular_progress/utils.dart';
import 'package:finwise/core/constants/auth_text_style_constant.dart';
import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:flutter/material.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

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
              decoration: BoxDecoration(
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
            SizedBox(height: 16),
            Text('Just a moment', style: AuthScreenTextStyle.loadingTitle),
            SizedBox(height: 16),
            Text(
              'Please wait...\nWe are preparing for you...',
              textAlign: TextAlign.center,
              style: AuthScreenTextStyle.formLabel,
            ),
            SizedBox(height: 16),
            SimpleCircularProgressBar(
              size: 50,
              progressStrokeWidth: 12,
              animationDuration: 3,
              backColor: Colors.white,
              progressColors: [
                Color(0xff75DBFF),
                Color(0xff22BAF4),
                Color(0xff00ADEF),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
