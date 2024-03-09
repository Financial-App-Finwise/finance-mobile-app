import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/modules/onboarding_question/models/radio_button_model.dart';
import 'package:flutter/material.dart';

class CustomRadioButton extends StatefulWidget {
  final void Function(RadioButtonModel) setButton;
  final String question;
  final List<RadioButtonModel> list;
  final RadioButtonModel selectedButton;

  CustomRadioButton({
    super.key,
    required this.setButton,
    required this.question,
    required this.list,
    required this.selectedButton,
  });

  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
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
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.list.length,
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(height: 20),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  widget.setButton(widget.list[index]);
                });
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration:
                    widget.list[index].name != widget.selectedButton.name
                        ? BoxDecoration(
                            color: const Color.fromARGB(255, 236, 237, 238),
                            borderRadius: BorderRadius.circular(12),
                          )
                        : BoxDecoration(
                            color: const Color(0xFFECFDFF).withOpacity(0.5),
                            border: Border.all(
                              color: ColorConstant.secondary,
                            ),
                            borderRadius: BorderRadius.circular(12),
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
