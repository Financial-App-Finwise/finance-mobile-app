import 'package:flutter/material.dart';

class ScreenNavigationModel {
  late Widget screen;
  late int index;
  late bool isSelected;
  late String svgName;
  late String label;

  ScreenNavigationModel({
    required this.screen,
    this.index = 0,
    this.isSelected = false,
    this.svgName = '',
    this.label = '',
  });
}