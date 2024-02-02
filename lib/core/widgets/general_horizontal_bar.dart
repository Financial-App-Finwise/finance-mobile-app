// import 'package:finwise/core/constants/color_constant.dart';
// import 'package:flutter/material.dart';

// class GeneralHorizontalBar extends StatefulWidget {
//   const GeneralHorizontalBar({super.key});

//   @override
//   State<GeneralHorizontalBar> createState() => _GeneralHorizontalBarState();
// }

// class _GeneralHorizontalBarState extends State<GeneralHorizontalBar> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }

//   Widget _buildFilterBar() {
//     return Row(
//       children: widget.filterTitles.map((title) {
//         int index = widget.filterTitles.indexOf(title);
//         if (index == _currentIndex) {
//           return _buildFilterBarItem(title, index, isSelected: true);
//         }
//         return _buildFilterBarItem(title, index);
//       }).toList(),
//     );
//   }

//   Widget _buildFilterBarItem(
//     String title,
//     index, {
//     bool isSelected = false,
//   }) {
//     return InkWell(
//       onTap: () {
//         setState(() {
//           _currentIndex = index;
//         });
//       },
//       child: Container(
//         margin: const EdgeInsets.only(right: 12),
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//         decoration: BoxDecoration(
//           color: isSelected ? Color(0xFF0ABDE3) : ColorConstant.backgroundColor,
//           borderRadius: BorderRadius.circular(15),
//           border: Border.all(
//             color: isSelected ? Color(0xFF0ABDE3) : ColorConstant.colorE9EAF1,
//           ),
//         ),
//         child: Text(
//           title,
//           style: TextStyle(
//             color: isSelected ? Colors.white : ColorConstant.mainText,
//           ),
//         ),
//       ),
//     );
//   }
// }
