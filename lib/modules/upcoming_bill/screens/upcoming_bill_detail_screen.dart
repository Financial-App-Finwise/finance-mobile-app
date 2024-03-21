import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/helpers/ui_helper.dart';
import 'package:finwise/core/layouts/detail_header_layout.dart';
import 'package:finwise/core/widgets/custom_icon_button.dart';
import 'package:finwise/core/widgets/switch_input.dart';
import 'package:finwise/modules/categories/models/categories_model.dart';
import 'package:finwise/modules/categories/stores/category_store.dart';
import 'package:finwise/modules/upcoming_bill/models/upcoming_bill_model.dart';
import 'package:finwise/modules/upcoming_bill/screens/edit_upcoming_bill_screen.dart';
import 'package:finwise/modules/upcoming_bill/stores/upcoming_bill_store.dart';
import 'package:finwise/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class UpcomingBillDetailScreen extends StatefulWidget {
  UpcomingBillDetailScreen({super.key});

  @override
  State<UpcomingBillDetailScreen> createState() =>
      _UpcomingBillDetailScreenState();
}

class _UpcomingBillDetailScreenState extends State<UpcomingBillDetailScreen> {
  late final UpcomingBillData args =
      ModalRoute.of(context)!.settings.arguments as UpcomingBillData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xFFFBA6A6), Color(0xFFEE5353)],
              stops: [0.2, 0.8]),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _topBarContent(),
              Expanded(
                child: Container(
                  color: ColorConstant.backgroundColor,
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Overview',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  letterSpacing: 1,
                                  color: ColorConstant.black,
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              overviewContent(),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topBarContent() {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xFFFBA6A6), Color(0xFFEE5353)], stops: [0.2, 0.8]),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          CustomIconButton(
            onPressed: () => Navigator.pop(context),
            icon: IconHelper.getSVG(
              SVGName.arrowBack,
              color: ColorConstant.white,
            ),
          ),

          const SizedBox(
            height: 12,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Title
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(4)),
                    child: const Icon(
                      Icons.car_rental_outlined,
                      color: Color(0xFFEE5353),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        args.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            color: Color(0xFFFFFFFF)),
                      ),
                      const Text(
                        'Budget Category',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Color(0xFFFFFFFF)),
                      ),
                    ],
                  ),
                ],
              ),

              // Action Icon Buttons
              Row(
                children: [
                  // Edit Icon Button
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: IconButton(
                      onPressed: () async {
                        var result = await Navigator.pushNamed(
                          context,
                          RouteName.editUpcomingBill,
                          arguments: args,
                        );

                        if (result.toString().toLowerCase() == "true") {
                          Navigator.pop(context);
                          await context
                              .read<UpcomingBillStore>()
                              .read(refreshed: true);
                        }
                      },
                      icon: IconHelper.getSVG(
                        SVGName.edit,
                        color: ColorConstant.white,
                      ),
                      style: ButtonStyle(
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(0)),
                      ),
                    ),
                  ),

                  const SizedBox(
                    width: 6,
                  ),

                  // Delete Icon Button
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: IconButton(
                      onPressed: () {
                        _showModal(context);
                      },
                      icon: IconHelper.getSVG(
                        SVGName.delete,
                        color: ColorConstant.white,
                      ),
                      style: ButtonStyle(
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(0)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  late List<CategoryData> categoryList =
      context.read<CategoryStore>().categoryModel.categoryDataList;
  late final CategoryData _selectedCategory =
      categoryList.firstWhere((category) => category.id == args.categoryID);

  Widget overviewContent() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorConstant.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          overviewCard(
            IconHelper.getSVG(
              SVGName.expense,
              color: ColorConstant.overbudgetIcon,
            ),
            'Spent',
            '\$${args.amount}',
            defaultStyle,
          ),
          dividerGap(),
          overviewCard(
            IconHelper.getSVG(
              SVGName.internet,
              color: ColorConstant.overbudgetIcon,
            ),
            'Category',
            '${_selectedCategory.name}',
            defaultStyle,
          ),
          dividerGap(),
          overviewCard(
            IconHelper.getSVG(
              SVGName.calendarTick,
              color: ColorConstant.overbudgetIcon,
            ),
            'Transaction date',
            '${UIHelper.getDateFormat(args.date, "dd MMM, yyyy")}',
            defaultStyle,
          ),
          dividerGap(),
          overviewCard(
            IconHelper.getSVG(
              SVGName.budgetPlan,
              color: ColorConstant.overbudgetIcon,
            ),
            'Note',
            args.note == 'no note' ? 'You don\'t have any note.' : args.note,
            noteStyle,
          ),
        ],
      ),
    );
  }

  Widget overviewCard(
      SvgPicture icon, String title, String description, TextStyle textStyle) {
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: icon,
        ),
        const SizedBox(
          width: 12,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                letterSpacing: 0.75,
                color: ColorConstant.mainText,
              ),
            ),
            const SizedBox(
              height: 1,
            ),
            Text(
              description,
              style: textStyle,
            ),
          ],
        )
      ],
    );
  }

  TextStyle defaultStyle = const TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 24,
    letterSpacing: 1,
    color: ColorConstant.black,
  );

  TextStyle noteStyle = const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: 0.5,
    color: ColorConstant.black,
  );

  Widget dividerGap() {
    return const Column(
      children: [
        SizedBox(
          height: 17,
        ),
        Divider(
          color: Color(0xFFF2F2F2),
          thickness: 1,
        ),
        SizedBox(
          height: 17,
        ),
      ],
    );
  }

  Widget recurrringMonth() {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: ColorConstant.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recurring every month',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    letterSpacing: 1,
                    color: ColorConstant.mainText,
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  'This upcoming bill will carry forward to future months as well.',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    height: 2,
                    letterSpacing: 0.75,
                    color: ColorConstant.thin,
                  ),
                ),
              ],
            ),
          ),
          SwitchInput(),
        ],
      ),
    );
  }

  // Popup delete warning
  void _showModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorConstant.white,
          elevation: 0,
          contentPadding: const EdgeInsets.all(16),
          content: IntrinsicHeight(
            child: SizedBox(
              child: Column(children: [
                SizedBox(
                  width: 125,
                  height: 125,
                  child: IconConstant.myBudget(
                    color: ColorConstant.expense,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'Are you sure you want to delete this SMART gaol?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    height: 1.5,
                    letterSpacing: 1,
                    color: ColorConstant.black,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'You will delete every transaction added to this goal.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    height: 1.5,
                    letterSpacing: 0.5,
                    color: ColorConstant.mainText,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 24,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xFFE9EAF1),
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 1,
                              color: ColorConstant.thin,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          bool success = await context
                              .read<UpcomingBillStore>()
                              .delete(args);

                          if (success) {
                            Navigator.of(context).pop();
                            Navigator.pop(context);
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 24,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: ColorConstant.expense,
                          ),
                          child: const Text(
                            'Delete',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 1,
                              color: ColorConstant.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ]),
            ),
          ),
        );
      },
    );
  }
}
