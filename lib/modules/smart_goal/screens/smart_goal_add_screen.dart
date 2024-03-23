import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/text_style_constants/general_text_style_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/helpers/text_style_helper.dart';
import 'package:finwise/core/helpers/ui_helper.dart';
import 'package:finwise/core/widgets/buttons/general_bottom_button.dart';
import 'package:finwise/core/widgets/buttons/general_outline_button.dart';
import 'package:finwise/modules/smart_goal/models/smart_goal_model.dart';
import 'package:finwise/modules/smart_goal/screens/smart_goal_create_screen.dart';
import 'package:finwise/modules/smart_goal/widgets/calendar_widget.dart';
import 'package:finwise/modules/smart_goal/widgets/forms/smart_goal_form_item.dart';
import 'package:finwise/modules/smart_goal/widgets/smart_goal_form_layout.dart';
import 'package:finwise/modules/smart_goal/widgets/smart_goal_prediction.dart';
import 'package:flutter/material.dart';

class SmartGoalAddScreen extends StatefulWidget {
  const SmartGoalAddScreen({super.key});

  @override
  State<SmartGoalAddScreen> createState() => _SmartGoalAddScreenState();
}

class _SmartGoalAddScreenState extends State<SmartGoalAddScreen> {
  late double _amount = 0;
  late double _currentSaved = 0;

  @override
  void initState() {
    super.initState();
    _amountController.addListener(() {
      if (_amountController.text.isNotEmpty) {
        setState(() {
          _amount = double.parse(_amountController.text);
        });
      } else {
        setState(() {
          _amount = 0;
        });
      }
    });
    _currentSaveController.addListener(() {
      if (_currentSaveController.text.isNotEmpty) {
        setState(() {
          _currentSaved = double.parse(_currentSaveController.text);
          if (_currentSaved > _amount) {
            _currentSaved = _amount;
          }
        });
      } else {
        setState(() {
          _currentSaved = 0;
        });
      }
    });
    _contributionController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SmartGoalFormLayout(
      title: 'Add Smart Goal',
      showTopProgress: true,
      formSection: _buildForm(),
    );
  }

  // -------------------- Form Section --------------------
  int _sectionIndex = 0;

  Widget _buildForm() {
    List sections = [
      _buildBasicInfoPart(),
      _buildGoalTargetPart(),
    ];
    return sections[_sectionIndex];
  }

  // -------------------- Basic Info --------------------
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _currentSaveController = TextEditingController(text: '0.0');
  final _contributionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _nameError = false;

