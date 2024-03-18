import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/expense_type_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/helpers/text_style_helper.dart';
import 'package:finwise/core/helpers/ui_helper.dart';
import 'package:finwise/core/widgets/buttons/select_item_button.dart';
import 'package:finwise/core/widgets/custom_icon_button.dart';
import 'package:finwise/core/widgets/date_text_field_widget.dart';
import 'package:finwise/core/widgets/filter_bars/headers/models/filter_bar_header_item_model.dart';
import 'package:finwise/core/widgets/filter_bars/headers/widgets/general_filter_bar_header/general_filter_bar_header.dart';
import 'package:finwise/core/widgets/filter_bars/headers/widgets/rect_filter_bar_header/rect_filter_bar_header.dart';
import 'package:finwise/core/widgets/buttons/general_bottom_button.dart';
import 'package:finwise/modules/budget_plan/models/budget_plan_model.dart';
import 'package:finwise/modules/categories/models/categories_model.dart';
import 'package:finwise/modules/categories/widgets/category_button.dart';
import 'package:finwise/modules/smart_goal/models/smart_goal_model.dart';
import 'package:finwise/modules/smart_goal/stores/smart_goal_store.dart';
import 'package:finwise/modules/transaction/models/transaction_model.dart';
import 'package:finwise/modules/transaction/models/transaction_post_model.dart';
import 'package:finwise/modules/transaction/widgets/budget_plan_button/budget_plan_button.dart';
import 'package:finwise/modules/transaction/widgets/smart_goal_button/select_smart_goal_widget.dart';
import 'package:finwise/modules/transaction/widgets/upcoming_bill_button/upcoming_bill_button.dart';
import 'package:finwise/modules/upcoming_bill/models/upcoming_bill_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class TransactionFormLayout extends StatefulWidget {
  final String title;
  final bool isIncome;
  final String expenseType;
  final int selectedUpcomingBillID;
  final String defaultBillName;
  final double amount;
  final TransactionData transactionData;
  final bool canChangeType;

  final String buttonLabel;
  final void Function({
    bool isIncome,
    String expenseType,
    String amount,
    bool hasContributed,
    String note,
    required BudgetPlanData selectedBudgetPlan,
    required UpcomingBillData selectedUpcomingBill,
    required CategoryData selectedCategory,
    required TransactionPost transactionPost,
  }) onTap;

  final TextEditingController amountIncomeController;
  final TextEditingController amountExpenseController;
  final TextEditingController noteController;
  final TextEditingController dateController;

  const TransactionFormLayout({
    super.key,
    required this.transactionData,
    this.title = '',
    this.isIncome = true,
    this.expenseType = 'General',
    this.selectedUpcomingBillID = 0,
    this.defaultBillName = '',
    this.amount = 0.0,
    this.buttonLabel = '',
    required this.onTap,
    this.canChangeType = true,
    required this.amountIncomeController,
    required this.amountExpenseController,
    required this.noteController,
    required this.dateController,
  });

  @override
  State<TransactionFormLayout> createState() => _TransactionFormLayoutState();
}

