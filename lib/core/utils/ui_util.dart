import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:flutter/material.dart';

abstract class UIUtil {
  static void showModal(
    BuildContext context,
    String title,
    String subTitle, {
    VoidCallback? onTap,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
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
                  title,
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
                  subTitle,
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
                          Navigator.of(ctx).pop();
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
                          child: const Text(
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
                        onTap: onTap,
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
                          child: const Text(
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
