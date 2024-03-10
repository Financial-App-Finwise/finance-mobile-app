import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/constants/text_style_constants/financial_text_style_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/widgets/buttons/general_bottom_button.dart';
import 'package:finwise/modules/finance/screens/finance_update_screen.dart';
import 'package:finwise/modules/finance/stores/finance_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class FinanceEditScreen extends StatefulWidget {
  const FinanceEditScreen({super.key});

  @override
  State<FinanceEditScreen> createState() => _FinanceEditScreenState();
}

class _FinanceEditScreenState extends State<FinanceEditScreen> {
  late final store = context.read<FinanceStore>();
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

  late final _balanceController =
      TextEditingController(text: store.dollarAccount.totalbalance.toString());

  Widget _buildBody() {
    return Observer(builder: (context) {
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
                            // ---------- Text Field -----------
                            _buildAmountTextField(),
                          ],
                        ),
                      ),
                      GeneralBottomButton(
                        onButtonTap: () async {
                          bool success = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => FinanceUpdateScreen(
                                totalBalance:
                                    double.parse(_balanceController.text),
                              ),
                            ),
                          );
                          if (success) {
                            Navigator.pop(context);
                          }
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
    });
  }

  Widget _buildAmountTextField() {
    return Row(
      children: [
        InkWell(
          // onTap: () => Navigator.pushNamed(context, RouteName.currency),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
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
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextFormField(
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,}')),
              ],
              controller: _balanceController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
