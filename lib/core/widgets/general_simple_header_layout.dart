import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/widgets/top_back_arrow.dart';
import 'package:flutter/material.dart';

class GeneralSimpleHeaderLayout extends StatelessWidget {
  const GeneralSimpleHeaderLayout({
    super.key,
    this.title = '',
    this.description = '',
    this.color,
    this.gradient,
    this.child,
  });

  final String title;
  final String description;
  final Color? color;
  final LinearGradient? gradient;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: gradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // header
              Container(
                alignment: Alignment.topLeft,
                padding:
                    const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 8),
                decoration: BoxDecoration(
                  gradient: gradient,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TopBackArrow(),
                    const SizedBox(height: 12),
                    Text(
                      title,
                      style: const TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 32,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 14,
                        height: 1.7,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              // content
              Expanded(
                child: Container(
                  
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  color: ColorConstant.backgroundColor,
                  child: child ?? const SizedBox(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
