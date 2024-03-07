import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/modules/transaction/widgets/upcoming_bill_button/select_upcoming_bill_widget.dart';
import 'package:finwise/modules/upcoming_bill/models/upcoming_bill_model.dart';
import 'package:flutter/material.dart';

class UpcomingBillButton extends StatefulWidget {
  late void Function(UpcomingBillData) onPressed;
  late int defaultBillId;
  late String defaultBillName;

  UpcomingBillButton({
    super.key,
    required this.onPressed,
    this.defaultBillId = 0,
    this.defaultBillName = '',
  });

  @override
  State<UpcomingBillButton> createState() => _UpcomingBillButtonState();
}

class _UpcomingBillButtonState extends State<UpcomingBillButton> {
  late UpcomingBillData selectedUpcomingBill = UpcomingBillData(
    id: widget.defaultBillId,
    name: widget.defaultBillName,
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              SelectUpcomingBillWidget(
            onPressed: (upcomingBillData) {
              setState(() {
                selectedUpcomingBill = upcomingBillData;
              });
              widget.onPressed(upcomingBillData);
            },
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
      ),
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
                    selectedUpcomingBill.name.isEmpty
                        ? _unpickCategoryIcon()
                        : _pickedCategoryIcon(),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Upcoming Bill',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            letterSpacing: 0.75,
                            color: ColorConstant.mainText,
                          ),
                        ),
                        Text(
                          selectedUpcomingBill.name.isEmpty
                              ? 'Select one upcoming bill'
                              : selectedUpcomingBill.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            letterSpacing: 0.75,
                            color: selectedUpcomingBill.name.isEmpty
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

  Widget _unpickCategoryIcon() {
    return Container(
      width: 36,
      height: 36,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color(0xFFD3D5E4),
        borderRadius: BorderRadius.circular(50),
      ),
      child: IconHelper.getSVG(
        SVGName.upcomingBill,
        color: ColorConstant.white,
      ),
    );
  }

  Widget _pickedCategoryIcon() {
    return Container(
      width: 36,
      height: 36,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: ColorConstant.bill,
        borderRadius: BorderRadius.circular(50),
      ),
      child: IconHelper.getSVG(
        SVGName.upcomingBill,
        color: ColorConstant.white,
      ),
    );
  }
}
