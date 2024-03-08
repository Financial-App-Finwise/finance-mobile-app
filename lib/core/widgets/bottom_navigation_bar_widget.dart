import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/route.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  late void Function() onTap;
  late int currentIndex;

  BottomNavigationBarWidget({
    super.key,
    required this.onTap,
    this.currentIndex = 0,
  });

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    return _buildBottom();
  }

  List _isSelectedList = [true, false, false];
  List<String> _routeNames = [RouteName.home, '', RouteName.profile];

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
          if (index != 1) {
            setState(() {
              // if (_currentIndex == index) {
              //   widget.onTap();
              // }
              _isSelectedList = [false, false, false];
              _isSelectedList[index] = true;
              Navigator.pushNamedAndRemoveUntil(
                context,
                _routeNames[index],
                (route) => false,
              );
            });
          }
        },
        type: BottomNavigationBarType.fixed,
        currentIndex: widget.currentIndex,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        selectedItemColor: const Color(0xff00A6FB),
        unselectedItemColor: const Color(0xff464255),
        items: [
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 24,
              child: IconConstant.getHome(
                color: _isSelectedList[0]
                    ? const Color(0xff00A6FB)
                    : ColorConstant.mainText,
              ),
            ),
            label: 'Home',
          ),
          const BottomNavigationBarItem(icon: SizedBox.shrink(), label: ''),
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 24,
              child: IconHelper.getSVG(
                SVGName.bottomNavUser,
                color: _isSelectedList[2]
                    ? const Color(0xff00A6FB)
                    : ColorConstant.mainText,
              ),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
