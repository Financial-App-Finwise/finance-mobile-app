import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/helpers/text_style_helper.dart';
import 'package:finwise/core/helpers/ui_helper.dart';
import 'package:finwise/core/widgets/date_text_field_widget.dart';
import 'package:finwise/core/widgets/filter_bars/headers/models/filter_bar_header_item_model.dart';
import 'package:finwise/core/widgets/filter_bars/headers/widgets/general_filter_bar_header/general_filter_bar_header.dart';
import 'package:finwise/core/widgets/buttons/general_bottom_button.dart';
import 'package:finwise/core/widgets/general_filter_bar/rect_filter_bar.dart';
import 'package:finwise/modules/categories/models/categories_model.dart';
import 'package:finwise/modules/categories/widgets/category_button.dart';
import 'package:finwise/modules/finance/stores/finance_store.dart';
import 'package:finwise/modules/transaction/layouts/transaction_form_layout.dart';
import 'package:finwise/modules/transaction/models/transaction_model.dart';
import 'package:finwise/modules/transaction/stores/transaction_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionEditScreen extends StatefulWidget {
  const TransactionEditScreen({super.key});

  @override
  State<TransactionEditScreen> createState() => _TransactionEditScreenState();
}

class _TransactionEditScreenState extends State<TransactionEditScreen> {
  late final args =
      ModalRoute.of(context)!.settings.arguments as TransactionData;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TransactionFormLayout(
      title: 'Edit Transaction',
      isIncome: args.isIncome,
      expenseType: args.expenseType,
      defaultBillId: args.upcomingbillID ?? 0,
      defaultBillName: '${args.upcomingbillID ?? 0}',
      amount: args.amount,
      buttonLabel: 'Edit Transaction',
    );
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: ColorConstant.backgroundColor,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: Container(
        alignment: Alignment.topLeft,
        color: ColorConstant.backgroundColor,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTopCloseIcon(),
            const SizedBox(height: 10),
            _buildTitle(),
            const SizedBox(height: 32),
            Expanded(child: _buildMainContent()),
            const SizedBox(height: 16),
            _buildButton(),
          ],
        ),
      ),
    );
  }

  // -------------------- Close Icon --------------------
  Widget _buildTopCloseIcon() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Row(
            children: [
              SizedBox.fromSize(
                size: const Size(24, 24),
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: IconHelper.getSVG(SVGName.close),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // -------------------- Title --------------------
  Widget _buildTitle() {
    return const Text(
      'Edit Transaction',
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 32,
        letterSpacing: 1,
        color: ColorConstant.black,
      ),
    );
  }

  // -------------------- Form --------------------
  late bool _isIncome = args.isIncome;

  Widget _buildMainContent() {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(children: [
        GeneralFilterBarHeader(
          items: [
            FilterBarHeaderItem(title: 'Income', value: true),
            FilterBarHeaderItem(title: 'Expense', value: false),
          ],
          onTap: (value) => setState(() => _isIncome = value),
          currentValue: _isIncome,
        ),
        const SizedBox(height: 20),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                _isIncome ? _buildIncomeForm() : _buildExpenseForm(),
              ],
            ),
          ),
        )
      ]),
    );
  }

  // -------------------- Add Income --------------------
  late final _amountIncomeController =
      TextEditingController(text: args.amount.toString());

  Widget _buildIncomeForm() {
    return Column(children: [
      _buildTotalTextField(controller: _amountExpenseController),
      const SizedBox(height: 24),
      _buildCategorySection(),
      const SizedBox(height: 24),
      _buildGoalContributionSection(),
      const SizedBox(height: 24),
      _buildDateField(),
      const SizedBox(height: 24),
      _buildNoteField(),
    ]);
  }

  List<TextEditingController> _goalControllers = [];

  Widget _buildGoalContributionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Goal Contribution (Optional)',
          style: TextStyleHelper.getw500size(
            18,
            color: ColorConstant.black,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          'Allocate your income to your goals',
          style: TextStyleHelper.getw500size(
            14,
            color: ColorConstant.thin,
          ).copyWith(letterSpacing: 0.75),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 2,
            itemBuilder: (_, index) {
              _goalControllers.add(TextEditingController());
              return _buildGoalContributionItem(index, title: 'Vacation');
            },
            separatorBuilder: (_, index) => const SizedBox(height: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildGoalContributionItem(
    int index, {
    String title = '',
  }) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style:
                TextStyleHelper.getw500size(16, color: ColorConstant.mainText),
          ),
        ),
        Expanded(
          child: TextFormField(
            controller: _goalControllers[index],
            onChanged: (value) => setState(() {}),
            decoration: InputDecoration(
              isDense: true,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: ColorConstant.divider),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: ColorConstant.secondary),
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 16, right: 8),
                child: IconHelper.getSVG(
                  SVGName.dollarSquare,
                  color: _goalControllers[index].text.isEmpty
                      ? ColorConstant.color292D32
                      : const Color.fromRGBO(16, 172, 132, 1),
                ),
              ),
              prefixIconConstraints: const BoxConstraints(maxHeight: 24),
              hintText: 'Total Amount',
              hintStyle:
                  TextStyleHelper.getw500size(12, color: ColorConstant.thin),
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
            ),
            style: TextStyleHelper.getw500size(12, color: ColorConstant.income),
          ),
        ),
      ],
    );
  }

  // -------------------- Add Expense --------------------
  Widget _buildExpenseForm() {
    return RectFilterBar(
      physics:
          const BouncingScrollPhysics(parent: NeverScrollableScrollPhysics()),
      fontSize: 13,
      filterTitles: ['General', 'Budget Plan', 'Upcoming Bill'],
      children: [
        _buildExpenseGeneral(),
        _buildExpenseGeneral(),
        _buildExpenseGeneral(),
      ],
    );
  }

  late final _amountExpenseController =
      TextEditingController(text: args.amount.toString());

  Widget _buildExpenseGeneral() {
    return Column(
      children: [
        _buildTotalTextField(
          color: ColorConstant.expense,
          controller: _amountExpenseController,
        ),
        const SizedBox(height: 24),
        _buildCategorySection(
            color: ColorConstant.expense, svgName: SVGName.expense),
        const SizedBox(height: 24),
        _buildDateField(),
        const SizedBox(height: 24),
        _buildNoteField(),
      ],
    );
  }

  // -------------------- Total Amount Text Field --------------------
  Widget _buildTotalTextField({
    Color color = ColorConstant.income,
    TextEditingController? controller,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        isDense: true,
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: IconHelper.getSVG(
            SVGName.dollarSquare,
            color: color,
          ),
        ),
        prefixIconConstraints: const BoxConstraints(maxHeight: 20),
        hintText: 'Total Amount',
        hintStyle: const TextStyle(
          color: ColorConstant.colorA4A7C6,
          fontSize: 20,
          fontWeight: FontWeight.w500,
          letterSpacing: 1,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 20),
      ),
      textAlignVertical: TextAlignVertical.top,
      textAlign: TextAlign.start,
      style: TextStyleHelper.getw500size(20, color: color),
    );
  }

  // -------------------- Category Field --------------------
  late CategoryData _selectedCategory = CategoryData();

  Widget _buildCategorySection({
    Color color = ColorConstant.income,
    String svgName = SVGName.earn,
  }) {
    return CategoryButton(
      setCategory: (categoryData) {
        setState(() {
          _selectedCategory = categoryData;
        });
      },
      category: _selectedCategory,
      showTip: false,
    );
  }

  // -------------------- Date Field --------------------
  DateTime currentDate = DateTime.now();

  Widget _buildDateField() {
    // return DateTextFieldWidget(
    //   onDaySelected: ((selectedDay, focusedDay) => null),
    // );
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: DateTextFieldWidget(
        hintText:
            UIHelper.getDateFormat(DateTime.now().toString(), 'dd MMMM, yyyy'),
        hintStyle:
            TextStyleHelper.getw500size(14).copyWith(letterSpacing: 0.75),
        onDaySelected: ((selectedDay, focusedDay) => null),
      ),
      // child: Row(
      //   children: [
      //     IconHelper.getSVG(SVGName.calendar, color: ColorConstant.mainText),
      //     const SizedBox(width: 8),
      //     Text(
      //       UIHelper.getFormattedDate(currentDate.toString()),
      //       style:
      //           TextStyleHelper.getw500size(14).copyWith(letterSpacing: 0.75),
      //     ),
      //   ],
      // ),
    );
  }

  // -------------------- Note Text Field --------------------
  late final _noteController = TextEditingController(text: args.note);
  Widget _buildNoteField() {
    return TextFormField(
      controller: _noteController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        labelText: 'Note (Optional)',
        floatingLabelStyle:
            TextStyleHelper.getw400size(14, color: ColorConstant.thin),
        labelStyle: TextStyleHelper.getw400size(14, color: ColorConstant.thin),
        alignLabelWithHint: true,
      ),
      maxLines: 3,
    );
  }

  Widget _buildButton() {
    return GeneralBottomButton(
      onButtonTap: () async {
        bool success = await context.read<TransactionStore>().update(
              TransactionData(
                id: args.id,
                categoryID: _selectedCategory.id,
                isIncome: _isIncome,
                amount: double.parse(
                  _isIncome
                      ? _amountIncomeController.text
                      : _amountExpenseController.text,
                ),
                // "hasContributed": 1,
                // upcomingbillID: null,
                // budgetplanID: null,
                expenseType: "General",
                //Upcoming Bill', 'Budget Plan'
                date: DateTime.now().toString(),
                note: _noteController.text,
              ),
            );
        if (success) {
          await context.read<FinanceStore>().read();
          if (mounted) {
            Navigator.pop(context);
          }
        }
      },
      buttonLabel: 'Edit transaction',
    );
  }
}
