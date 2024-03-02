import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/modules/onboarding_question/models/radio_button_model.dart';
import 'package:flutter/material.dart';

class CustomRowRadioButton extends StatefulWidget {
  final void Function(RadioButtonModel) setButton;
  final String question;
  final List<RadioButtonModel> list;
  final RadioButtonModel selectedButton;

  const CustomRowRadioButton({
    super.key,
    required this.setButton,
    required this.question,
    required this.list,
    required this.selectedButton,
  });

  @override
  State<CustomRowRadioButton> createState() => _CustomRowRadioButtonState();
}

class _CustomRowRadioButtonState extends State<CustomRowRadioButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.question,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24,
            letterSpacing: 1,
            color: ColorConstant.black,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.list.length,
          separatorBuilder: (BuildContext context, int index) => const SizedBox(
            width: 8,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  widget.setButton(widget.list[index]);
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 12,
                ),
                decoration:
                    widget.list[index].name != widget.selectedButton.name
                        ? BoxDecoration(
                            color: const Color.fromARGB(255, 236, 237, 238),
                            borderRadius: BorderRadius.circular(12),
                          )
                        : BoxDecoration(
                            color: Color(0xECFDFF80),
                            borderRadius: BorderRadius.circular(8),
                          ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.list[index].name ?? ''),
                    Container(
                      child: widget.list[index].icon,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
