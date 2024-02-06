import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/general_text_style_constant.dart';
import 'package:finwise/core/widgets/general_filter_bar/stores/general_filter_bar_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class RectFilterBar extends StatefulWidget {
  final List<String> filterTitles;
  late List<Widget>? children;
  final double topSpace;

  RectFilterBar({
    super.key,
    required this.filterTitles,
    this.children,
    this.topSpace = 12,
  });

  @override
  State<RectFilterBar> createState() => _RectFilterBarState();
}

class _RectFilterBarState extends State<RectFilterBar> {
  late final GeneralFilterBarStore store = GeneralFilterBarStore();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: _buildFilterBar(),
          ),
          SizedBox(height: widget.topSpace),
          _buildContent(),
        ],
      );
    });
  }

  Widget _buildFilterBar() {
    return Row(
      children: widget.filterTitles.map((title) {
        int index = widget.filterTitles.indexOf(title);
        if (index == store.currentIndex) {
          return Expanded(child: _buildRectangle(title, index, isFocused: true));
        }
        return Expanded(child: _buildRectangle(title, index));
      }).toList(),
    );
  }

  Widget _buildRectangle(
    String text,
    int index, {
    bool isFocused = false,
  }) {
    return TextButton(
      onPressed: () => store.changeIndex(index),
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
      ),
      child: Container(
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color:
                  isFocused ? ColorConstant.primary : ColorConstant.colorE9EAF1,
            ),
          ),
        ),
        child: Text(text,
            style: GeneralTextStyle.getSize(
              16,
              color: isFocused ? ColorConstant.primary : ColorConstant.mainText,
            )),
      ),
    );
  }

  Widget _buildContent() {
    widget.children =
        widget.children ?? widget.filterTitles.map((e) => const SizedBox()).toList();
    return widget.children![store.currentIndex];
  }
}
