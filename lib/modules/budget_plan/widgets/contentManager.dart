import 'package:flutter/material.dart';

class ContentManager extends StatefulWidget {
  const ContentManager({
    super.key,
    Color gradient1 = const Color(0xFF0ABDE3),
    Color gradient2 = const Color(0xFF0B8AAF),
  });

  @override
  State<ContentManager> createState() => _ContentManagerState();
}

class _ContentManagerState extends State<ContentManager> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFFF5F7F8),
      ),
      child: Stack(children: [
        Positioned(
          child: Container(
            height: 31,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFF0ABDE3), Color(0xFF0B8AAF)],
                  stops: [0.2, 0.8]),
            ),
          ),
        ),
        Positioned(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: _contentManager(),
          ),
        ),
      ]),
    );
  }

  // Content manager
  Widget _contentManager() {
    return Container(
      height: 62,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.dashboard_customize_outlined,
            size: 24,
            color: Color(0xFF191B29),
          ),
          Text('Dec'),
          SizedBox(
            width: 24,
            height: 24,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.add_box_outlined,
                size: 24,
              ),
              style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                iconColor: MaterialStateProperty.all(
                  Color(0xFF0ABDE3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
