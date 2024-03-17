import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/constants/text_style_constants/general_text_style_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/helpers/text_style_helper.dart';
import 'package:flutter/material.dart';

class CalendarMonthWidget extends StatefulWidget {
  DateTime date;
  final DateTime selected;
  final void Function(dynamic)? onChange;

  CalendarMonthWidget({
    super.key,
    required this.date,
    required this.selected,
    required this.onChange,
  });

  @override
  State<CalendarMonthWidget> createState() => _CalendarMonthWidgetState();
}

class _CalendarMonthWidgetState extends State<CalendarMonthWidget> {
  late List<DropdownMenuItem<DateTime>> _dropdownItems;

  @override
  void initState() {
    super.initState();
    _generateDropdownItems();
  }

  void _generateDropdownItems() {
    _dropdownItems = List.generate(24, (index) {
      final year = widget.date.year + index ~/ 12;
      final month = index % 12 + 1;
      return DropdownMenuItem(
        value: DateTime(year, month),
        child: Text(
          '${_getMonthName(month)}, $year',
        ),
      );
    });
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorConstant.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          IconHelper.getSVG(
            SVGName.calendar,
            color: ColorConstant.mainText,
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: DropdownButton(
              items: _dropdownItems,
              value: widget.selected,
              onChanged: widget.onChange,
              icon: IconHelper.getSVG(
                SVGName.arrowBack,
                color: ColorConstant.white,
              ),
              dropdownColor: ColorConstant.white,
              underline: Container(),
              padding: const EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ],
      ),
    );
  }

  Widget _datePicker() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => widget
              .onChange!(DateTime(widget.date.year - 1, widget.date.month)),
          child: IconConstant.arrowLeft,
        ),
        const SizedBox(width: 12),
        Text(
          '${widget.date.year}',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            letterSpacing: 1,
            color: ColorConstant.black,
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () => widget
              .onChange!(DateTime(widget.date.year + 1, widget.date.month)),
          child: IconConstant.arrowRight,
        ),
      ],
    );
  }
}
