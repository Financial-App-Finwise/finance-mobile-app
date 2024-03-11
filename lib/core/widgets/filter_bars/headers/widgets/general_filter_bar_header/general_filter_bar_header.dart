import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/widgets/filter_bars/headers/models/filter_bar_header_item_model.dart';
import 'package:finwise/core/widgets/filter_bars/headers/stores/general_filter_bar_header_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class GeneralFilterBarHeader extends StatefulWidget {
  final List<FilterBarHeaderItem> items;
  final void Function(dynamic) onTap;
  late var currentValue;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final bool readOnly;

  GeneralFilterBarHeader({
    super.key,
    required this.items,
    required this.onTap,
    this.currentValue,
    this.padding,
    this.physics,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.readOnly = false,
  });

  @override
  State<GeneralFilterBarHeader> createState() => _GeneralFilterBarHeaderState();
}

class _GeneralFilterBarHeaderState extends State<GeneralFilterBarHeader> {
  final store = FilterBarHeaderStore();

  @override
  Widget build(BuildContext context) {
    store.currentValue = widget.currentValue;
    return Observer(builder: (context) {
      return Container(
        // color: Colors.red,
        padding: widget.padding ?? const EdgeInsets.all(8),
        child: widget.physics != null
            ? SingleChildScrollView(
                physics: widget.physics,
                scrollDirection: Axis.horizontal,
                child: _buildFilterBar(),
              )
            : _buildFilterBar(),
      );
    });
  }

  Widget _buildFilterBar() {
    return Row(
      mainAxisAlignment: widget.mainAxisAlignment,
      crossAxisAlignment: widget.crossAxisAlignment,
      children: widget.items.map(
        (item) {
          if (item.value == store.currentValue) {
            return _buildFilterBarItem(item.title, item.value,
                isSelected: true);
          }
          return _buildFilterBarItem(item.title, item.value);
        },
      ).toList(),
    );
  }

  Widget _buildFilterBarItem(
    String title,
    var value, {
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
        onPressed: widget.readOnly
            ? () {}
            : () {
                store.changeCurrentValue(value);
                widget.onTap(value);
              },
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
}
