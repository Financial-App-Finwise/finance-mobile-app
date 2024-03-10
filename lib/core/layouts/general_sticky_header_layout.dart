import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/font_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/layouts/stores/general_sticky_header_layout_store.dart';
import 'package:finwise/core/models/screen_navigation_model/screen_model.dart';
import 'package:finwise/modules/home/screens/home_screen.dart';
import 'package:finwise/modules/user/profile_screen.dart';
import 'package:finwise/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class GeneralStickyHeaderLayout extends StatefulWidget {
  const GeneralStickyHeaderLayout({
    super.key,
    this.title = '',
    this.description = '',
    this.centerContent,
    this.mainContent,
    this.gradient,
    this.centerContentPadding,
    this.onNotification,
  });

  final String title;
  final String description;
  final Widget? centerContent;
  final Widget? mainContent;
  final LinearGradient? gradient;
  final EdgeInsets? centerContentPadding;
  final bool Function(Notification)? onNotification;

  @override
  State<GeneralStickyHeaderLayout> createState() =>
      _GeneralStickyHeaderLayoutState();
}

class _GeneralStickyHeaderLayoutState extends State<GeneralStickyHeaderLayout> {
  final store = GeneralStickyHeaderLayoutStore();

  // -------------------- Container Key --------------------
  final GlobalKey centerContainerKey = GlobalKey();
  final GlobalKey headerContainerKey = GlobalKey();
  final GlobalKey titleContainerKey = GlobalKey();

  final ScrollController scrollController = ScrollController();

  // -------------------- Height --------------------
  // late double centerContainerHeight = store.centerContainerHeight;
  // double headerContainerHeight = 0;
  // double expandedHeight = 0;
  // double titleHeight = 0;
  // bool isAppBarExpanded = true;

