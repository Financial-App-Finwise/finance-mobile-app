import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/constants/text_style_constants/financial_text_style_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/widgets/general_bottom_button.dart';
import 'package:flutter/material.dart';

class FinanceUpdateScreen extends StatefulWidget {
  const FinanceUpdateScreen({super.key});

  @override
  State<FinanceUpdateScreen> createState() => _FinanceUpdateScreenState();
}

class _FinanceUpdateScreenState extends State<FinanceUpdateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.zero)),
            icon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: IconHelper.getSVG(SVGName.close),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Update Balance',
                            style: FiancialTextStyle.updateBalanceTitle)
                      ],
                    ),
                  ),
                  GeneralBottomButton(
                      onButtonTap: () {}, buttonLabel: 'Update Balance'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
