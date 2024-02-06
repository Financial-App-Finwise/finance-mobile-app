import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/font_constant.dart';
import 'package:finwise/core/constants/text_style_constants/home_text_style_constant.dart';
import 'package:finwise/core/widgets/duration_drop_down/stores/duration_drop_down_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class DurationDropDown extends StatefulWidget {
  const DurationDropDown({super.key});

  @override
  State<DurationDropDown> createState() => _DurationDropDownState();
}

class _DurationDropDownState extends State<DurationDropDown> {
  final _store = DurationDropDownStore();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Center(
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            onChanged: (value) => _store.setValue(value),
            value: _store.selectedValue,
            items: _getItem(),
            style: const TextStyle(
              fontFamily: FontConstant.balooThambi2,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: ColorConstant.mainText,
              letterSpacing: 1,
            ),
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
    });
  }

  List<DropdownMenuItem> _getItem() {
    List<DropdownMenuItem<String>> menuItems = [];
    for (final item in _store.items) {
      menuItems.addAll(
        [
          DropdownMenuItem(
            value: item,
            child: Text(item),
          ),
          if (item != _store.items.last)
            const DropdownMenuItem(
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
    for (int i = 0; i < (_store.items.length * 2) - 1; i++) {
      if (i.isEven) {
        itemsHeights.add(40);
      } else {
        itemsHeights.add(4);
      }
    }
    return itemsHeights;
  }
}
