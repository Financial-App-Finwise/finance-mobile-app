import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/widgets/top_back_arrow.dart';
import 'package:finwise/route.dart';
import 'package:flutter/material.dart';

class GeneralSimpleHeaderLayout extends StatefulWidget {
  const GeneralSimpleHeaderLayout({
    super.key,
    this.title = '',
    this.description = '',
    this.color,
    this.gradient,
    this.child,
    this.padding,
    this.onNotification,
  });

  final String title;
  final String description;
  final Color? color;
  final LinearGradient? gradient;
  final Widget? child;
  final EdgeInsets? padding;
  final bool Function(Notification)? onNotification;

  @override
  State<GeneralSimpleHeaderLayout> createState() =>
      _GeneralSimpleHeaderLayoutState();
}

class _GeneralSimpleHeaderLayoutState extends State<GeneralSimpleHeaderLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: widget.gradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // header
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(
                    left: 16, right: 16, bottom: 16, top: 8),
                decoration: BoxDecoration(
                  gradient: widget.gradient,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TopBackArrow(),
                    const SizedBox(height: 12),
                    Text(
                      widget.title,
                      style: const TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 32,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.description,
                      style: const TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 14,
                        height: 1.7,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              // content
              Expanded(
                child: Container(
                  alignment: Alignment.topLeft,
                  padding: widget.padding ??
                      const EdgeInsets.symmetric(horizontal: 16),
                  color: ColorConstant.backgroundColor,
                  child: NotificationListener<ScrollNotification>(
                    onNotification: widget.onNotification,
                    child: widget.child ?? const SizedBox(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottom(),
      floatingActionButton: _buildFloating(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildBottom() {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0,
        onTap: (index) {
          Navigator.pushReplacementNamed(context, RouteName.index);
        },
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        selectedItemColor: const Color(0xff00A6FB),
        unselectedItemColor: const Color(0xff464255),
        items: [
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 24,
              child: IconHelper.getSVG(SVGName.home),
            ),
            label: 'Home',
          ),
          const BottomNavigationBarItem(icon: SizedBox.shrink(), label: ''),
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 24,
              child: IconHelper.getSVG(SVGName.bottomNavUser),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildFloating() {
    return FloatingActionButton(
      onPressed: () => Navigator.pushNamed(context, RouteName.transactionAdd),
      elevation: 0,
      backgroundColor: const Color(0xff00A6FB),
      shape: const CircleBorder(),
      child: const Icon(Icons.add, color: Colors.white),
    );
  }
}
