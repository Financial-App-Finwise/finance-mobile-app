import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/widgets/custom_icon_button.dart';
import 'package:finwise/modules/categories/models/categories_model.dart';
import 'package:finwise/modules/categories/screens/category_create_screen.dart';
import 'package:finwise/modules/categories/stores/category_store.dart';
import 'package:finwise/modules/categories/widgets/category_button.dart';
import 'package:finwise/modules/categories/widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              categoryHeader(),
              headerFilter(),
              const SizedBox(
                height: 16,
              ),
              mainContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget categoryHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomIconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: IconHelper.getSVG(
              SVGName.close,
              color: ColorConstant.black,
            ),
          ),
          const Text(
            'Add Category',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              letterSpacing: 1,
              color: ColorConstant.black,
            ),
          ),
          _isFormFilled
              ? InkWell(
                  onTap: () async {
                    bool success = false;

                    success = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryCreateScreen(
                          categoryData: CategoryData(
                              name: categoryController.text,
                              isIncome: context.read<CategoryStore>().isIncome,
                              parentID: selectedCategory.id),
                        ),
                      ),
                    );

                    if (success) {
                      Navigator.pop(context);
                      await context.read<CategoryStore>().read();
                    }
                  },
                  child: const Text(
                    'Done',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      letterSpacing: 1,
                      color: ColorConstant.secondary,
                    ),
                  ),
                )
              : Text(
                  'Done',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    letterSpacing: 1,
                    color: ColorConstant.secondary.withOpacity(0.4),
                  ),
                ),
        ],
      ),
    );
  }

  bool get _isFormFilled => categoryController.text.isNotEmpty;

  Widget headerFilter() {
    return Observer(
      builder: (context) {
        bool isIncome = context.watch<CategoryStore>().isIncome;

        return Row(
          children: [
            filterButton(
                'Expense',
                isIncome ? const Color(0xFFA4A7C6) : ColorConstant.secondary,
                isIncome ? ColorConstant.colorE9EAF1 : ColorConstant.secondary,
                () {
              context.read<CategoryStore>().setIsIncome(false);
            }),
            filterButton(
                'Income',
                isIncome ? ColorConstant.secondary : const Color(0xFFA4A7C6),
                isIncome ? ColorConstant.secondary : ColorConstant.colorE9EAF1,
                () {
              context.read<CategoryStore>().setIsIncome(true);
            }),
          ],
        );
      },
    );
  }

  Widget filterButton(
      String title, Color textColor, Color buttonColor, VoidCallback action) {
    return Expanded(
      child: InkWell(
        onTap: action,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: buttonColor,
                width: 2,
              ),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              letterSpacing: 1,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  TextEditingController categoryController = TextEditingController();
  CategoryData selectedCategory = CategoryData();

  Widget mainContent() {
    return SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              CustomTextInput(
                controller: categoryController,
                hintText: 'Spa',
                label: 'Category',
                onChange: (value) {
                  setState(() {
                    _isFormFilled;
                  });
                },
              ),
              const SizedBox(
                height: 16,
              ),
              CategoryButton(
                setCategory: (category) {
                  setState(() {
                    selectedCategory = category;
                    _isFormFilled;
                  });
                },
                category: selectedCategory,
                showTip: false,
                isPost: true,
                parentOnly: true,
              )
            ],
          ),
        ));
  }
}
