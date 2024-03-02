import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/font_constant.dart';
import 'package:finwise/core/widgets/duration_drop_down/models/duration_drop_down_item_model.dart';
import 'package:finwise/core/widgets/duration_drop_down/stores/duration_drop_down_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class PeriodDropDown extends StatefulWidget {
  PeriodDropDown({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onChange,
  });

  late List<DurationDropDownItem> items;
  late String selectedValue;
  late void Function(dynamic) onChange;

  @override
  State<PeriodDropDown> createState() => _PeriodDropDownState();
}

class _PeriodDropDownState extends State<PeriodDropDown> {
  final _store = DurationDropDownStore();

  @override
  void initState() {
    super.initState();
    _store.items = ObservableList.of(widget.items);
    _store.selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Center(
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            onChanged: (value) {
              _store.setValue(value);
              widget.onChange(value);
            },
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
            value: item.value,
            child: Text(item.title),
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
