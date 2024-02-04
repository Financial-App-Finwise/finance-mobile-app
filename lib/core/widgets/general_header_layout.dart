import 'package:flutter/material.dart';

class GeneralHeaderLayout extends StatefulWidget {
  const GeneralHeaderLayout({
    super.key,
    this.title = '',
    this.description = '',
    this.centerContent,
    this.mainContent,
    this.gradient,
  });

  final String title;
  final String description;
  final Widget? centerContent;
  final Widget? mainContent;
  final LinearGradient? gradient;

  @override
  State<GeneralHeaderLayout> createState() => _GeneralHeaderLayoutState();
}

class _GeneralHeaderLayoutState extends State<GeneralHeaderLayout> {
  final GlobalKey _centerContainerKey = GlobalKey();
  final GlobalKey _headerContainerKey = GlobalKey();

  double centerContainerHeight = 0;
  double headerContainerHeight = 0;

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
    });
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
              ),
        ),
        child: SafeArea(
          child: Container(
            alignment: Alignment.topLeft,
            color: const Color(0xffF5F7F8),
            child: _buildHeaderLayout(),
          ),
        ),
      ),
    );
  }

  final double _depth = 32;

  Widget _buildHeaderLayout() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Column(
                  children: [
                    Container(
                      key: _headerContainerKey,
                      padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 16,
                        bottom: _depth + 16,
                      ),
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
                      ),
                      child: _buildTopContent(),
                    ),
                    Expanded(
                      child: Container(
                        // height: centerContainerHeight > 32
                        //     ? centerContainerHeight - _depth
                        //     : 0,
                        padding: EdgeInsets.only(
                          top: centerContainerHeight > _depth
                              ? centerContainerHeight - _depth
                              : 0,
                          left: 16,
                          right: 16,
                        ),
                        alignment: Alignment.topLeft,
                        color: const Color(0xffF5F7F8),
                        child: widget.mainContent,
                      ),
                    ),
                  ],
                ),

                // center content
                Positioned(
                  width: MediaQuery.of(context).size.width,
                  top: headerContainerHeight > _depth
                      ? headerContainerHeight - _depth
                      : 0,
                  child: Container(
                    alignment: Alignment.center,
                    key: _centerContainerKey,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: widget.centerContent ?? const SizedBox(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBackArrow(),
        const SizedBox(height: 12),
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
        )
      ],
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

  double _getContainerHeight(GlobalKey containerKey) {
    if (containerKey.currentContext != null) {
      RenderBox renderBox =
          containerKey.currentContext!.findRenderObject() as RenderBox;
      return renderBox.size.height;
    }
    return 100;
  }
}
