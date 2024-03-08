import 'package:finwise/core/constants/color_constant.dart';
import 'package:flutter/material.dart';

class CustomRefreshIndicator extends StatelessWidget {
  late Future Function() onRefresh;
  late Widget child;

  CustomRefreshIndicator({
    super.key,
    required this.onRefresh,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: ColorConstant.primary,
      child: child,
    );
  }
}
