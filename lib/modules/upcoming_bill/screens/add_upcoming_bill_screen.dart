import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/constants/text_style_constants/general_text_style_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/helpers/text_style_helper.dart';
import 'package:finwise/core/helpers/ui_helper.dart';
import 'package:finwise/modules/categories/models/categories_model.dart';
import 'package:finwise/modules/categories/widgets/category_button.dart';
import 'package:finwise/modules/smart_goal/widgets/calendar_widget.dart';
import 'package:finwise/modules/upcoming_bill/models/upcoming_bill_model.dart';
import 'package:finwise/modules/upcoming_bill/screens/upcoming_bill_create_screen.dart';
import 'package:finwise/modules/upcoming_bill/stores/upcoming_bill_store.dart';
import 'package:finwise/modules/upcoming_bill/widgets/amount_input.dart';
import 'package:finwise/modules/upcoming_bill/widgets/expenses_name_input.dart';
import 'package:finwise/modules/upcoming_bill/widgets/note_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                _addButton(),
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

  final _upcomingDateController = TextEditingController();
  DateTime _selectedUpcomingDay = DateTime.now(); // save value for posting

  Widget _form() {
    return Column(
      children: [
        AmountInput(
          controller: _billAmountController,
          onChange: (value) => setState(() {
            _isFormFilled;
          }),
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
                _isFormFilled;
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
              _isFormFilled;
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

  bool get _isFormFilled =>
      _billAmountController.text.isNotEmpty &&
      _selectedCategory.id != 0 &&
      _selectedUpcomingDay.toString().isNotEmpty;

  Widget _addButton() {
    return _isFormFilled
        ? InkWell(
            onTap: () async {
              String upcomingBillDate = UIHelper.getDateFormat(
                _selectedUpcomingDay.toString(),
                'yyyy-MM-dd',
              );

              bool success = false;

              success = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpcomingBillCreateScreen(
                    upcomingBillData: UpcomingBillData(
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
                Navigator.pop(context);
                await context.read<UpcomingBillStore>().read(refreshed: true);
              }
            },
            child: Container(
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
            ),
          )
        : Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 24,
            ),
            decoration: BoxDecoration(
              color: ColorConstant.secondary.withOpacity(0.4),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: ColorConstant.secondary.withOpacity(0.4),
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
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
