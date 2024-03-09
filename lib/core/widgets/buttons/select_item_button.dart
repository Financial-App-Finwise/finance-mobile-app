import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:flutter/material.dart';

class SelectItemButton extends StatefulWidget {
  final String title;
  final String subTitle;
  final SelectItem currentItem;
  final Widget selectionScreen;

  const SelectItemButton({
    super.key,
    this.title = '',
    this.subTitle = '',
    required this.selectionScreen,
    required this.currentItem,
  });

  @override
  State<SelectItemButton> createState() => _SelectItemButtonState();
}

class _SelectItemButtonState extends State<SelectItemButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // wait for item selection
        await Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (
              context,
              animation,
              secondaryAnimation,
            ) =>
                widget.selectionScreen,
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              final tween = Tween(begin: begin, end: end);
              final offsetAnimation = animation.drive(tween);

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
          ),
        );
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 20,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: ColorConstant.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    widget.currentItem.itemPicked
                        ? _pickedIcon()
                        : _unpickedIcon(),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            letterSpacing: 0.75,
                            color: ColorConstant.mainText,
                          ),
                        ),
                        Text(
                          widget.currentItem.itemPicked
                              ? widget.currentItem.subTitle
                              : widget.subTitle,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            letterSpacing: 0.75,
                            color: widget.currentItem.title.isEmpty
                                ? const Color(0xFF656B9F)
                                : ColorConstant.mainText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                IconHelper.getSVG(
                  SVGName.arrowRight,
                  color: ColorConstant.thin,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _unpickedIcon() {
    return Container(
      width: 36,
      height: 36,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color(0xFFD3D5E4),
        borderRadius: BorderRadius.circular(50),
      ),
      child: widget.currentItem.unpickedIcon,
    );
  }

  Widget _pickedIcon() {
    return Container(
      width: 36,
      height: 36,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: widget.currentItem.backgroundColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: widget.currentItem.pickedIcon,
    );
  }
}

class SelectItem<T> {
  late T item;
  late bool itemPicked;
  late String title;
  late String subTitle;
  late Widget pickedIcon;
  late Widget unpickedIcon;
  late Color backgroundColor;

  SelectItem({
    this.title = '',
    this.subTitle = '',
    this.itemPicked = false,
    this.backgroundColor = Colors.blue,
    required this.pickedIcon,
    required this.unpickedIcon,
    required this.item,
  });
}