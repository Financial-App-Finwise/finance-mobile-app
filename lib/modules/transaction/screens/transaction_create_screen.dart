import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/helpers/text_style_helper.dart';
import 'package:finwise/core/helpers/ui_helper.dart';
import 'package:finwise/core/widgets/general_bottom_button.dart';
import 'package:finwise/core/widgets/general_filter_bar/general_filter_bar.dart';
import 'package:finwise/core/widgets/general_filter_bar/rect_filter_bar.dart';
import 'package:finwise/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  @override
  void initState() {
    super.initState();
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

  // ---------- Close Icon ----------
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

  // ---------- Title ----------
  Widget _buildTitle() {
    return const Text(
      'Add Transaction',
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 32,
        letterSpacing: 1,
        color: ColorConstant.black,
      ),
    );
  }

  // ---------- Form ----------
  Widget _buildMainContent() {
    return Container(
      alignment: Alignment.topLeft,
      child: GeneralFilterBar(
        physics: BouncingScrollPhysics(),
        filterTitles: ['Income', 'Expense'],
        topSpace: 20,
        children: [
          _buildIncomeForm(),
          _buildExpenseForm(),
        ],
      ),
    );
  }

  // ---------- Add Income ----------
  Widget _buildIncomeForm() {
    return Column(children: [
      _buildTotalTextField(),
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

  // ---------- Add Expense ----------
  Widget _buildExpenseForm() {
    return Container(
      child: RectFilterBar(
        physics: BouncingScrollPhysics(parent: NeverScrollableScrollPhysics()),
        fontSize: 13,
        filterTitles: ['General', 'Budget Plan', 'Upcoming Bill'],
        children: [
          _buildExpenseGeneral(),
          _buildExpenseGeneral(),
          _buildExpenseGeneral(),
        ],
      ),
    );
  }

  Widget _buildExpenseGeneral() {
    return Column(
      children: [
        _buildTotalTextField(color: ColorConstant.expense),
        const SizedBox(height: 24),
        _buildCategorySection(color: ColorConstant.expense, svgName: SVGName.expense),
        const SizedBox(height: 24),
        _buildDateField(),
        const SizedBox(height: 24),
        _buildNoteField(),
      ],
    );
  }

  // ---------- Total Amount Text Field ----------
  Widget _buildTotalTextField({Color color = ColorConstant.income}) {
    return TextFormField(
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

  // ---------- Category Field ----------
  Widget _buildCategorySection({
    Color color = ColorConstant.income,
    String svgName = SVGName.earn,
  }) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, RouteName.category),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildCategoryFieldIcon(color: color, svgName: svgName),
                const SizedBox(width: 8),
                _buildCategoryFieldTitle(),
              ],
            ),
          ),
          _buildCategoryFieldSuffix(),
        ]),
      ),
    );
  }

  Widget _buildCategoryFieldIcon({
    String svgName = SVGName.earn,
    Color color = ColorConstant.income,
  }) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: IconHelper.getSVG(svgName, color: Colors.white),
    );
  }

  Widget _buildCategoryFieldTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category',
          style: TextStyleHelper.getw400size(12).copyWith(letterSpacing: 0.75),
        ),
        Text(
          'Salary',
          style: TextStyleHelper.getw500size(14).copyWith(letterSpacing: 0.75),
        ),
      ],
    );
  }

  Widget _buildCategoryFieldSuffix() {
    return IconHelper.getSVG(SVGName.angleRight, color: ColorConstant.thin);
  }

  // ---------- Date Field ----------
  DateTime currentDate = DateTime.now();

  Widget _buildDateField() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          IconHelper.getSVG(SVGName.calendar, color: ColorConstant.mainText),
          const SizedBox(width: 8),
          Text(
            UIHelper.getFormattedDate(currentDate.toString()),
            style:
                TextStyleHelper.getw500size(14).copyWith(letterSpacing: 0.75),
          ),
        ],
      ),
    );
  }

  // ---------- Note Text Field ----------
  Widget _buildNoteField() {
    return TextFormField(
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
      onButtonTap: () {},
      buttonLabel: 'Add transaction',
    );
  }
}
