import 'package:finwise/core/constants/icon_constant.dart';
import 'package:finwise/modules/budget_plan/screens/add_budget_plan_screen.dart';
import 'package:flutter/material.dart';

class CalendarHeaderLayout extends StatefulWidget {
  final Widget child;
  final String title;
  final String description;
  final Color firstColor;
  final Color secondColor;
  final VoidCallback? changeView;

  const CalendarHeaderLayout({
    super.key,
    required this.child,
    required this.title,
    required this.description,
    required this.firstColor,
    required this.secondColor,
    this.changeView,
  });

  @override
  State<CalendarHeaderLayout> createState() => _CalendarHeaderLayoutState();
}

class _CalendarHeaderLayoutState extends State<CalendarHeaderLayout> {
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
          SizedBox(
            width: 24,
            height: 24,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 24,
              ),
              style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                iconColor: MaterialStateProperty.all(
                  const Color(0xFFFFFFFF),
                ),
              ),
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
                iconColor: MaterialStateProperty.all(
                  const Color(0xFF191B29),
                ),
              ),
            ),
          ),
          Text('Dec'),
          SizedBox(
            width: 24,
            height: 24,
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddBudgetPlanScreen(),
                  ),
                );
              },
              icon: IconConstant.addSquare,
              style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                iconColor: MaterialStateProperty.all(
                  const Color(0xFF0ABDE3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
