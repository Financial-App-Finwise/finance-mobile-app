import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/widgets/general_filter_bar/stores/general_filter_bar_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class GeneralFilterBar extends StatefulWidget {
  final List<String> filterTitles;
  late List<Widget>? children;
  final double topSpace;

  GeneralFilterBar({
    super.key,
    required this.filterTitles,
    this.children,
    this.topSpace = 12,
  });

  @override
  State<GeneralFilterBar> createState() => _GeneralFilterBarState();
}

class _GeneralFilterBarState extends State<GeneralFilterBar> {
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
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: _buildFilterBar(),
            ),
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
          return _buildFilterBarItem(title, index, isSelected: true);
        }
        return _buildFilterBarItem(title, index);
      }).toList(),
    );
  }

  Widget _buildFilterBarItem(
    String title,
    index, {
    bool isSelected = false,
  }) {
    return Container(
      height: 32,
      margin: const EdgeInsets.only(right: 12),
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: isSelected
            ? const Color(0xFF0ABDE3)
            : ColorConstant.backgroundColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color:
              isSelected ? const Color(0xFF0ABDE3) : ColorConstant.colorE9EAF1,
        ),
      ),
      child: TextButton(
        onPressed: () => store.changeIndex(index),
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
        ),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : ColorConstant.mainText,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    widget.children =
        widget.children ?? widget.filterTitles.map((e) => const SizedBox()).toList();
    return widget.children![store.currentIndex];
  }
}
