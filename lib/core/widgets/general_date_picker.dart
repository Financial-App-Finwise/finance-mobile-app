import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:flutter/material.dart';

class GeneralDatePicker extends StatefulWidget {
  const GeneralDatePicker({super.key});

  @override
  State<GeneralDatePicker> createState() => _GeneralDatePickerState();
}

class _GeneralDatePickerState extends State<GeneralDatePicker> {
  DateTime currentDate = DateTime.now();

  List<String> monthNames = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _contentManager(),
    );
  }

  Widget _contentManager() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: IconButton(
              onPressed: () {},
              icon: IconConstant.contentManagerDashboard,
              style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
              ),
            ),
          ),
          _datePicker(),
          SizedBox(
            width: 24,
            height: 24,
            child: IconButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => widget.addScreen,
                //   ),
                // );
              },
              icon: IconConstant.addSquare,
              style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
              ),
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
          onTap: () {
            setState(() {
              currentDate = subtractMonth(currentDate);
            });
          },
          child: IconConstant.arrowLeft,
        ),
        const SizedBox(width: 12),
        Text(
          '${monthNames[currentDate.month - 1]} ${currentDate.year}',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            letterSpacing: 1,
            color: ColorConstant.black,
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () {
            setState(() {
              currentDate = addMonth(currentDate);
            });
          },
          child: IconConstant.arrowRight,
        ),
      ],
    );
  }

  DateTime subtractMonth(DateTime date) {
    // Calculate the number of days in the previous month
    int daysInPreviousMonth = DateTime(date.year, date.month, 0).day;

    // Subtract the days in the previous month from the current date
    return date.subtract(Duration(days: daysInPreviousMonth));
  }

  DateTime addMonth(DateTime date) {
    // Calculate the number of days in the current month
    int daysInCurrentMonth = DateTime(date.year, date.month + 1, 0).day;

    // Add the days in the current month to the current date
    return date.add(Duration(days: daysInCurrentMonth));
  }
}