class _TransactionFormLayoutState extends State<TransactionFormLayout> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      // await _readAll();
    });
  }

  Future _readAll() async {
    await context.read<SmartGoalStore>().readByPage();
  }

  @override
  Widget build(BuildContext context) {
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
    return Text(
      widget.title,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 32,
        letterSpacing: 1,
        color: ColorConstant.black,
      ),
    );
  }

  // -------------------- Form --------------------
  late bool _isIncome = widget.isIncome;

  Widget _buildMainContent() {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          GeneralFilterBarHeader(
            items: [
              FilterBarHeaderItem(title: 'Income', value: true),
              FilterBarHeaderItem(title: 'Expense', value: false),
            ],
            readOnly: !widget.canChangeType,
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
        ],
      ),
      // child: GeneralFilterBar(
      //   physics: BouncingScrollPhysics(),
      //   filterTitles: ['Income', 'Expense'],
      //   topSpace: 20,
      //   children: [
      //     _buildIncomeForm(),
      //     _buildExpenseForm(),
      //   ],
      // ),
    );
  }

  // -------------------- Add Income --------------------
  late final _amountIncomeController = widget.amountIncomeController;

  Widget _buildIncomeForm() {
    return Column(children: [
      _buildTotalTextField(controller: _amountIncomeController),
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

  late List<TextEditingController> _goalControllers = [];
  late List<SmartGoalData> _selectedSmartGoals = [];

  Widget _buildGoalContributionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Goal Contribution (Optional)',
              style: TextStyleHelper.getw500size(
                18,
                color: ColorConstant.black,
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SelectSmartGoalWidget(
                    onItemSelected: (smartGoalData) {
                      setState(() {
                        if (_selectedSmartGoals.every(
                            (element) => element.id != smartGoalData.id)) {
                          _selectedSmartGoals.add(smartGoalData);
                          _goalControllers.add(TextEditingController());
                        }
                      });
                    },
                  ),
                ),
              ),
              child: IconHelper.getSVG(SVGName.addSquare,
                  color: ColorConstant.income),
            ),
          ],
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
        Visibility(
          visible: _selectedSmartGoals.isNotEmpty,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _selectedSmartGoals.length,
              itemBuilder: (_, index) {
                return _buildGoalContributionItem(
                  index,
                  title: _selectedSmartGoals[index].name,
                  smartGoalData: _selectedSmartGoals[index],
                );
              },
              separatorBuilder: (_, index) => const SizedBox(height: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGoalContributionItem(
    int index, {
    String title = '',
    required SmartGoalData smartGoalData,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 120,
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
        const SizedBox(width: 12),
        CustomIconButton(
          onPressed: () {
            setState(() {
              _selectedSmartGoals.remove(smartGoalData);
            });
          },
          icon: IconHelper.getSVG(SVGName.close, color: ColorConstant.expense),
        ),
      ],
    );
  }

  // -------------------- Add Expense --------------------
  late String _expenseType = widget.expenseType;
  late final _amountExpenseController = widget.amountExpenseController;

  Widget _buildExpenseForm() {
    return Column(
      children: [
        RectFilterBarHeader(
            physics: const BouncingScrollPhysics(),
            items: [
              FilterBarHeaderItem(title: 'General', value: 'General'),
              FilterBarHeaderItem(title: 'Budget Plan', value: 'Budget Plan'),
              FilterBarHeaderItem(
                  title: 'Upcoming Bill', value: 'Upcoming Bill'),
            ],
            currentValue: _expenseType,
            readOnly: !widget.canChangeType,
            onTap: (value) => setState(() {
                  _expenseType = value;
                  _amountExpenseController.clear();
                })),
        _buildExpenseGeneral(),
      ],
    );
  }

  Widget _buildExpenseGeneral() {
    return Column(
      children: [
        _buildTotalTextField(
          color: ColorConstant.expense,
          controller: _amountExpenseController,
          readOnly: _expenseType == 'Upcoming Bill',
        ),
        const SizedBox(height: 24),
        _buildItemSelection(),
        const SizedBox(height: 24),
        _buildDateField(),
        const SizedBox(height: 24),
        _buildNoteField(),
      ],
    );
  }

  Widget _buildItemSelection() {
    switch (_expenseType) {
      case ExpenseTypeConstant.budgetPlan:
        return _buildBudgetplanSelection();
      case ExpenseTypeConstant.upcomingBill:
        return _buildUpcomingBillSelection();
      default:
        return _buildCategorySection();
    }
  }

  // -------------------- Total Amount Text Field --------------------
  Widget _buildTotalTextField({
    Color color = ColorConstant.income,
    TextEditingController? controller,
    bool readOnly = false,
  }) {
    return TextFormField(
      readOnly: readOnly,
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
      ],
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
  late CategoryData _selectedIncomeCategory = CategoryData();
  late CategoryData _selectedExpenseCategory = CategoryData();

  Widget _buildCategorySection() {
    return CategoryButton(
      setCategory: (categoryData) {
        setState(() {
          _isIncome
              ? _selectedIncomeCategory = categoryData
              : _selectedIncomeCategory = categoryData;
        });
      },
      category: _isIncome ? _selectedIncomeCategory : _selectedIncomeCategory,
      showTip: false,
    );
  }

  // -------------------- Budget Plan Selection --------------------
  late BudgetPlanData _selectedBudgetPlan = BudgetPlanData();

  Widget _buildBudgetplanSelection() {
    return BudgetPlanButton(
      currentItem: SelectItem<BudgetPlanData>(
        title: 'Budget PLan',
        subTitle: _selectedBudgetPlan.id == 0
            ? 'Select a budget plan'
            : _selectedBudgetPlan.name,
        pickedIcon: IconHelper.getSVG(SVGName.myBudget, color: Colors.white),
        unpickedIcon: IconHelper.getSVG(SVGName.myBudget, color: Colors.white),
        backgroundColor: ColorConstant.expense,
        itemPicked: _selectedBudgetPlan.id != 0,
        item: _selectedBudgetPlan,
      ),
      onItemSelected: (budgetPlanData) {
        setState(() {
          _selectedBudgetPlan = budgetPlanData;
        });
      },
    );
  }

  // -------------------- Upcoming Bill Selection --------------------
  late UpcomingBillData _selectedUpcomingBill = UpcomingBillData();

  Widget _buildUpcomingBillSelection() {
    return UpcomingBillButton(
      currentItem: SelectItem<UpcomingBillData>(
        title: 'Upcoming Bill',
        subTitle: 'Select an upcoming bill',
        pickedIcon:
            IconHelper.getSVG(SVGName.upcomingBill, color: Colors.white),
        unpickedIcon:
            IconHelper.getSVG(SVGName.upcomingBill, color: Colors.white),
        backgroundColor: ColorConstant.bill,
        itemPicked: _selectedUpcomingBill.id != 0,
        item: _selectedUpcomingBill,
      ),
      onItemSelected: (upcomingBillData) {
        setState(() {
          _amountExpenseController.text = upcomingBillData.amount.toString();
          _selectedUpcomingBill = upcomingBillData;
        });
      },
    );
  }

  // -------------------- Date Field --------------------
  late final _dateController = widget.dateController;

  Widget _buildDateField() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: DateTextFieldWidget(
        controller: _dateController,
        enable: false,
        hintText: UIHelper.getDateFormat(
            widget.transactionData.date.toString(), 'dd MMMM, yyyy'),
        hintStyle:
            TextStyleHelper.getw500size(14).copyWith(letterSpacing: 0.75),
        onDaySelected: ((selectedDay, focusedDay) {}),
      ),
    );
  }

  // -------------------- Note Text Field --------------------
  late final _noteController = widget.noteController;

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

  // -------------------- Post Data --------------------
  late final TransactionPost _baseTransactionPost = TransactionPost(
    amount: _isIncome
        ? double.parse(_amountIncomeController.text)
        : double.parse(_amountExpenseController.text),
    note: _noteController.text,
    date: widget.dateController.text,
  );

  late TransactionPost _transactionPost = TransactionPost();

  void _chooseItem() {
    setState(() {
      switch (_isIncome) {
        case true:
          _transactionPost =
              _baseTransactionPost.toIncome(TransactionPostIncome(
            categoryID: _selectedIncomeCategory.id,
          ));
        case false:
          switch (_expenseType) {
            case ExpenseTypeConstant.budgetPlan:
              _transactionPost = _baseTransactionPost.toExpenseBudgetPlan(
                  TransactionPostExpenseBudgetPlan(
                      budgetplanID: _selectedBudgetPlan.id));

            case ExpenseTypeConstant.upcomingBill:
              _transactionPost = _baseTransactionPost.toExpenseUpcomingBill(
                  TransactionPostExpenseUpcomingBill(
                      upcomingbillID: _selectedUpcomingBill.id));

            case ExpenseTypeConstant.general:
              _transactionPost = _baseTransactionPost.toExpense(
                  TransactionPostExpense(
                      categoryID: _selectedExpenseCategory.id));
          }
      }
    });
  }

  Widget _buildButton() {
    return GeneralBottomButton(
      onButtonTap: () {
        _chooseItem();
        widget.onTap(
          isIncome: _isIncome,
          expenseType: _expenseType,
          amount: _isIncome
              ? _amountIncomeController.text
              : _amountExpenseController.text,
          hasContributed: _selectedSmartGoals.isNotEmpty,
          note: _noteController.text,
          selectedBudgetPlan: _selectedBudgetPlan,
          selectedUpcomingBill: _selectedUpcomingBill,
          selectedCategory: _selectedIncomeCategory,
          transactionPost: _transactionPost,
        );
      },
      buttonLabel: widget.buttonLabel,
    );
  }
}
