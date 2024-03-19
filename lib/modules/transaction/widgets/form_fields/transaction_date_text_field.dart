import 'package:finwise/core/helpers/text_style_helper.dart';
import 'package:finwise/core/widgets/date_text_field_widget.dart';
import 'package:flutter/material.dart';

class TransactionDateTextField extends StatefulWidget {
  final TextEditingController controller;

  const TransactionDateTextField({
    super.key,
    required this.controller,
  });

  @override
  State<TransactionDateTextField> createState() =>
      _TransactionDateTextFieldState();
}

class _TransactionDateTextFieldState extends State<TransactionDateTextField> {
  late final _dateController = widget.controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: DateTextFieldWidget(
        controller: _dateController,
        enable: false,
        textStyle:
            TextStyleHelper.getw500size(14).copyWith(letterSpacing: 0.75),
        // hintText: UIHelper.getDateFormat(
        //     widget.transactionData.date.toString(), 'dd MMMM, yyyy'),
        // hintStyle:
        //     TextStyleHelper.getw500size(14).copyWith(letterSpacing: 0.75),
        onDaySelected: ((selectedDay, focusedDay) {}),
      ),
    );
  }
}
