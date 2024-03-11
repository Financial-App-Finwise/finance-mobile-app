import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/helpers/text_style_helper.dart';
import 'package:finwise/core/widgets/circular_progress/circular_progress_two_arches.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  final Widget icon;
  final String title;
  final String description;

  const LoadingScreen({
    super.key,
    required this.icon,
    this.title = '',
    this.description = '',
  });

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
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
              child: SizedBox(
                width: 90,
                height: 90,
                child: widget.icon,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.title,
              style:
                  TextStyleHelper.getw700size(20, color: ColorConstant.primary),
            ),
            const SizedBox(height: 16),
            Text(
              widget.description,
              textAlign: TextAlign.center,
              style: TextStyleHelper.getw400size(16,
                  color: ColorConstant.mainText),
            ),
            const SizedBox(height: 16),
            const CircularProgressIndicatorTwoArcs(),
          ],
        ),
      ),
    );
  }
}
