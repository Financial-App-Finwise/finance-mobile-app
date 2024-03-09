import 'package:finwise/core/helpers/text_style_helper.dart';
import 'package:finwise/core/widgets/buttons/general_bottom_button.dart';
import 'package:flutter/material.dart';

class EmptyDataWidget extends StatefulWidget {
  Widget? icon;
  late String description;
  late String buttonLabel;
  late void Function() onButtonTap;

  EmptyDataWidget({
    super.key,
    this.icon,
    this.description = '',
    this.buttonLabel = '',
    required this.onButtonTap,
  });

  @override
  State<EmptyDataWidget> createState() => _EmptyDataWidgetState();
}

class _EmptyDataWidgetState extends State<EmptyDataWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildEmptyData(),
    );
  }

  Widget _buildEmptyData() {
    return Column(
      children: [
        SizedBox.fromSize(size: const Size(100, 100), child: widget.icon),
        const SizedBox(height: 8),
        Text(
          widget.description,
          style: TextStyleHelper.getw500size(16),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        GeneralBottomButton(
            buttonLabel: widget.buttonLabel, onButtonTap: widget.onButtonTap),
      ],
    );
  }
}
