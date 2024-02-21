import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/font_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:flutter/material.dart';

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
  final GlobalKey _centerContainerKey = GlobalKey();
  final GlobalKey _headerContainerKey = GlobalKey();
  final GlobalKey _titleContainerKey = GlobalKey();

  double centerContainerHeight = 0;
  double headerContainerHeight = 0;
  double expandedHeight = 0;
  double titleHeight = 0;
  final double _depth = 32;

  final ScrollController _scrollController = ScrollController();
  bool _isAppBarExpanded = true;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setContainerHeight();
    });
    _scrollController.addListener(() {
      if (_scrollController.offset > titleHeight) {
        setState(() {
          _isAppBarExpanded = false;
        });
      } else {
        setState(() {
          _isAppBarExpanded = true;
        });
      }
    });
  }

  void _setContainerHeight() {
    setState(() {
      centerContainerHeight = _getContainerHeight(_centerContainerKey);
      headerContainerHeight = _getContainerHeight(_headerContainerKey);
      titleHeight = _getContainerHeight(_titleContainerKey);
      expandedHeight = centerContainerHeight + headerContainerHeight - _depth;
    });
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
                const SizedBox(width: 12),
                Visibility(
                  visible: !_isAppBarExpanded,
                  child: Text(
                    widget.title,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    toolbarHeight: centerContainerHeight > 0
                        ? centerContainerHeight + 0 // plus padding
                        : 0, // equal to center height
                    expandedHeight: expandedHeight > 0 ? expandedHeight : 300,
                    // floating: true,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
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
                            // container for creating the size of stack
                            Container(
                              alignment: Alignment.topCenter,
                              color: ColorConstant.backgroundColor,
                              height: expandedHeight > 0 ? expandedHeight : 300,
                            ),

                            // Title container
                            Positioned(
                              key: _headerContainerKey,
                              bottom: centerContainerHeight > _depth
                                  ? centerContainerHeight - _depth
                                  : 0,
                              width: MediaQuery.of(context).size.width,
                              child: Container(
                                padding: EdgeInsets.only(
                                  left: 16,
                                  right: 16,
                                  bottom: _depth + 16,
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
                                    // Title and Description text
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // _buildBackArrow(),
                                        // const SizedBox(height: 12),
                                        Container(
                                          key: _titleContainerKey,
                                          child: Text(
                                            widget.title,
                                            style: const TextStyle(
                                              fontFamily:
                                                  FontConstant.balooThambi2,
                                              color: Color(0xFFFFFFFF),
                                              fontSize: 32,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 1,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
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

                            // center overview container
                            Container(
                              margin: const EdgeInsets.only(left: 16, right: 16
                                  // bottom: 20,
                                  ),
                              padding: widget.centerContentPadding ??
                                  const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 12,
                                  ),
                              key: _centerContainerKey,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white,
                                  border: Border.all(
                                      color: ColorConstant.colorE9EAF1)),
                              child: widget.centerContent,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ];
              },
              body: NotificationListener<ScrollNotification>(
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
              ),
            ),
          ),
        ],
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
