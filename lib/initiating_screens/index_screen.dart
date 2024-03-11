import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/models/screen_navigation_model/screen_model.dart';
import 'package:finwise/modules/home/screens/home_screen.dart';
import 'package:finwise/modules/user/profile_screen.dart';
import 'package:finwise/route.dart';
import 'package:flutter/material.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key});

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    debugPrint('--> START: initState, index screen');
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      // _pageController.jumpToPage();
    });
    debugPrint('<-- END: initState, index screen');
  }

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

  final ScrollController _homeScrollController = ScrollController();
  final ScrollController _profileScrollController = ScrollController();

  late final List<ScreenNavigationModel> _indexItems = [
    ScreenNavigationModel(
      screen: HomeScreen(scrollController: _homeScrollController),
      index: 0,
      svgName: SVGName.home,
      label: 'Home',
    ),
    ScreenNavigationModel(screen: const SizedBox()),
    ScreenNavigationModel(
      screen: ProfileScreen(),
      index: 2,
      svgName: SVGName.bottomNavUser,
      label: 'Profile',
    ),
  ];

  Widget _buildBody() {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: _indexItems.map((item) => item.screen).toList(),
    );
  }

  int _currentIndex = 0;

  Widget _buildBottom() {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        selectedItemColor: const Color(0xff00A6FB),
        unselectedItemColor: const Color(0xff464255),
        onTap: (index) {
          if (index != 1) {
            setState(() {
              if (_currentIndex == 0 && index == 0) {
                _homeScrollController.animateTo(
                  0.0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.linearToEaseOut,
                );
              } else if (_currentIndex == 2 && index == 2) {
                _pageController.animateTo(
                  0.0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.linearToEaseOut,
                );
              }
              _currentIndex = index;
              _pageController.jumpToPage(index);
            });
          }
        },
        items: _indexItems
            .map(
              (item) => BottomNavigationBarItem(
                icon: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 24,
                      child: item.svgName.isNotEmpty
                          ? IconHelper.getSVG(
                              item.svgName,
                              color: _currentIndex == item.index
                                  ? const Color(0xff00A6FB)
                                  : ColorConstant.mainText,
                            )
                          : const SizedBox(),
                    ),
                  ],
                ),
                label: item.label,
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildFloating() {
    return FloatingActionButton(
      onPressed: () =>
          Navigator.pushNamed(context, RouteName.transactionAdd),
      elevation: 0,
      backgroundColor: const Color(0xff00A6FB),
      shape: const CircleBorder(),
      child: const Icon(Icons.add, color: Colors.white),
    );
  }
}
