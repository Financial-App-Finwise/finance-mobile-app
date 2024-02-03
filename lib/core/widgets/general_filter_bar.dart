import 'package:finwise/core/constants/color_constant.dart';
import 'package:flutter/material.dart';

class GeneralFilterBar extends StatefulWidget {
  final List<String> filterTitles;
  final List<Widget> children;
  final double topSpace;

  const GeneralFilterBar({
    super.key,
    required this.filterTitles,
    required this.children,
    this.topSpace = 12,
  });

  @override
  State<GeneralFilterBar> createState() => _GeneralFilterBarState();
}

class _GeneralFilterBarState extends State<GeneralFilterBar> {
  late int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
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
  }

  Widget _buildFilterBar() {
    return Row(
      children: widget.filterTitles.map((title) {
        int index = widget.filterTitles.indexOf(title);
        if (index == _currentIndex) {
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
    return InkWell(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF0ABDE3) : ColorConstant.backgroundColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? Color(0xFF0ABDE3) : ColorConstant.colorE9EAF1,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : ColorConstant.mainText,
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return widget.children[_currentIndex];
  }
}
