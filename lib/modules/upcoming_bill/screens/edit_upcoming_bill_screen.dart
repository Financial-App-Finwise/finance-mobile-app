import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/constants/text_style_constants/general_text_style_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/helpers/text_style_helper.dart';
import 'package:finwise/core/helpers/ui_helper.dart';
import 'package:finwise/modules/categories/models/categories_model.dart';
import 'package:finwise/modules/categories/screens/category_screen.dart';
import 'package:finwise/modules/categories/stores/category_store.dart';
import 'package:finwise/modules/categories/widgets/category_button.dart';
import 'package:finwise/modules/smart_goal/widgets/calendar_widget.dart';
import 'package:finwise/modules/upcoming_bill/models/upcoming_bill_model.dart';
import 'package:finwise/modules/upcoming_bill/stores/upcoming_bill_store.dart';
import 'package:finwise/modules/upcoming_bill/widgets/amount_input.dart';
import 'package:finwise/modules/upcoming_bill/widgets/expenses_name_input.dart';
import 'package:finwise/modules/upcoming_bill/widgets/note_input.dart';
import 'package:finwise/modules/upcoming_bill/widgets/upcoming_bill_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditUpcomingBuildScreen extends StatefulWidget {
  const EditUpcomingBuildScreen({super.key});

  @override
  State<EditUpcomingBuildScreen> createState() =>
      _EditUpcomingBuildScreenState();
}

class _EditUpcomingBuildScreenState extends State<EditUpcomingBuildScreen> {
  late final UpcomingBillData args =
      ModalRoute.of(context)!.settings.arguments as UpcomingBillData;

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

  late final _billAmountController =
      TextEditingController(text: '${args.amount}');
  late final _expenseNameController = TextEditingController(text: args.name);
  late final _noteController = TextEditingController(text: args.note);
  late List<CategoryData> categoryList =
      context.read<CategoryStore>().categoryModel.categoryDataList;
  late CategoryData _selectedCategory =
      categoryList.firstWhere((category) => category.id == args.categoryID);

  late final _upcomingDateController =
      TextEditingController(text: UIHelper.getInputDate(args.date.toString()));
  DateTime _selectedUpcomingDay = DateTime.now(); // save value for posting

  Widget _form() {
    return Column(
      children: [
        AmountInput(
          controller: _billAmountController,
        ),
        const SizedBox(
          height: 20,
        ),
        _buildDate(
          hintText: 'Upcoming bill date',
          controller: _upcomingDateController,
          onDaySelected: (selectedDay, focusedDay) {
            setState(
              () {
                _upcomingDateController.text =
                    UIHelper.getInputDate(selectedDay.toString());
                _selectedUpcomingDay = selectedDay;
              },
            );
          },
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
            onTap: () async {
              String upcomingBillDate = UIHelper.getDateFormat(
                _selectedUpcomingDay.toString(),
                'yyyy-MM-dd',
              );

              bool success = false;

              success = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpcomingBillEditScreen(
                    upcomingBillData: UpcomingBillData(
                      id: args.id,
                      categoryID: _selectedCategory.id,
                      amount: int.parse(_billAmountController.text),
                      date: "$upcomingBillDate 12:00:00",
                      name: _expenseNameController.text == ''
                          ? _selectedCategory.name
                          : _expenseNameController.text,
                      note: _noteController.text,
                    ),
                  ),
                ),
              );

              if (success) {
                Navigator.pop(context, success);
              }
            },
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

  Widget _buildDate({
    String hintText = '',
    TextEditingController? controller,
    required void Function(DateTime selectedDay, DateTime focusedDay)
        onDaySelected,
  }) {
    return TextFormField(
      controller: controller,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CalendarWidget(
              onDaySelected: onDaySelected,
            ),
          ),
        );
      },
      style: TextStyleHelper.getw500size(14),
      readOnly: true,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.all(25),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
        fillColor: Colors.white,
        filled: true,
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: IconHelper.getSVG(
            SVGName.calendar,
            color: ColorConstant.mainText,
          ),
        ),
        hintText: hintText,
        hintStyle: GeneralTextStyle.getSize(12, color: ColorConstant.thin),
      ),
    );
  }
}
