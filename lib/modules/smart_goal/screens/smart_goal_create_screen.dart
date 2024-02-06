import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/text_style_constants/general_text_style_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/widgets/custom_progess_bar.dart';
import 'package:finwise/core/widgets/general_bottom_button.dart';
import 'package:finwise/modules/smart_goal/models/smart_goal_model.dart';
import 'package:finwise/modules/smart_goal/stores/smart_goal_store.dart';
import 'package:finwise/modules/smart_goal/widgets/smart_goal_prediction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddSmartGoalScreen extends StatefulWidget {
  const AddSmartGoalScreen({super.key});

  @override
  State<AddSmartGoalScreen> createState() => _AddSmartGoalScreenState();
}

class _AddSmartGoalScreenState extends State<AddSmartGoalScreen> {
  final double _progressBar = 0.5;

  @override
  void initState() {
    super.initState();
    _contributionController.text = '\$0';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorConstant.backgroundColor,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _titleContent(),
                const SizedBox(height: 10),
                _mainContentDescription(),
                const SizedBox(height: 20),
                Expanded(child: _buildForm()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _titleContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => TestGradientSVG()));
                  },
                  icon: IconHelper.getSVG(SVGName.close),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.all(0),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: CustomProgressBar(
                  value: _progressBar,
                  color: ColorConstant.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _mainContentDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Add Smart Goal',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 32,
            letterSpacing: 1,
            color: ColorConstant.black,
          ),
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 72,
              height: 72,
              child: IconHelper.getGradientSVG(SVGName.smartGoal,
                  gradient: const LinearGradient(colors: [
                    ColorConstant.smartGoalLight,
                    ColorConstant.smartGoalThick,
                  ])),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Setup and track your smart goal to achieve your saving and stress free.',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.75,
                  height: 1.5,
                  color: ColorConstant.mainText,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Text(
          'Input below information',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            letterSpacing: 0.75,
            color: ColorConstant.mainText,
          ),
        ),
      ],
    );
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _currentSaveController = TextEditingController();
  final TextEditingController _contributionController = TextEditingController();

  bool _setDue = true;

  int _sectionIndex = 0;

  Widget _buildForm() {
    List sections = [
      _buildBasicInfoPart(),
      _buildTargetGoalPart(),
    ];
    return sections[_sectionIndex];
  }

  Widget _buildBasicInfoPart() {
    return Form(
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: ColorConstant.backgroundColor,
              child: Column(
                children: [
                  _buildFormItem(
                    label: 'Name you goal',
                    controller: _nameController,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                          child: _buildFormItem(
                        label: 'Goal Amount',
                        controller: _amountController,
                        isNumber: true,
                      )),
                      const SizedBox(width: 8),
                      Expanded(
                          child: _buildFormItem(
                        label: 'Saved so far',
                        controller: _currentSaveController,
                        isNumber: true,
                      )),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: _buildFormItem(
                            color: const Color(0xffD3D5E4),
                            label: 'Monthly Contribution',
                            controller: _contributionController,
                            readOnly: true),
                      ),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                ],
              ),
            ),
          ),
          GeneralBottomButton(
            onButtonTap: () => setState(() => _sectionIndex = 1),
            buttonLabel: 'Continue',
          ),
        ],
      ),
    );
  }

  Widget _buildFormItem({
    String label = '',
    isNumber = false,
    TextEditingController? controller,
    bool readOnly = false,
    Color color = Colors.white,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(label,
          //     style: GeneralTextStyle.getSize(12, color: ColorConstant.thin)),
          TextFormField(
            readOnly: readOnly,
            controller: controller,
            keyboardType: isNumber ? TextInputType.number : null,
            inputFormatters: isNumber
                ? [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,2}')),
                  ]
                : null,
            style: GeneralTextStyle.getSize(14),
            decoration: InputDecoration(
              prefix: isNumber ? const Text('\$') : const SizedBox(),
              isDense: true,
              border: InputBorder.none,
              // hintText: '0',
              label: Text(label),
              floatingLabelStyle:
                  GeneralTextStyle.getSize(14, color: ColorConstant.thin),
              labelStyle:
                  GeneralTextStyle.getSize(12, color: ColorConstant.thin),
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTargetGoalPart() {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: RadioMenuButton(
                      value: true,
                      groupValue: _setDue,
                      onChanged: (value) => setState(() => _setDue = true),
                      child: const Text('Set'),
                    ),
                  ),
                  Expanded(
                    child: RadioMenuButton(
                      value: false,
                      groupValue: _setDue,
                      onChanged: (value) => setState(() => _setDue = false),
                      child: const Text("Don't Set"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Visibility(
                visible: _setDue,
                child: Row(
                  children: [
                    Expanded(child: _buildDropDown()),
                    const SizedBox(width: 8),
                    Expanded(child: _buildDropDown()),
                  ],
                ),
              ),
              Visibility(
                visible: !_setDue,
                child: Column(
                  children: [
                    _buildFormItem(
                      label: 'Monthly Contribution',
                      isNumber: true,
                    ),
                    const SizedBox(height: 20),
                    const SmartGoalPrediction(),
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: GeneralBottomButton(
                onButtonTap: () => setState(() => _sectionIndex = 0),
                buttonLabel: 'Back',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GeneralBottomButton(
                onButtonTap: () {
                  context.read<SmartGoalStore>().post(
                        SmartGoalData(
                          userID: context.read<SmartGoalStore>().userID,
                          name: _nameController.text,
                          amount: double.parse(_amountController.text),
                          currentSave:
                              double.parse(_currentSaveController.text),
                          setDate: _setDue,
                        ),
                      );
                },
                buttonLabel: 'Create',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDropDown() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Month',
                style: GeneralTextStyle.getSize(12, color: ColorConstant.thin)
                    .copyWith(fontWeight: FontWeight.w400)),
            Text('Nov', style: GeneralTextStyle.getSize(14)),
          ],
        ),
        buttonStyleData: ButtonStyleData(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 20,
            )),
        items: const [],
        onChanged: (value) {},
      ),
    );
  }
}
