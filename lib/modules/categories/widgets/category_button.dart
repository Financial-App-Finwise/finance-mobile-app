import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/modules/categories/models/categories_model.dart';
import 'package:finwise/modules/categories/screens/category_screen.dart';
import 'package:flutter/material.dart';

class CategoryButton extends StatefulWidget {
  final void Function(CategoryData) setCategory;
  CategoryData? category;
  bool? showTip;

  CategoryButton({
    super.key,
    required this.setCategory,
    this.category,
    this.showTip = true,
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
                      widget.category?.name == 'no name'
                          ? _unpickCategoryIcon()
                          : _pickedCategoryIcon(),
                      const SizedBox(
                        width: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Category',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              letterSpacing: 0.75,
                              color: ColorConstant.mainText,
                            ),
                          ),
                          Text(
                            widget.category?.name == 'no name'
                                ? 'Select one of the category'
                                : widget.category!.name,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              letterSpacing: 0.75,
                              color: widget.category?.name == 'no name'
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
            widget.showTip! ? _tip() : Container(),
          ],
        ));
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
        SVGName.expense,
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
        color: ColorConstant.expenseIcon,
        borderRadius: BorderRadius.circular(50),
      ),
      child: IconHelper.getSVG(
        SVGName.schoolBus,
        color: ColorConstant.white,
      ),
    );
  }

  Widget _tip() {
    return const Column(
      children: [
        SizedBox(
          height: 8,
        ),
        Text(
          'Spending in this category and sub-category will be accounted to this plan.',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12,
            letterSpacing: 0.5,
            color: ColorConstant.mainText,
          ),
        ),
      ],
    );
  }
}
