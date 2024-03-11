import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/widgets/buttons/select_item_button.dart';
import 'package:finwise/modules/transaction/widgets/upcoming_bill_button/select_upcoming_bill_widget.dart';
import 'package:finwise/modules/upcoming_bill/models/upcoming_bill_model.dart';
import 'package:flutter/material.dart';

class UpcomingBillButton extends StatefulWidget {
  final SelectItem<UpcomingBillData> currentItem;
  final void Function(UpcomingBillData) onItemSelected;

  const UpcomingBillButton({
    super.key,
    required this.currentItem,
    required this.onItemSelected,
  });

  @override
  State<UpcomingBillButton> createState() => _UpcomingBillButtonState();
}

class _UpcomingBillButtonState extends State<UpcomingBillButton> {
  late final SelectItem<UpcomingBillData> _currentItem = widget.currentItem;

  @override
  Widget build(BuildContext context) {
    return SelectItemButton(
      currentItem: _currentItem,
      title: _currentItem.title,
      subTitle: _currentItem.subTitle,
      selectionScreen: SelectUpcomingBillWidget(
        onItemSelected: (upcomingBillData) {
          setState(() {
            _currentItem.item = upcomingBillData;
            _currentItem.subTitle = upcomingBillData.name;
            _currentItem.itemPicked = true;
          });
          widget.onItemSelected(upcomingBillData);
        },
      ),
    );
  }
}
