import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/general_text_style_constant.dart';
import 'package:finwise/core/constants/home_text_style_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:finwise/core/widgets/rounded_container.dart';
import 'package:flutter/material.dart';

class TestStickyContainer extends StatefulWidget {
  @override
  State<TestStickyContainer> createState() => _TestStickyContainerState();
}

class _TestStickyContainerState extends State<TestStickyContainer> {
  final GlobalKey _centerContainerKey = GlobalKey();
  final GlobalKey _headerContainerKey = GlobalKey();

  double centerContainerHeight = 0;
  double headerContainerHeight = 0;

  double expandedHeight = 0;

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

  double _depth = 32;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
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

  Widget _buildCustomerScrollView() {
    return CustomScrollView(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.amber,
          toolbarHeight: centerContainerHeight > 0
              ? centerContainerHeight
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
                gradient: LinearGradient(
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
                    color: Colors.grey,
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
                        gradient: LinearGradient(
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
                              Text(
                                'My Finance',
                                style: const TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 32,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Effortlessly manage your finance with a powerful simple tool in FinWise.',
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
                      ),
                    ),
                  ),

                  // center overview container
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    key: _centerContainerKey,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: _buildCenterContent(),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              // Your list view items go here
              return ListTile(
                title: Text('Item $index'),
              );
            },
            childCount: 50, // Adjust the number of items in the list
          ),
        ),
      ],
    );
  }

  Widget _buildNestedScrollView() {
    return NestedScrollView(
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
                  gradient: LinearGradient(
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
                          gradient: LinearGradient(
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
                                  'My Finance',
                                  style: const TextStyle(
                                      color: Color(0xFFFFFFFF),
                                      fontSize: 32,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Effortlessly manage your finance with a powerful simple tool in FinWise.',
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
                        ),
                      ),
                    ),

                    // center overview container
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      padding: EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 20,
                      ),
                      key: _centerContainerKey,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: _buildCenterContent(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ];
      },
      body: Container(
        child: Column(
          children: [
            // Add your non-scrollable content here
            Container(
              height: 100.0, // Adjust the height of your sticky container
              color: Colors.green, // Customize the color
              alignment: Alignment.center,
              child: Text('Sticky Container'),
            ),
            // Add more widgets as needed
          ],
        ),
      ),
    );
  }

  Widget _buildCenterContent() {
    return ListView(
      shrinkWrap: true,
      children: [
        Row(
          children: [
            IconConstant.piggyBank,
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total Balance', style: GeneralTextStyle.getSize(20)),
                Text(
                  '\$9645.50',
                  style:
                      GeneralTextStyle.getSize(32, color: ColorConstant.primary)
                          .copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
        Divider(color: ColorConstant.divider),
        // SizedBox(height: 10),
        TextButton(
          onPressed: () {
            // Navigator.of(context).push(
            //     MaterialPageRoute(builder: (context) => TestStickyContainer()));
          },
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            ),
          ),
          child: Text(
            'Update your net worth',
            style: GeneralTextStyle.getSize(
              16,
              color: ColorConstant.primary,
            ),
          ),
        ),
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
}
