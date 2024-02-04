import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:flutter/material.dart';

class GeneralDetailLayout extends StatefulWidget {
  const GeneralDetailLayout({
    super.key,
    this.mainContent,
    this.gradient,
    this.themeColor,
  });

  final Widget? mainContent;
  final LinearGradient? gradient;
  final Color? themeColor;

  @override
  State<GeneralDetailLayout> createState() => _GeneralDetailLayoutState();
}

class _GeneralDetailLayoutState extends State<GeneralDetailLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: widget.gradient),
        child: SafeArea(
          child: Column(
            children: [
              _topBarContent(),
              Expanded(
                child: Container(
                  alignment: Alignment.topLeft,
                  color: ColorConstant.backgroundColor,
                  child: widget.mainContent ?? SizedBox(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topBarContent() {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(gradient: widget.gradient),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          SizedBox(
            width: 24,
            height: 24,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 24,
              ),
              style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                iconColor: MaterialStateProperty.all(
                  const Color(0xFFFFFFFF),
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Title
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(4)),
                    child: Icon(
                      Icons.car_rental_outlined,
                      color: widget.themeColor,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Transportation',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            color: Color(0xFFFFFFFF)),
                      ),
                      Text(
                        'Budget Category',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Color(0xFFFFFFFF)),
                      ),
                    ],
                  ),
                ],
              ),

              // Action Icon Buttons
              Row(
                children: [
                  // Edit Icon Button
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: IconButton(
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const EditBudgetPlanScreen(),
                        //   ),
                        // );
                      },
                      icon: IconConstant.edit,
                      style: ButtonStyle(
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(0)),
                      ),
                    ),
                  ),

                  const SizedBox(width: 6),

                  // Delete Icon Button
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: IconButton(
                      onPressed: () {
                        _showModal(context);
                      },
                      icon: IconConstant.delete,
                      style: ButtonStyle(
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(0)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  void _showModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorConstant.white,
          elevation: 0,
          contentPadding: const EdgeInsets.all(16),
          content: IntrinsicHeight(
            child: SizedBox(
              child: Column(children: [
                SizedBox(
                  width: 125,
                  height: 125,
                  child: IconConstant.myBudget(color: Colors.red),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Are you sure you want to delete this SMART gaol?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    height: 1.5,
                    letterSpacing: 1,
                    color: ColorConstant.black,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'You will delete every transaction added to this goal.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    height: 1.5,
                    letterSpacing: 0.5,
                    color: ColorConstant.mainText,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 24,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xFFE9EAF1),
                          ),
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 1,
                              color: ColorConstant.thin,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 24,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: ColorConstant.expense,
                          ),
                          child: Text(
                            'Delete',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 1,
                              color: ColorConstant.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ]),
            ),
          ),
        );
      },
    );
  }
}
