import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/modules/categories/models/categories_model.dart';
import 'package:finwise/modules/categories/widgets/category_button.dart';
import 'package:finwise/modules/upcoming_bill/widgets/edit_upcoming_bill_screen/amount_input.dart';
import 'package:finwise/modules/upcoming_bill/widgets/edit_upcoming_bill_screen/expenses_name_input.dart';
import 'package:flutter/material.dart';

class EditUpcomingBuildScreen extends StatefulWidget {
  const EditUpcomingBuildScreen({super.key});

  @override
  State<EditUpcomingBuildScreen> createState() =>
      _EditUpcomingBuildScreenState();
}

class _EditUpcomingBuildScreenState extends State<EditUpcomingBuildScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _topContent(),
                const SizedBox(
                  height: 32,
                ),
                _form(),
                const SizedBox(
                  height: 20,
                ),
                _buttons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _topContent() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: IconHelper.getSVG(
                SVGName.close,
                color: ColorConstant.black,
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          const Text(
            'Edit upcoming bill',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 32,
              letterSpacing: 1,
              color: ColorConstant.black,
            ),
          )
        ],
      ),
    );
  }

  final _billAmountController = TextEditingController();
  final _expenseNameController = TextEditingController();
  final _noteController = TextEditingController();
  CategoryData _selectedCategory = CategoryData();

  Widget _form() {
    return Column(
      children: [
        AmountInput(
          controller: _billAmountController,
        ),
        const SizedBox(
          height: 20,
        ),
        CategoryButton(
          setCategory: (category) {
            // debugPrint('${category.id}');
            setState(() {
              _selectedCategory = category;
            });
            debugPrint(_selectedCategory.name);
          },
          category: _selectedCategory,
          showTip: false,
        ),
        const SizedBox(
          height: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpenseNameInput(controller: _expenseNameController),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Category name will be used if no custom name is set.',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                letterSpacing: 0.5,
                height: 1.5,
                color: ColorConstant.mainText,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        ExpenseNameInput(controller: _noteController),
      ],
    );
  }

  Widget _buttons() {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: _backButton(),
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: InkWell(
            onTap: () {},
            child: _saveButton(),
          ),
        ),
      ],
    );
  }

  Widget _backButton() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 24,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: ColorConstant.primary,
          width: 1,
        ),
      ),
      child: const Text(
        'Back',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          letterSpacing: 1,
          color: ColorConstant.primary,
        ),
      ),
    );
  }

  Widget _saveButton() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 24,
      ),
      decoration: BoxDecoration(
        color: ColorConstant.secondary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: ColorConstant.secondary,
          width: 1,
        ),
      ),
      child: const Text(
        'Save',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          letterSpacing: 1,
          color: ColorConstant.white,
        ),
      ),
    );
  }
}
