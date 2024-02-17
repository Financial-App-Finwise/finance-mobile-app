import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/helpers/text_style_helper.dart';
import 'package:finwise/core/widgets/filter_bars/headers/models/filter_bar_header_item_model.dart';
import 'package:finwise/core/widgets/filter_bars/headers/stores/general_filter_bar_header_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

enum RectFilterBarHeaderType {
  simple,
  expanded,
  scrollable,
}

class RectFilterBarHeader extends StatefulWidget {
  final List<FilterBarHeaderItem> items;
  final void Function(dynamic) onTap;
  late var currentValue;
  late final double fontSize;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  late final MainAxisAlignment mainAxisAlignment;
  late final CrossAxisAlignment crossAxisAlignment;
  late final RectFilterBarHeaderType type;

  RectFilterBarHeader({
    super.key,
    required this.items,
    required this.onTap,
    this.currentValue,
    this.fontSize = 14,
    this.padding,
    this.physics,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.type = RectFilterBarHeaderType.simple,
  });

  @override
  State<RectFilterBarHeader> createState() => _RectFilterBarHeaderState();
}

class _RectFilterBarHeaderState extends State<RectFilterBarHeader> {
  final store = FilterBarHeaderStore();

  @override
  Widget build(BuildContext context) {
    store.currentValue = widget.currentValue;
    return Observer(builder: (context) {
      return Container(
        alignment: Alignment.topLeft,
        padding: widget.padding ?? const EdgeInsets.all(8),
        child: _buildType(widget.type),
      );
    });
  }

  Widget _buildType(RectFilterBarHeaderType type) {
    switch (type) {
      case RectFilterBarHeaderType.expanded:
        return _buildExpanded();
      case RectFilterBarHeaderType.scrollable:
        return _buildScrollable();
      default:
        return _buildSimple();
    }
  }

  Widget _buildSimple() {
    return _buildFilterBar();
  }

  Widget _buildScrollable() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: _buildFilterBar(),
    );
  }

  Widget _buildExpanded() {
    return _buildFilterBar(isExpanded: true);
  }

  Widget _buildFilterBar({
    bool isExpanded = false,
  }) {
    return Row(
      mainAxisAlignment: widget.mainAxisAlignment,
      crossAxisAlignment: widget.crossAxisAlignment,
      children: widget.items.map(
        (item) {
          if (item.value == store.currentValue) {
            return isExpanded
                ? Expanded(
                    child: _buildFilterBarItem(item.title, item.value,
                        isSelected: true))
                : _buildFilterBarItem(item.title, item.value, isSelected: true);
          }
          return isExpanded
              ? Expanded(child: _buildFilterBarItem(item.title, item.value))
              : _buildFilterBarItem(item.title, item.value);
        },
      ).toList(),
    );
  }

  Widget _buildFilterBarItem(
    String text,
    var value, {
    bool isSelected = false,
  }) {
    return TextButton(
      onPressed: () {
        store.changeCurrentValue(value);
        widget.onTap(value);
      },
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
      ),
      child: Container(
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected
                  ? ColorConstant.primary
                  : ColorConstant.colorE9EAF1,
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyleHelper.getw500size(
            widget.fontSize,
            color: isSelected ? ColorConstant.primary : ColorConstant.mainText,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
