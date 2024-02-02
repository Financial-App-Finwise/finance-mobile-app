import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:finwise/modules/finance/screens/finance_screen.dart';
import 'package:finwise/modules/home/screens/home_screen.dart';
import 'package:finwise/modules/user/profile_screen.dart';
import 'package:finwise/route.dart';
import 'package:finwise/screens/unimplemented_screen.dart';
import 'package:flutter/material.dart';

// combine all screens
class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key});

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  PageController _pageController = PageController();
  List _isSelectedList = [true, false, false, false, false];
  int _currentIndex = 0;

  // @override
  // void initState() {
  //   debugPrint('--> START: initState, index screen');
  //   super.initState();
  //   debugPrint('<-- END: initState, index screen');
  // }

  // @override
  // void deactivate() {
  //   _pageController.dispose();
  //   print('deactivate');
  //   super.deactivate();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _buildBody(),
      bottomNavigationBar: _buildBottom(),
      floatingActionButton: _buildFloating(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildBody() {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: [
        HomeScreen(),
        SizedBox(),
        ProfileScreen(),
        FinanceScreen(),
      ],
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
          if (index != 1) {
            setState(() {
              _isSelectedList = [false, false, false];
              _isSelectedList[index] = true;
              _currentIndex = index;
              _pageController.jumpToPage(index);
            });
          }
        },
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        selectedItemColor: Color(0xff00A6FB),
        unselectedItemColor: Color(0xff464255),
        items: [
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 24,
              child: IconConstant.getHome(
                color: _isSelectedList[0]
                    ? Color(0xff00A6FB)
                    : ColorConstant.mainText,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(icon: SizedBox.shrink(), label: ''),
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 24,
              child: IconConstant.getBottomUser(
                color: _isSelectedList[2]
                    ? Color(0xff00A6FB)
                    : ColorConstant.mainText,
              ),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildFloating() {
    return FloatingActionButton(
      onPressed: () {
        // go to transaction screen
        Navigator.pushNamed(context, RouteName.addTransaction);
      },
      elevation: 0,
      backgroundColor: Color(0xff00A6FB),
      shape: CircleBorder(),
      child: Icon(Icons.add, color: Colors.white),
    );
  }
}
