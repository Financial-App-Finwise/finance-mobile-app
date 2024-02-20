import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/constants/text_style_constants/general_text_style_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/helpers/text_style_helper.dart';
import 'package:finwise/core/helpers/ui_helper.dart';
import 'package:finwise/modules/smart_goal/models/smart_goal_model.dart';
import 'package:finwise/modules/smart_goal/widgets/calendar_widget.dart';
import 'package:finwise/modules/smart_goal/widgets/forms/smart_goal_form_item.dart';
import 'package:finwise/modules/smart_goal/widgets/smart_goal_form_layout.dart';
import 'package:finwise/modules/smart_goal/widgets/smart_goal_prediction.dart';
import 'package:flutter/material.dart';

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
    print(_nameController.text);

    return SmartGoalFormLayout(
      title: 'Edit Goal',
      formSection: SingleChildScrollView(
        child: Column(
          children: [
            _buildBasicInfoPart(),
            _buildTargetGoalPart(),
          ],
        ),
      ),
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
                        color: const Color(0xffD3D5E4),
                        label: 'Monthly Contribution',
                        controller: _contributionController,
                        readOnly: true),
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
}
