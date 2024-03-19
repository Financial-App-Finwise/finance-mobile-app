import 'package:finwise/modules/categories/widgets/category_button.dart';
import 'package:finwise/modules/transaction/widgets/form_fields/transaction_amount_text_field.dart';
import 'package:finwise/modules/transaction/widgets/form_fields/transaction_date_text_field.dart';
import 'package:finwise/core/widgets/form_fields/error_field.dart';
import 'package:finwise/modules/transaction/widgets/form_fields/transaction_note_text_field.dart';
import 'package:flutter/material.dart';

class TransactionIncomeForm extends StatefulWidget {
  final TextEditingController amountIncomeController;
  final TextEditingController dateController;
  final TextEditingController noteController;

  const TransactionIncomeForm({
    super.key,
    required this.amountIncomeController,
    required this.dateController,
    required this.noteController,
  });

  @override
  State<TransactionIncomeForm> createState() => _TransactionIncomeFormState();
}

class _TransactionIncomeFormState extends State<TransactionIncomeForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TransactionAmountTextField(controller: widget.amountIncomeController),
        // _buildErrorField('Required', _amountError),
        const SizedBox(height: 24),
        // CategoryButton(
        //   setCategory: (categoryData) {
        //     _resetItem();
        //     setState(() {
        //       _isIncome
        //           ? _selectedIncomeCategory = categoryData
        //           : _selectedIncomeCategory = categoryData;
        //     });
        //   },
        //   category:
        //       _isIncome ? _selectedIncomeCategory : _selectedIncomeCategory,
        //   showTip: false,
        // ),
        const ErrorField(
          message: 'Required',
          visible: true,
        ),
        const SizedBox(height: 24),
        // _buildGoalContributionSection(),
        const SizedBox(height: 24),
        TransactionDateTextField(controller: widget.dateController),
        const SizedBox(height: 24),
        TransactionNoteTextField(controller: widget.noteController),
      ],
    );
  }

  // -------------------- Add Income --------------------

  late List<TextEditingController> _goalControllers = [];
  // late List<SmartGoalData> _selectedSmartGoals = [];

  // Widget _buildGoalContributionSection() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Text(
  //             'Goal Contribution (Optional)',
  //             style: TextStyleHelper.getw500size(
  //               18,
  //               color: ColorConstant.black,
  //             ),
  //           ),
  //           GestureDetector(
  //             onTap: () => Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                 builder: (_) => SelectSmartGoalWidget(
  //                   onItemSelected: (smartGoalData) {
  //                     setState(() {
  //                       if (_selectedSmartGoals.every(
  //                           (element) => element.id != smartGoalData.id)) {
  //                         _selectedSmartGoals.add(smartGoalData);
  //                         _goalControllers.add(TextEditingController());
  //                       }
  //                     });
  //                   },
  //                 ),
  //               ),
  //             ),
  //             child: IconHelper.getSVG(SVGName.addSquare,
  //                 color: ColorConstant.income),
  //           ),
  //         ],
  //       ),
  //       const SizedBox(height: 2),
  //       Text(
  //         'Allocate your income to your goals',
  //         style: TextStyleHelper.getw500size(
  //           14,
  //           color: ColorConstant.thin,
  //         ).copyWith(letterSpacing: 0.75),
  //       ),
  //       const SizedBox(height: 8),
  //       Visibility(
  //         visible: _selectedSmartGoals.isNotEmpty,
  //         child: Container(
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.circular(16),
  //           ),
  //           padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
  //           child: ListView.separated(
  //             shrinkWrap: true,
  //             physics: const NeverScrollableScrollPhysics(),
  //             itemCount: _selectedSmartGoals.length,
  //             itemBuilder: (_, index) {
  //               return _buildGoalContributionItem(
  //                 index,
  //                 title: _selectedSmartGoals[index].name,
  //                 smartGoalData: _selectedSmartGoals[index],
  //               );
  //             },
  //             separatorBuilder: (_, index) => const SizedBox(height: 12),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildGoalContributionItem(
  //   int index, {
  //   String title = '',
  //   required SmartGoalData smartGoalData,
  // }) {
  //   return Row(
  //     children: [
  //       SizedBox(
  //         width: 120,
  //         child: Text(
  //           title,
  //           style:
  //               TextStyleHelper.getw500size(16, color: ColorConstant.mainText),
  //         ),
  //       ),
  //       Expanded(
  //         child: TextFormField(
  //           controller: _goalControllers[index],
  //           onChanged: (value) => setState(() {}),
  //           decoration: InputDecoration(
  //             isDense: true,
  //             enabledBorder: OutlineInputBorder(
  //               borderSide: const BorderSide(color: ColorConstant.divider),
  //               borderRadius: BorderRadius.circular(12),
  //             ),
  //             focusedBorder: OutlineInputBorder(
  //               borderSide: const BorderSide(color: ColorConstant.secondary),
  //               borderRadius: BorderRadius.circular(12),
  //             ),
  //             prefixIcon: Padding(
  //               padding: const EdgeInsets.only(left: 16, right: 8),
  //               child: IconHelper.getSVG(
  //                 SVGName.dollarSquare,
  //                 color: _goalControllers[index].text.isEmpty
  //                     ? ColorConstant.color292D32
  //                     : const Color.fromRGBO(16, 172, 132, 1),
  //               ),
  //             ),
  //             prefixIconConstraints: const BoxConstraints(maxHeight: 24),
  //             hintText: 'Total Amount',
  //             hintStyle:
  //                 TextStyleHelper.getw500size(12, color: ColorConstant.thin),
  //             contentPadding: const EdgeInsets.symmetric(vertical: 14),
  //           ),
  //           style: TextStyleHelper.getw500size(12, color: ColorConstant.income),
  //         ),
  //       ),
  //       const SizedBox(width: 12),
  //       CustomIconButton(
  //         onPressed: () {
  //           setState(() {
  //             _selectedSmartGoals.remove(smartGoalData);
  //           });
  //         },
  //         icon: IconHelper.getSVG(SVGName.close, color: ColorConstant.expense),
  //       ),
  //     ],
  //   );
  // }
}
