import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/font_constant.dart';
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
  });

  final String title;
  final String description;
  final Widget? centerContent;
  final Widget? mainContent;
  final LinearGradient? gradient;
  final EdgeInsets? centerContentPadding;

  @override
  State<GeneralStickyHeaderLayout> createState() =>
      _GeneralStickyHeaderLayoutState();
}

class _GeneralStickyHeaderLayoutState extends State<GeneralStickyHeaderLayout> {
  final GlobalKey _centerContainerKey = GlobalKey();
  final GlobalKey _headerContainerKey = GlobalKey();

  double centerContainerHeight = 0;
  double headerContainerHeight = 0;
  double expandedHeight = 0;
  final double _depth = 32;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setContainerHeight();
    });
  }

  void _setContainerHeight() {
    setState(() {
      centerContainerHeight = _getContainerHeight(_centerContainerKey);
      headerContainerHeight = _getContainerHeight(_headerContainerKey);
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
      body: Container(
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
      ),
    );
  }

  Widget _buildNestedScrollView() {
    return NestedScrollView(
      physics: const BouncingScrollPhysics(),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.amber,
            toolbarHeight: centerContainerHeight > 0
                ? centerContainerHeight + 12 // padding: 12px
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
                      // color: Colors.amber,
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
                            const SizedBox(height: 12),
                            // Title and Description text
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildBackArrow(),
                                const SizedBox(height: 12),
                                Text(
                                  widget.title,
                                  style: const TextStyle(
                                    fontFamily: FontConstant.balooThambi2,
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 32,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1,
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
                      margin: const EdgeInsets.only(
                        left: 16,
                        right: 16,
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
                          border: Border.all(color: ColorConstant.colorE9EAF1)),
                      child: widget.centerContent,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ];
      },
      body: Container(
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
        icon: const Icon(Icons.arrow_back, size: 24),
        style: ButtonStyle(
          padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
          iconColor: MaterialStateProperty.all(const Color(0xFFFFFFFF)),
        ),
      ),
    );
  }
}
