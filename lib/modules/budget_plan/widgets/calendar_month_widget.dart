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
  DateTime currentDate = DateTime.now();

  late final List<DropdownMenuItem> _dropdownItems = [
    DropdownMenuItem(
        value: DateTime(widget.date.year, 1),
        child: Text('Jan, ${widget.date.year}')),
    DropdownMenuItem(
        value: DateTime(widget.date.year, 2),
        child: Text('Feb, ${widget.date.year}')),
    DropdownMenuItem(
        value: DateTime(widget.date.year, 3),
        child: Text('Mar, ${widget.date.year}')),
    DropdownMenuItem(
        value: DateTime(widget.date.year, 4),
        child: Text('Apr, ${widget.date.year}')),
    DropdownMenuItem(
        value: DateTime(widget.date.year, 5),
        child: Text('May, ${widget.date.year}')),
    DropdownMenuItem(
        value: DateTime(widget.date.year, 6),
        child: Text('Jun, ${widget.date.year}')),
    DropdownMenuItem(
        value: DateTime(widget.date.year, 7),
        child: Text('Jul, ${widget.date.year}')),
    DropdownMenuItem(
        value: DateTime(widget.date.year, 8),
        child: Text('Aug, ${widget.date.year}')),
    DropdownMenuItem(
        value: DateTime(widget.date.year, 9),
        child: Text('Sep, ${widget.date.year}')),
    DropdownMenuItem(
        value: DateTime(widget.date.year, 10),
        child: Text('Oct, ${widget.date.year}')),
    DropdownMenuItem(
        value: DateTime(widget.date.year, 11),
        child: Text('Nov, ${widget.date.year}')),
    DropdownMenuItem(
        value: DateTime(widget.date.year, 12),
        child: Text('Dec, ${widget.date.year}')),
  ];

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
          '${currentDate.year}',
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