  final double depth = 32;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setContainerHeight();
    });
    scrollController.addListener(() {
      if (scrollController.offset > store.titleHeight * 0.9) {
        store.isAppBarExpanded = false;
        // setState(() {
        //   isAppBarExpanded = false;
        // });
      } else {
        store.isAppBarExpanded = true;
        // setState(() {
        //   isAppBarExpanded = true;
        // });
      }
    });
  }

  void _setContainerHeight() {
    store.centerContainerHeight = _getContainerHeight(centerContainerKey);
    store.centerContainerHeight = _getContainerHeight(centerContainerKey);
    store.headerContainerHeight = _getContainerHeight(headerContainerKey);
    store.titleHeight = _getContainerHeight(titleContainerKey);
    store.expandedHeight =
        store.centerContainerHeight + store.headerContainerHeight - depth;

    // setState(() {
    //   centerContainerHeight = _getContainerHeight(centerContainerKey);
    //   headerContainerHeight = _getContainerHeight(headerContainerKey);
    //   titleHeight = _getContainerHeight(titleContainerKey);
    //   expandedHeight = centerContainerHeight + headerContainerHeight - depth;
    // });
  }

  double _getContainerHeight(GlobalKey containerKey) {
    if (containerKey.currentContext != null) {
      RenderBox renderBox =
          containerKey.currentContext!.findRenderObject() as RenderBox;
      return renderBox.size.height;
    }
    return 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: _buildBottom(),
      floatingActionButton: _buildFloating(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // -------------------- Buttom Navigation Bar --------------------
  late final List<ScreenNavigationModel> _indexItems = [
    ScreenNavigationModel(
      screen: HomeScreen(),
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
          Navigator.popUntil(context, ModalRoute.withName(RouteName.wrapper));
        },
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        selectedItemColor: const Color(0xff464255),
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
      onPressed: () =>
          Navigator.pushNamed(context, RouteName.transactionCreate),
      elevation: 0,
      backgroundColor: const Color(0xff00A6FB),
      shape: const CircleBorder(),
      child: const Icon(Icons.add, color: Colors.white),
    );
  }

  Widget _buildBody() {
    return Container(
      decoration: BoxDecoration(
          gradient: widget.gradient ??
              const LinearGradient(
                colors: [
                  Colors.blueAccent,
                  Colors.greenAccent,
                ],
                stops: [0.2, 0.8],
              )),
      child: SafeArea(
        child: Container(
          color: ColorConstant.backgroundColor,
          child: _buildNestedScrollView(),
        ),
      ),
    );
  }

  Widget _buildNestedScrollView() {
    return Container(
      decoration: BoxDecoration(
        gradient: widget.gradient ??
            const LinearGradient(
              colors: [
                Colors.blueAccent,
                Colors.greenAccent,
              ],
              stops: [0.2, 0.8],
            ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
            child: Row(
              children: [
                _buildBackArrow(),
                const SizedBox(width: 16),
                Observer(
                  builder: (context) => Visibility(
                      visible: !store.isAppBarExpanded,
                      child: Text(
                        widget.title,
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    )
                ),
              ],
            ),
          ),
          Expanded(
            child: NestedScrollView(
              controller: scrollController,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) => [
                Observer(builder: (context) {
                  return SliverAppBar(
                    automaticallyImplyLeading: false,
                    toolbarHeight: store.centerContainerHeight > 0
                        ? store.centerContainerHeight + 0 // plus padding
                        : 0, // equal to center height
                    expandedHeight: store.expandedHeight > 0 ? store.expandedHeight : 300,
                    // floating: true,
                    pinned: true,
                    flexibleSpace: _buildFlexibleSpace(),
                  );
                }),
              ],
              body: _buildNestedBody(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlexibleSpace() {
    return FlexibleSpaceBar(
      expandedTitleScale: 1,
      titlePadding: EdgeInsets.zero,
      title: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: widget.gradient ??
              const LinearGradient(
                colors: [
                  Colors.blueAccent,
                  Colors.greenAccent,
                ],
                stops: [0.2, 0.8],
              ),
        ), //
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // ---------- Create the Stack Size ----------
            Container(
              alignment: Alignment.topCenter,
              color: ColorConstant.backgroundColor,
              height: store.expandedHeight > 0 ? store.expandedHeight : 300,
            ),

            // ---------- Title Container ----------
            Positioned(
              key: headerContainerKey,
              bottom: store.centerContainerHeight > depth
                  ? store.centerContainerHeight - depth
                  : 0,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: depth + 16,
                ),
                decoration: BoxDecoration(
                  gradient: widget.gradient ??
                      const LinearGradient(
                        colors: [
                          Colors.blueAccent,
                          Colors.greenAccent,
                        ],
                        stops: [0.2, 0.8],
                      ),
                ),
                alignment: Alignment.topCenter,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    // const SizedBox(height: 12),

                    // // ---------- Title and Description ----------
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // _buildBackArrow(),
                        // const SizedBox(height: 12),

                        // ---------- Title ----------
                        Container(
                          key: titleContainerKey,
                          child: Text(
                            widget.title,
                            style: const TextStyle(
                              fontFamily: FontConstant.balooThambi2,
                              color: Color(0xFFFFFFFF),
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),

                        // ---------- Description ----------
                        Text(
                          widget.description,
                          style: const TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 14,
                            height: 1.5,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.75,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),

            // // ---------- Center Overview ----------
            Container(
              margin: const EdgeInsets.only(left: 16, right: 16
                  // bottom: 20,
                  ),
              padding: widget.centerContentPadding ??
                  const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 12,
                  ),
              key: centerContainerKey,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  border: Border.all(color: ColorConstant.colorE9EAF1)),
              child: widget.centerContent,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNestedBody() {
    return NotificationListener<ScrollNotification>(
      onNotification: widget.onNotification,
      child: Container(
        color: ColorConstant.backgroundColor,
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          // top: 16,
        ),
        child: widget.mainContent,
      ),
    );
  }

  Widget _buildBackArrow() {
    return SizedBox(
      width: 24,
      height: 24,
      child: IconButton(
        onPressed: () => Navigator.pop(context),
        // icon: const Icon(IconHelper, size: 24),
        icon: SizedBox(
          child: IconHelper.getSVG(SVGName.arrowBack, color: Colors.white),
        ),
        style: ButtonStyle(
          padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
          iconColor: MaterialStateProperty.all(const Color(0xFFFFFFFF)),
        ),
      ),
    );
  }
}
