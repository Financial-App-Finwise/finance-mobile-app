import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/constants/text_style_constants/financial_text_style_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/widgets/general_bottom_button.dart';
import 'package:finwise/modules/finance/stores/finance_store.dart';
import 'package:finwise/route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FinanceUpdateScreen extends StatefulWidget {
  const FinanceUpdateScreen({super.key});

  @override
  State<FinanceUpdateScreen> createState() => _FinanceUpdateScreenState();
}

class _FinanceUpdateScreenState extends State<FinanceUpdateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: _buildBody(),
      ),
    );
  }

  final TextEditingController _balanceController = TextEditingController();

  Widget _buildBody() {
    return SafeArea(
      child: Container(
        color: ColorConstant.backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero)),
              icon: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: IconHelper.getSVG(SVGName.close),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Update Balance',
                              style: FiancialTextStyle.updateBalanceTitle),
                          const SizedBox(height: 40),
                          // ----- Text Field ------
                          Row(
                            children: [
                              InkWell(
                                onTap: () => Navigator.pushNamed(
                                    context, RouteName.currency),
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14, horizontal: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8,
                                          horizontal: 12,
                                        ),
                                        decoration: const BoxDecoration(
                                          color: ColorConstant.secondary,
                                          shape: BoxShape.circle,
                                        ),
                                        child: IconHelper.getSVG(
                                          SVGName.dollar,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      const Icon(Icons.keyboard_arrow_down,
                                          color: ColorConstant.thin),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: TextFormField(
                                    controller: _balanceController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    GeneralBottomButton(
                      onButtonTap: () async {
                        await context
                            .read<FinanceStore>()
                            .update(double.parse(_balanceController.text));
                      },
                      buttonLabel: 'Update Balance',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
