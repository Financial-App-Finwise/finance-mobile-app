import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/expense_type_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/helpers/text_style_helper.dart';
import 'package:finwise/core/helpers/ui_helper.dart';
import 'package:finwise/core/widgets/buttons/select_item_button.dart';
import 'package:finwise/core/widgets/custom_icon_button.dart';
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
import 'package:finwise/modules/transaction/widgets/form_fields/transaction_amount_text_field.dart';
import 'package:finwise/modules/transaction/widgets/form_fields/transaction_date_text_field.dart';
import 'package:finwise/core/widgets/form_fields/error_field.dart';
import 'package:finwise/modules/transaction/widgets/form_fields/transaction_note_text_field.dart';
import 'package:finwise/modules/transaction/widgets/smart_goal_button/select_smart_goal_widget.dart';
import 'package:finwise/modules/transaction/widgets/upcoming_bill_button/upcoming_bill_button.dart';
import 'package:finwise/modules/upcoming_bill/models/upcoming_bill_model.dart';
import 'package:flutter/material.dart';
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
            Expanded(child: _buildForm()),
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
  void _resetItem() {
    setState(() {
      _selectedBudgetPlan = BudgetPlanData();
      _selectedUpcomingBill = UpcomingBillData();
      _selectedExpenseCategory = CategoryData();
      _selectedIncomeCategory = CategoryData();

      _resetErrorFields();
    });
  }

  void _resetErrorFields() {
    setState(() {
      _amountError = false;
      _itemSelectionError = false;
    });
  }

  late bool _isIncome = widget.isIncome;
  late final _dateController = TextEditingController(
      text: UIHelper.getDateFormat(widget.dateController.text, 'dd MMM, yyyy'));
  late final _noteController = widget.noteController;
  late CategoryData _selectedIncomeCategory = CategoryData();

  Widget _buildForm() {
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
            onTap: (value) => setState(() {
              _resetItem();
              _isIncome = value;
            }),
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
    );
  }

  // -------------------- Add Income --------------------
  late final _amountIncomeController = widget.amountIncomeController;
  late List<TextEditingController> _goalControllers = [];
  late List<SmartGoalData> _selectedSmartGoals = [];

  Widget _buildIncomeForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TransactionAmountTextField(
          controller: _amountIncomeController,
          onChanged: (value) => _validateAmountForm(),
        ),
        ErrorField(
            message: _amountError
                ? 'Required'
                : _amountZeroError
                    ? 'Must be greater than 0'
                    : '',
            visible: _amountError || _amountZeroError),
        const SizedBox(height: 24),
        CategoryButton(
          setCategory: (categoryData) {
            _resetItem();
            setState(() => _selectedIncomeCategory = categoryData);
          },
          category: _selectedIncomeCategory,
          showTip: false,
        ),
        ErrorField(message: 'Required', visible: _itemSelectionError),
        const SizedBox(height: 24),
        _buildGoalContributionSection(),
        const SizedBox(height: 24),
        TransactionDateTextField(controller: _dateController),
        const SizedBox(height: 24),
        TransactionNoteTextField(controller: _noteController),
      ],
    );
  }

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
            onTap: widget.canChangeType
                ? (value) => setState(() {
                      _resetItem();
                      _expenseType = value;
                      _amountExpenseController.clear();
                    })
                : (value) {}),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TransactionAmountTextField(
              onChanged: (value) => _validateAmountForm(),
              color: ColorConstant.expense,
              controller: _amountExpenseController,
              readOnly: _expenseType == 'Upcoming Bill',
            ),
            ErrorField(
                message: _amountError
                    ? 'Required'
                    : _amountZeroError
                        ? 'Must be greater than 0'
                        : '',
                visible: _amountError || _amountZeroError),
            const SizedBox(height: 24),
            _buildItemSelection(),
            ErrorField(message: 'Required', visible: _itemSelectionError),
            const SizedBox(height: 24),
            TransactionDateTextField(controller: _dateController),
            const SizedBox(height: 24),
            TransactionNoteTextField(controller: _noteController),
          ],
        ),
      ],
    );
  }

  // -------------------- Select Item --------------------
  late CategoryData _selectedExpenseCategory =
      widget.transactionData.categoryData ?? CategoryData();
  late BudgetPlanData _selectedBudgetPlan = BudgetPlanData();
  late UpcomingBillData _selectedUpcomingBill =
      widget.transactionData.upcomingBillData ?? UpcomingBillData();

  Widget _buildItemSelection() {
    switch (_expenseType) {
      case ExpenseTypeConstant.budgetPlan:
        return BudgetPlanButton(
          currentItem: SelectItem<BudgetPlanData>(
            title: 'Budget PLan',
            subTitle: _selectedBudgetPlan.id == 0
                ? 'Select a budget plan'
                : _selectedBudgetPlan.name,
            pickedIcon:
                IconHelper.getSVG(SVGName.myBudget, color: Colors.white),
            unpickedIcon:
                IconHelper.getSVG(SVGName.myBudget, color: Colors.white),
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
      case ExpenseTypeConstant.upcomingBill:
        return UpcomingBillButton(
          disable: !widget.canChangeType,
          currentItem: SelectItem<UpcomingBillData>(
            title: 'Upcoming Bill',
            subTitle: _selectedUpcomingBill.id == 0
                ? 'Select an upcoming bill'
                : _selectedUpcomingBill.name,
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
              _amountExpenseController.text =
                  upcomingBillData.amount.toString();
              _selectedUpcomingBill = upcomingBillData;
            });
          },
        );
      default:
        return CategoryButton(
          setCategory: (categoryData) {
            _resetItem();
            setState(() => _selectedExpenseCategory = categoryData);
          },
          category: _selectedExpenseCategory,
          showTip: false,
        );
    }
  }

  // -------------------- Post Data --------------------
  late TransactionPost _transactionPost = TransactionPost();

  void _chooseItem() {
    late final TransactionPost baseTransactionPost = TransactionPost(
      amount: _isIncome
          ? double.parse(_amountIncomeController.text)
          : double.parse(_amountExpenseController.text),
      note: _noteController.text,
      date: widget.dateController.text,
    );

    _transactionPost = TransactionPost();

    setState(() {
      switch (_isIncome) {
        case true:
          _transactionPost = baseTransactionPost.toIncome(TransactionPostIncome(
            categoryID: _selectedIncomeCategory.id,
          ));
        case false:
          switch (_expenseType) {
            case ExpenseTypeConstant.budgetPlan:
              _transactionPost = baseTransactionPost.toExpenseBudgetPlan(
                  TransactionPostExpenseBudgetPlan(
                      budgetplanID: _selectedBudgetPlan.id));

            case ExpenseTypeConstant.upcomingBill:
              _transactionPost = baseTransactionPost.toExpenseUpcomingBill(
                  TransactionPostExpenseUpcomingBill(
                      upcomingbillID: _selectedUpcomingBill.id));

            case ExpenseTypeConstant.general:
              _transactionPost = baseTransactionPost.toExpense(
                  TransactionPostExpense(
                      categoryID: _selectedExpenseCategory.id));
          }
      }
    });
  }

  // -------------------- Form Validation --------------------
  bool _amountError = false;
  bool _amountZeroError = false;
  bool _itemSelectionError = false;

  // ---------- Validate Amount ----------
  void _validateAmountForm() => setState(
        () {
          _amountError = !_amountFilled;
          _amountZeroError = !_amountIsValid;
        },
      );

  bool get _amountFilled => _isIncome
      ? _amountIncomeController.text.isNotEmpty
      : _amountExpenseController.text.isNotEmpty;

  bool get _amountIsValid {
    if (_isIncome && _amountIncomeController.text.isNotEmpty) {
      return double.parse(_amountIncomeController.text) != 0;
    }

    if (_amountExpenseController.text.isNotEmpty) {
      return double.parse(_amountExpenseController.text) != 0;
    }

    return true;
  }

  // ---------- Validate Item Selection ----------
  void _validateItemSelection() => setState(
        () => _itemSelectionError = _isIncome
            ? !_incomeItemSelected
            : _itemSelectionError = !_expenseItemSelected,
      );

  bool get _incomeItemSelected => _selectedIncomeCategory.id > 0;

  bool get _expenseItemSelected =>
      _selectedExpenseCategory.id > 0 ||
      _selectedBudgetPlan.id > 0 ||
      _selectedUpcomingBill.id > 0;

  // validate all
  bool get _isFormValid => _isIncome
      ? _amountFilled && _amountIsValid && _incomeItemSelected
      : _amountFilled && _amountIsValid && _expenseItemSelected;

  void _validateForm() {
    _validateAmountForm();
    _validateItemSelection();
  }

  // -------------------- Add Button --------------------
  Widget _buildButton() {
    return GeneralBottomButton(
      backgroundColor: !_isFormValid
          ? ColorConstant.secondary.withOpacity(0.5)
          : ColorConstant.secondary,
      onButtonTap: !_isFormValid
          ? _validateForm
          : () {
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
