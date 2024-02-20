import 'package:finwise/modules/smart_goal/widgets/forms/smart_goal_form_item.dart';
import 'package:flutter/material.dart';

class SmartGoalBasicForm extends StatelessWidget {
  SmartGoalBasicForm({
    super.key,
    this.nameController,
    this.amountController,
    this.currentSaveController,
    this.leftToSaveController,
  });

  TextEditingController? nameController = TextEditingController();
  TextEditingController? amountController = TextEditingController();
  TextEditingController? currentSaveController = TextEditingController();
  TextEditingController? leftToSaveController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return _buildBasicInfoPart();
  }

  Widget _buildBasicInfoPart() {
    return Form(
      child: Column(
        children: [
          SmartGoalFormItem(
            label: 'Name you goal',
            controller: nameController,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                  child: SmartGoalFormItem(
                label: 'Goal Amount',
                controller: amountController,
                isNumber: true,
              )),
              const SizedBox(width: 8),
              Expanded(
                  child: SmartGoalFormItem(
                label: 'Saved so far',
                controller: currentSaveController,
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
                  controller: leftToSaveController,
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
}
