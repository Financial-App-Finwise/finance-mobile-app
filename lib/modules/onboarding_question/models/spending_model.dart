import 'package:flutter/material.dart';

class SpendingModel {
  String type;
  TextEditingController controller;

  SpendingModel({
    this.type = 'Daily',
    TextEditingController? controller,
  }) : controller = controller ?? TextEditingController();
}
