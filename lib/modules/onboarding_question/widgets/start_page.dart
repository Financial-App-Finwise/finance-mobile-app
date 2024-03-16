import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/modules/onboarding_question/widgets/continue_button.dart';
import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  final VoidCallback nextPage;

  const StartPage({
    super.key,
    required this.nextPage,
  });

  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;
    return Container(
      height: fullHeight,
      child: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconHelper.getSVGDefault(
                    SVGName.pandaStartPage,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Hi there, I am your personal financial coach.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      letterSpacing: 1,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ContinueButton(nextPage: nextPage),
        ],
      ),
    );
  }
}
