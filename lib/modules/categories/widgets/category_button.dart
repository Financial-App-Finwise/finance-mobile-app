import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/modules/categories/models/categories_model.dart';
import 'package:finwise/modules/categories/screens/category_screen.dart';
import 'package:flutter/material.dart';

class CategoryButton extends StatefulWidget {
  final void Function(CategoryData) setCategory;
  CategoryData? category;

  CategoryButton({
    super.key,
    required this.setCategory,
    this.category,
  });

  @override
  State<CategoryButton> createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    CategoryScreen(setCategory: widget.setCategory),
              ),
            ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 20,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: ColorConstant.white,
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: ColorConstant.topSpending,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Category'),
                  Text(
                    widget.category?.name == 'no name'
                        ? 'Select one of the category'
                        : widget.category!.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      letterSpacing: 0.75,
                      color: ColorConstant.mainText,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
