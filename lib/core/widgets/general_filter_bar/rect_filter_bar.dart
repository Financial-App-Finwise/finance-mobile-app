import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/text_style_constants/general_text_style_constant.dart';
import 'package:finwise/core/helpers/text_style_helper.dart';
import 'package:finwise/core/widgets/general_filter_bar/stores/general_filter_bar_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class RectFilterBar extends StatefulWidget {
  final List<String> filterTitles;
  late List<Widget>? children;
  final double topSpace;
  final ScrollPhysics? physics;
  final double fontSize;

  RectFilterBar({
    super.key,
    required this.filterTitles,
    this.children,
    this.topSpace = 12,
    this.physics,
    this.fontSize = 14,
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
        physics: widget.physics ?? NeverScrollableScrollPhysics(),
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
          return Expanded(
              child: _buildFilterBarItem(title, index, isFocused: true));
        }
        return Expanded(child: _buildFilterBarItem(title, index));
      }).toList(),
    );
  }

  Widget _buildFilterBarItem(
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
        child: Text(
          text,
          style: TextStyleHelper.getw500size(
            widget.fontSize,
            color: isFocused ? ColorConstant.primary : ColorConstant.mainText,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _buildContent() {
    widget.children = widget.children ??
        widget.filterTitles.map((e) => const SizedBox()).toList();
    return widget.children![store.currentIndex];
  }
}
