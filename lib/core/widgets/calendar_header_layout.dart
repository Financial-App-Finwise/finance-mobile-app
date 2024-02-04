import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';

class CalendarHeaderLayout extends StatefulWidget {
  final Widget child;
  final Widget addScreen;
  final String title;
  final String description;
  final Color firstColor;
  final Color secondColor;
  final VoidCallback? changeView;
  final bool? gridView;

  const CalendarHeaderLayout({
    super.key,
    required this.child,
    required this.addScreen,
    required this.title,
    required this.description,
    required this.firstColor,
    required this.secondColor,
    this.changeView,
    this.gridView,
  });

  @override
  State<CalendarHeaderLayout> createState() => _CalendarHeaderLayoutState();
}

class _CalendarHeaderLayoutState extends State<CalendarHeaderLayout> {
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
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [widget.firstColor, widget.secondColor],
            stops: const [0.2, 0.8]),
      ),
      child: SafeArea(
        child: Column(
          children: [
            _topBarContent(),
            Expanded(
              child: Container(
                color: const Color(0xFFF5F7F8),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: widget.child,
                    ),
                    _wrapper(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topBarContent() {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [widget.firstColor, widget.secondColor],
            stops: const [0.2, 0.8]),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          CustomIconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: IconHelper.getSVG(
              SVGName.arrowBack,
              color: ColorConstant.white,
            ),
          ),

          const SizedBox(
            height: 12,
          ),

          // Title and Description text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 32,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                widget.description,
                style: const TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 14,
                    height: 1.7,
                    fontWeight: FontWeight.w500),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _wrapper() {
    return Container(
      height: 62,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Stack(children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 31,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [widget.firstColor, widget.secondColor],
                  stops: const [0.2, 0.8]),
            ),
          ),
        ),
        Positioned(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _contentManager(),
          ),
        ),
      ]),
    );
  }

  Widget _contentManager() {
    return Container(
      height: 62,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
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
              onPressed: widget.changeView,
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => widget.addScreen,
                  ),
                );
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
        const SizedBox(
          width: 12,
        ),
        Text(
          '${monthNames[currentDate.month - 1]} ${currentDate.year}',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            letterSpacing: 1,
            color: ColorConstant.black,
          ),
        ),
        const SizedBox(
          width: 12,
        ),
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
