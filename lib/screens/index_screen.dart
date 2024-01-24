import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:finwise/modules/home/screens/home_screen.dart';
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
  // void deactivate() {
  //   _pageController.dispose();
  //   print('deactivate');
  //   super.deactivate();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: _buildBottom(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // go to transaction screen
        },
        elevation: 0,
        backgroundColor: Color(0xff00A6FB),
        shape: CircleBorder(),
        child: Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildBody() {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: [
        HomeScreen(),
        Container(child: Text('Page2')),
        SizedBox(),
        Container(child: Text('Page3')),
        Container(child: Text('Page4')),
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
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index != 2) {
            setState(() {
            _isSelectedList = [false, false, false, false, false];
            _isSelectedList[index] = true;
            _currentIndex = index;
            _pageController.jumpToPage(index);
          });
          }
        },
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: IconConstant.getHome(isSelected: _isSelectedList[0]),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: IconConstant.getHome(isSelected: _isSelectedList[1]),
            label: 'Home',
          ),
          // empty
          BottomNavigationBarItem(
            icon: SizedBox.shrink(),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: IconConstant.getHome(isSelected: _isSelectedList[3]),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: IconConstant.getHome(isSelected: _isSelectedList[4]),
            label: 'Home',
          ),
        ],
      ),
    );
  }
}
