import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:finwise/route.dart';
import 'package:flutter/material.dart';

class GeneralLayout extends StatefulWidget {
  late Widget body;

  GeneralLayout({
    super.key,
    required this.body,
  });

  @override
  State<GeneralLayout> createState() => _GeneralLayoutState();
}

class _GeneralLayoutState extends State<GeneralLayout> {
  final PageController _pageController = PageController();
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

  late final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _controller,
        child: widget.body,
      ),
      bottomNavigationBar: _buildBottom(),
      floatingActionButton: _buildFloating(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _test() {
    return BottomAppBar(
      // color: Colors.white,
      height: 80,
      // surfaceTintColor: Colors.white,
      elevation: 0.5,
      // shape: const CircularNotchedRectangle(),
      padding: EdgeInsets.zero,
      // notchMargin: 12.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(
                height: 24,
                child: IconConstant.getHome(
                  color: _isSelectedList[0]
                      ? const Color(0xff00A6FB)
                      : ColorConstant.mainText,
                ),
              ),
              Text('Home'),
            ],
          )
        ],
      ),
    );
  }

  // _controller.animateTo(
  //           0.0,
  //           duration: Duration(milliseconds: 500),
  //           curve: Curves.easeInOut,
  //         );

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
              if (_currentIndex == index) {
                _controller.animateTo(
                  0,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              }
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
              child: IconConstant.getBottomUser(
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

  Widget _buildFloating() {
    return FloatingActionButton(
      onPressed: () =>
          Navigator.pushNamed(context, RouteName.transactionCreate),
      elevation: 0,
      backgroundColor: const Color(0xff00A6FB),
      shape: const CircleBorder(),
      child: const Icon(Icons.add, color: Colors.white),
    );
  }
}
