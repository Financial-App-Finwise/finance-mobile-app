import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/widgets/custom_progess_bar.dart';
import 'package:finwise/modules/categories/models/categories_model.dart';
import 'package:finwise/modules/categories/stores/category_store.dart';
import 'package:finwise/modules/onboarding_question/stores/onboarding_question_store.dart';
import 'package:finwise/modules/onboarding_question/widgets/continue_button.dart';
import 'package:finwise/modules/onboarding_question/widgets/custom_question_text.dart';
import 'package:finwise/modules/onboarding_question/widgets/custom_number_input.dart';
import 'package:finwise/modules/onboarding_question/widgets/time_peroid_input.dart';
import 'package:finwise/modules/onboarding_question/widgets/tip_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class MainFinanceSnapshot extends StatefulWidget {
  const MainFinanceSnapshot({super.key});

  @override
  State<MainFinanceSnapshot> createState() => _MainFinanceSnapshotState();
}

class _MainFinanceSnapshotState extends State<MainFinanceSnapshot> {
  late OnboardingQuestionStore store = context.read<OnboardingQuestionStore>();

  List<bool> get isFormFilled => [
        store.networth.text.isNotEmpty,
        store.expense.controller.text.isNotEmpty,
        store.income.controller.text.isNotEmpty,
        store.categories.isNotEmpty
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                      width: double.infinity,
                      child: Observer(builder: (context) {
                        return CustomProgressBar(
                          value: store.financialSnapshotIndex /
                              store.financialSnapshotMaxPage,
                          gradient1: ColorConstant.secondary,
                          gradient2: ColorConstant.primary,
                        );
                      })),
                  const SizedBox(
                    height: 24,
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: AnimatedSwitcher(
                        duration: const Duration(microseconds: 500),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          return ScaleTransition(
                            scale: animation,
                            child: child,
                          );
                        },
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: _getCurrentWidget(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Observer(builder: (context) {
              return ContinueButton(
                nextPage: store.nextPage,
                isFormFilled: isFormFilled[store.financialSnapshotIndex - 1],
              );
            })
          ],
        ),
      ),
    );
  }

  Widget _getCurrentWidget() {
    return Observer(builder: (context) {
      int financialSnapshotIndex = store.financialSnapshotIndex;

      switch (financialSnapshotIndex) {
        case 1:
          return _netWorth();
        case 2:
          return _expense();
        case 3:
          return _income();
        case 4:
          return _categories();
        default:
          return Container();
      }
    });
  }

  Widget _netWorth() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomQuestionText(text: 'What is your current net worth?'),
        const SizedBox(
          height: 32,
        ),
        CustomNumberInput(
            label: 'Net worth',
            hintText: '\$ 2000',
            controller: store.networth,
            isMoney: true,
            onChange: (value) => setState(() {
                  isFormFilled;
                })),
        const SizedBox(
          height: 24,
        ),
        const TipText(
          title: 'We ask your net worth to create your personal plan',
          description:
              'Entering this number launches us into a cosmic exploration, shaping a personalized financial adventure just for you.',
        )
      ],
    );
  }

  Widget _expense() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomQuestionText(
            text: 'How much do you find yourself spending money?'),
        const SizedBox(
          height: 32,
        ),
        TimePeroidInput(
          changeType: (type) {
            store.expense = type;
          },
          selectedType: store.expense,
        ),
        const SizedBox(
          height: 24,
        ),
        CustomNumberInput(
          label: store.expense.type == 'Daily'
              ? 'Daily expense'
              : store.expense.type == 'Weekly'
                  ? 'Weekly expense'
                  : 'Monthly expense',
          hintText: '\$ 2000',
          controller: store.expense.controller,
          isMoney: true,
          onChange: (value) => setState(() {
            isFormFilled;
          }),
        ),
        const SizedBox(
          height: 24,
        ),
        const TipText(
          title:
              'Understanding your expenses helps us craft personalized insights',
          description:
              'Your input fuels a customized journey to financial success.',
        )
      ],
    );
  }

  Widget _income() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomQuestionText(text: 'How much is your income?'),
        const SizedBox(
          height: 32,
        ),
        TimePeroidInput(
          changeType: (type) {
            store.income = type;
          },
          selectedType: store.income,
        ),
        const SizedBox(
          height: 24,
        ),
        CustomNumberInput(
          label: store.income.type == 'Daily'
              ? 'Daily income'
              : store.income.type == 'Weekly'
                  ? 'Weekly income'
                  : 'Monthly income',
          hintText: '\$ 2000',
          controller: store.income.controller,
          isMoney: true,
          onChange: (value) => setState(() {
            isFormFilled;
          }),
        ),
        const SizedBox(
          height: 24,
        ),
        const TipText(
          title: 'Reveal your income to ignite a tailored financial roadmap! ',
          description:
              'Knowing your earnings allows us to craft personalized strategies, maximizing your financial potential.',
        )
      ],
    );
  }

  Widget _categories() {
    return Column(
      children: [
        CustomQuestionText(
            text: 'Identify the category where you tend to spend the most'),
        const SizedBox(
          height: 32,
        ),
        Observer(builder: (context) {
          ObservableList<CategoryData> categories =
              context.watch<CategoryStore>().onboardingCategory;

          // return Column(
          //   children: [
          //     for (var category in categories)
          //       if (category.level == 2)
          //         Row(
          //           children: [
          //             SizedBox(
          //               height: 28,
          //               width: 28,
          //               child: IconHelper.getSVGDefault(
          //                   SVGName.pandaFinancialSnapshot),
          //             ),
          //             const SizedBox(
          //               width: 12,
          //             ),
          //             Text(
          //               category.name,
          //               style: const TextStyle(
          //                 fontWeight: FontWeight.w600,
          //                 fontSize: 18,
          //                 letterSpacing: 1,
          //                 color: ColorConstant.black,
          //               ),
          //             )
          //           ],
          //         ),
          //     const SizedBox(
          //       height: 20,
          //     ),
          //     SizedBox(
          //       width: double.infinity,
          //       child: _buildSubcategory(category.subcategory ?? []),
          //     ),
          //     if (index < categories.length - 1)
          //       const SizedBox(
          //         height: 20,
          //       ),
          //   ],
          // );

          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  if (categories[index].level == 2)
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 28,
                              width: 28,
                              child: IconHelper.getSVGDefault(
                                  SVGName.pandaFinancialSnapshot),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(
                              categories[index].name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                letterSpacing: 1,
                                color: ColorConstant.black,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: _buildSubcategory(
                              categories[index].subcategory ?? []),
                        ),
                        if (index < categories.length - 1)
                          const SizedBox(
                            height: 20,
                          ),
                      ],
                    ),
                ],
              );
            },
          );
        }),
      ],
    );
  }

  Widget _buildSubcategory(List<CategoryData> categories) {
    return Observer(builder: (context) {
      ObservableList selectedCategories =
          context.watch<OnboardingQuestionStore>().categories;

      return Wrap(
        alignment: WrapAlignment.start,
        spacing: 12,
        runSpacing: 12,
        children: [
          for (var category in categories)
            _categoryButton(
              category,
              selectedCategories.contains(category),
            )
        ],
      );
    });
  }

  Widget _categoryButton(CategoryData category, bool isSelected) {
    return InkWell(
      onTap: () {
        store.setCategory(category);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 12,
        ),
        decoration: !isSelected
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xFFD3D5E4).withOpacity(0.3))
            : BoxDecoration(
                color: const Color(0xFFECFDFF).withOpacity(0.5),
                border: Border.all(
                  color: ColorConstant.secondary,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
        child: Text(
          category.name,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            letterSpacing: 0.75,
            color: ColorConstant.black,
          ),
        ),
      ),
    );
  }
}
