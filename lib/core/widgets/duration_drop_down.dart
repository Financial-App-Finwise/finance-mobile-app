import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/home_text_style_constant.dart';
import 'package:flutter/material.dart';

class DurationDropDown extends StatefulWidget {
  const DurationDropDown({super.key});

  @override
  State<DurationDropDown> createState() => _DurationDropDownState();
}

class _DurationDropDownState extends State<DurationDropDown> {
  final List _items = [
    'This Month',
    'This Week',
    'Last Week',
    'Last Month',
    'Last 3 Months',
    'Last 6 Months',
  ];

  String _selectedValue = 'This Month';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          onChanged: (value) {
            setState(() => _selectedValue = value);
          },
          value: _selectedValue,
          items: _getItem(),
          style: HomeTextStyleConstant.small,
          isDense: true,
          buttonStyleData: ButtonStyleData(
            overlayColor:
                MaterialStateProperty.all(Colors.black.withOpacity(0.5)),
            height: 36,
            // width: 128,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: const Border.fromBorderSide(
                  BorderSide(color: Color(0xffD3D5E4))),
            ),
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          menuItemStyleData: MenuItemStyleData(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            customHeights: _getCustomHeights(),
          ),
          iconStyleData: const IconStyleData(
            openMenuIcon: Icon(Icons.arrow_drop_up),
            iconSize: 20,
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem> _getItem() {
    List<DropdownMenuItem<String>> menuItems = [];
    for (final item in _items) {
      menuItems.addAll(
        [
          DropdownMenuItem(
            value: item,
            child: Text(item),
          ),
          if (item != _items.last)
            DropdownMenuItem(
              enabled: false,
              child: Divider(color: ColorConstant.divider),
            ),
        ],
      );
    }
    return menuItems;
  }

  List<double> _getCustomHeights() {
    final List<double> itemsHeights = [];
    for (int i = 0; i < (_items.length * 2) - 1; i++) {
      if (i.isEven) {
        itemsHeights.add(40);
      } else {
        itemsHeights.add(4);
      }
    }
    return itemsHeights;
  }
}
