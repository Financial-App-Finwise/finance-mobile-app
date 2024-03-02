import 'package:flutter/material.dart';

class FullHeightContainer extends StatelessWidget {
  final Widget child;

  const FullHeightContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;
    return Container(
      height: fullHeight,
      width: double.infinity,
      child: child,
    );
  }
}
