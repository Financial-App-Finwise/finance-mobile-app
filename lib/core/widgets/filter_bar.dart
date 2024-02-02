import 'package:flutter/material.dart';

class FilterBar extends StatelessWidget {
  final List<String> filterTitles;

  const FilterBar({
    super.key,
    required this.filterTitles,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _buildFilterBarLink(),
        ),
      ),
    );
  }

  List<Widget> _buildFilterBarLink() {
    return filterTitles.map((title) => _filterBarLink(title)).toList();
  }

  Widget _filterBarLink(String title) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF0ABDE3),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xFFFFFFFF),
        ),
      ),
    );
  }
}
