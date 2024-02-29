import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/widgets/custom_progess_bar.dart';
import 'package:finwise/modules/onboarding_question/models/radio_button_model.dart';
import 'package:finwise/modules/onboarding_question/widgets/continue_button.dart';
import 'package:finwise/modules/onboarding_question/widgets/custom_row_radio_button.dart';
import 'package:flutter/material.dart';

class MainFinanceSnapshot extends StatefulWidget {
  final VoidCallback previousPage;
  final VoidCallback nextPage;
  final int currentPage;
  final int maxPage;

  // Net worth
  final void Function(RadioButtonModel) selectNetWorth;
  final RadioButtonModel selectedNetWorth;

  const MainFinanceSnapshot({
    super.key,
    required this.previousPage,
    required this.nextPage,
    required this.currentPage,
    required this.maxPage,
    required this.selectNetWorth,
    required this.selectedNetWorth,
  });

  @override
  State<MainFinanceSnapshot> createState() => _MainFinanceSnapshotState();
}

class _MainFinanceSnapshotState extends State<MainFinanceSnapshot> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: CustomProgressBar(
                        value: widget.currentPage / widget.maxPage,
                        gradient1: ColorConstant.secondary,
                        gradient2: ColorConstant.primary,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: AnimatedSwitcher(
                          duration: const Duration(microseconds: 500),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return ScaleTransition(
                              scale: animation,
                              child: child,
                            );
                          },
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: _getCurrentWidget(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ContinueButton(nextPage: widget.nextPage)
          ],
        ),
      ),
    );
  }

  Widget _getCurrentWidget() {
    switch (widget.currentPage) {
      case 1:
        return _netWorth();
      default:
        return Container();
    }
  }

  Widget _netWorth() {
    return Column(
      children: [
        CustomRowRadioButton(
          setButton: widget.selectNetWorth,
          question: 'question',
          list: [
            RadioButtonModel('USD'),
            RadioButtonModel('KHR'),
          ],
          selectedButton: widget.selectedNetWorth,
        ),
      ],
    );
  }
}