  Widget _buildBasicInfoPart() {
    late final leftToSaveController =
        TextEditingController(text: (_amount - _currentSaved).toString());

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SmartGoalFormItem(
                    label: 'Name you goal',
                    controller: _nameController,
                    validator: _validator,
                  ),
                  Visibility(
                    visible: _nameError,
                    child: Text('Required'),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                          child: SmartGoalFormItem(
                        label: 'Goal Amount',
                        controller: _amountController,
                        isNumber: true,
                        validator: _validator,
                      )),
                      const SizedBox(width: 8),
                      Expanded(
                          child: SmartGoalFormItem(
                        label: 'Saved so far',
                        controller: _currentSaveController,
                        isNumber: true,
                        validator: _validator,
                      )),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: SmartGoalFormItem(
                          color: const Color(0xffD3D5E4),
                          label: 'Left to Save',
                          controller: leftToSaveController,
                          readOnly: true,
                          isNumber: true,
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          GeneralBottomButton(
            allowPressing: _isBasicInfoValid,
            onButtonTap: () {
              if (_nameController.text.isEmpty) {
                setState(() {
                  _nameError = true;
                });
              } else {
                setState(() {
                  _nameError = false;
                });
              }
              if (_isBasicInfoValid) {
                setState(() {
                  _sectionIndex = _sectionIndex + 1;
                });
              }
            },
            buttonLabel: 'Continue',
          ),
        ],
      ),
    );
  }

  bool get _isBasicInfoValid =>
      _nameController.text.isNotEmpty && _amountController.text.isNotEmpty;

  String? _validator(value) {
    if (value == null || value.isEmpty) {
      return 'Required';
    }
    return null;
  }

  // -------------------- Goal Target --------------------
  bool _setDue = true;
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  DateTime _selectedStartDay = DateTime.now(); // save value for posting
  DateTime _selectedEndDay = DateTime.now();

  Widget _buildGoalTargetPart() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
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
                      Expanded(
                          child: _buildDate(
                        hintText: 'Start Date',
                        controller: _startDateController,
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            _startDateController.text =
                                UIHelper.getInputDate(selectedDay.toString());
                            _selectedStartDay = selectedDay;
                          });
                        },
                      )),
                      const SizedBox(width: 8),
                      Expanded(
                          child: _buildDate(
                        hintText: 'End Date',
                        controller: _endDateController,
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            _endDateController.text =
                                UIHelper.getInputDate(selectedDay.toString());
                            _selectedEndDay = selectedDay;
                          });
                        },
                      )),
                    ],
                  ),
                ),
                Visibility(
                  visible: !_setDue,
                  child: Column(
                    children: [
                      SmartGoalFormItem(
                        label: 'Monthly Contribution',
                        isNumber: true,
                        controller: _contributionController,
                      ),
                      const SizedBox(height: 20),
                      const SmartGoalPrediction(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: GeneralOutlineButton(
                onButtonTap: () =>
                    setState(() => _sectionIndex = _sectionIndex - 1),
                buttonLabel: 'Back',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GeneralBottomButton(
                allowPressing: _isGoalTargetValid,
                onButtonTap: () async {
                  String? startDate;
                  String? endDate;
                  double? monthlyContribution;

                  if (_setDue) {
                    startDate = UIHelper.getDateFormat(
                        _selectedStartDay.toString(), 'yyyy-MM-dd');
                    endDate = UIHelper.getDateFormat(
                        _selectedEndDay.toString(), 'yyyy-MM-dd');
                    monthlyContribution = null;
                  } else {
                    startDate = null;
                    endDate = null;
                    monthlyContribution = double.parse(
                        _contributionController.text.isEmpty
                            ? '0'
                            : _contributionController.text);
                  }

                  bool success = false;

                  if (_isGoalTargetValid) {
                    success = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SmartGoalCreateScreen(
                          smartGoalData: SmartGoalData(
                            name: _nameController.text,
                            amount: double.parse(_amountController.text),
                            currentSave:
                                double.parse(_currentSaveController.text),
                            remainingSave:
                                double.parse(_amountController.text) -
                                    double.parse(_currentSaveController.text),
                            setDate: _setDue,
                            startDate: startDate,
                            endDate: endDate,
                            monthlyContribution: monthlyContribution,
                          ),
                        ),
                      ),
                    );
                  }

                  // bool success = await context.read<SmartGoalStore>().post(
                  //       SmartGoalData(
                  //         name: _nameController.text,
                  //         amount: double.parse(_amountController.text),
                  //         currentSave:
                  //             double.parse(_currentSaveController.text),
                  //         remainingSave: double.parse(_amountController.text) -
                  //             double.parse(_currentSaveController.text),
                  //         setDate: _setDue,
                  //         startDate: startDate,
                  //         endDate: endDate,
                  //         monthlyContribution: monthlyContribution,
                  //       ),
                  //     );
                  if (success) {
                    Navigator.pop(context);
                  }
                },
                buttonLabel: 'Create',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDate({
    String hintText = '',
    TextEditingController? controller,
    required void Function(DateTime selectedDay, DateTime focusedDay)
        onDaySelected,
  }) {
    return TextFormField(
      controller: controller,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CalendarWidget(
              onDaySelected: onDaySelected,
            ),
          ),
        );
      },
      style: TextStyleHelper.getw500size(14),
      readOnly: true,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
        fillColor: Colors.white,
        filled: true,
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: IconHelper.getSVG(
            SVGName.calendar,
            color: ColorConstant.mainText,
          ),
        ),
        hintText: hintText,
        hintStyle: GeneralTextStyle.getSize(12, color: ColorConstant.thin),
      ),
    );
  }

  bool get _isGoalTargetValid =>
      _setDue &&
          _startDateController.text.isNotEmpty &&
          _endDateController.text.isNotEmpty ||
      !_setDue && _contributionController.text.isNotEmpty;
}
