import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/modules/categories/models/categories_model.dart';
import 'package:finwise/modules/categories/widgets/category_button.dart';
import 'package:finwise/modules/upcoming_bill/widgets/amount_input.dart';
import 'package:finwise/modules/upcoming_bill/widgets/expenses_name_input.dart';
import 'package:finwise/modules/upcoming_bill/widgets/note_input.dart';
import 'package:flutter/material.dart';

class AddUpcomingBillScreen extends StatefulWidget {
  const AddUpcomingBillScreen({super.key});

  @override
  State<AddUpcomingBillScreen> createState() => _AddUpcomingBillScreenState();
}

class _AddUpcomingBillScreenState extends State<AddUpcomingBillScreen> {
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
                _saveButton(),
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
            'Add upcoming bill',
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
        NoteInput(controller: _noteController),
      ],
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
        'Add upcoming bill',
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
