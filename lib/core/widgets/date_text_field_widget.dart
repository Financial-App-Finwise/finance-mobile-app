import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/helpers/text_style_helper.dart';
import 'package:finwise/modules/smart_goal/widgets/calendar_widget.dart';
import 'package:flutter/material.dart';

class DateTextFieldWidget extends StatefulWidget {
  late final String hintText;
  late final void Function(DateTime selectedDay, DateTime focusedDay)
      onDaySelected;
  late bool enable;
  final TextEditingController? controller;
  final TextStyle? hintStyle;

  DateTextFieldWidget({
    super.key,
    this.hintText = '',
    this.hintStyle,
    this.enable = true,
    required this.onDaySelected,
    this.controller,
  });

  @override
  State<DateTextFieldWidget> createState() => _DateTextFieldWidgetState();
}

class _DateTextFieldWidgetState extends State<DateTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return _buildDate();
  }

  Widget _buildDate() {
    return TextFormField(
      controller: widget.controller,
      onTap: widget.enable
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CalendarWidget(
                    onDaySelected: widget.onDaySelected,
                  ),
                ),
              );
            }
          : null,
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
        prefixIcon: Container(
          child: Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: IconHelper.getSVG(
              SVGName.calendar,
              color: ColorConstant.mainText,
            ),
          ),
        ),
        prefixIconConstraints: BoxConstraints(maxHeight: 24),
        hintText: widget.hintText,
        hintStyle: widget.hintStyle ??
            TextStyleHelper.getw500size(12, color: ColorConstant.thin),
      ),
    );
  }
}
