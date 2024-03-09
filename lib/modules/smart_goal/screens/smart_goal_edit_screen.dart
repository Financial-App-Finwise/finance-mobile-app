import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/constants/text_style_constants/general_text_style_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/helpers/text_style_helper.dart';
import 'package:finwise/core/helpers/ui_helper.dart';
import 'package:finwise/core/widgets/buttons/general_bottom_button.dart';
import 'package:finwise/modules/smart_goal/models/smart_goal_model.dart';
import 'package:finwise/modules/smart_goal/stores/smart_goal_store.dart';
import 'package:finwise/modules/smart_goal/widgets/calendar_widget.dart';
import 'package:finwise/modules/smart_goal/widgets/forms/smart_goal_form_item.dart';
import 'package:finwise/modules/smart_goal/widgets/smart_goal_form_layout.dart';
import 'package:finwise/modules/smart_goal/widgets/smart_goal_prediction.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SmartGoalEditScreen extends StatefulWidget {
  const SmartGoalEditScreen({super.key});

  @override
  State<SmartGoalEditScreen> createState() => _SmartGoalEditScreenState();
}

class _SmartGoalEditScreenState extends State<SmartGoalEditScreen> {
  late final _args =
      ModalRoute.of(context)!.settings.arguments as SmartGoalData;

  late final TextEditingController _nameController =
      TextEditingController(text: _args.name);

  late final TextEditingController _amountController =
      TextEditingController(text: '${_args.amount}');

  late final TextEditingController _currentSaveController =
      TextEditingController(text: '${_args.currentSave}');

  late final TextEditingController _leftToSaveController =
      TextEditingController(text: '${_args.remainingSave}');

  late bool _setDue = _args.setDate;

  late final TextEditingController _startDateController = TextEditingController(
      text: '${UIHelper.getDateFormat(
    _args.startDate.toString(),
    'dd MMM, yyyy',
  )}');

  late final TextEditingController _endDateController = TextEditingController(
      text: '${UIHelper.getDateFormat(
    _args.endDate.toString(),
    'dd MMM, yyyy',
  )}');

  late final TextEditingController _contributionController =
      TextEditingController(text: '${_args.monthlyContribution}');

  @override
  Widget build(BuildContext context) {
    return SmartGoalFormLayout(
      title: 'Edit Goal',
      formSection: _buildForm(),
    );
  }

  Widget _buildForm() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildBasicInfoPart(),
                _buildTargetGoalPart(),
              ],
            ),
          ),
        ),
        _buildButtonPart(),
      ],
    );
  }

  Widget _buildBasicInfoPart() {
    return Form(
      child: Column(
        children: [
          SmartGoalFormItem(
            label: 'Name you goal',
            controller: _nameController,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                  child: SmartGoalFormItem(
                label: 'Goal Amount',
                controller: _amountController,
                isNumber: true,
              )),
              const SizedBox(width: 8),
              Expanded(
                  child: SmartGoalFormItem(
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
                child: SmartGoalFormItem(
                  color: const Color(0xffD3D5E4),
                  label: 'Left to Save',
                  isNumber: true,
                  controller: _leftToSaveController,
                  readOnly: true,
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  late DateTime _selectedStartDay;
  late DateTime _selectedEndDay;

  Widget _buildTargetGoalPart() {
    return Column(
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
                    _selectedStartDay = selectedDay;
                    _startDateController.text =
                        UIHelper.getInputDate(selectedDay.toString());
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
                    _selectedEndDay = selectedDay;
                    _endDateController.text =
                        UIHelper.getInputDate(selectedDay.toString());
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
              Row(
                children: [
                  Expanded(
                    child: SmartGoalFormItem(
                      label: 'Monthly Contribution',
                      controller: _contributionController,
                      isNumber: true,
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
              const SizedBox(height: 20),
              const SmartGoalPrediction(),
            ],
          ),
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

  Widget _buildButtonPart() {
    return Row(
      children: [
        Expanded(
          child: GeneralBottomButton(
            onButtonTap: () {},
            buttonLabel: 'Cancel',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: GeneralBottomButton(
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
                monthlyContribution =
                    double.parse(_contributionController.text);
              }

              SmartGoalData smartGoalData = SmartGoalData(
                id: _args.id,
                userID: _args.userID,
                name: _nameController.text,
                amount: double.parse(_amountController.text),
                currentSave: double.parse(_currentSaveController.text),
                remainingSave: double.parse(_leftToSaveController.text),
                setDate: _setDue,
                startDate: startDate,
                endDate: endDate,
                monthlyContribution: monthlyContribution,
              );

              bool success =
                  await context.read<SmartGoalStore>().update(smartGoalData);

              if (success) {
                print('updated successfully');
                Navigator.pop(context);
                Navigator.pop(context);
              }
            },
            buttonLabel: 'Save',
          ),
        ),
      ],
    );
  }
}
