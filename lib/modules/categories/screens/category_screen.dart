import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:finwise/core/constants/loading_status_constant.dart';
import 'package:finwise/core/widgets/custom_icon_button.dart';
import 'package:finwise/modules/categories/models/categories_model.dart';
import 'package:finwise/modules/categories/models/final_category_model.dart';
import 'package:finwise/modules/categories/stores/category_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  // List<FinalCategoryData> categories = [];

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 0), () async {
      if (mounted) {
        await context.read<CategoryStore>().read();
      }
    });
  }

  late CategoryModel categoryModel =
      context.watch<CategoryStore>().categoryModel;

  // late LoadingStatus status = context.watch<CategoryStore>().status;

  @override
  Widget build(BuildContext context) {
    // Adding subcategory to every index and store in new list
    // for (int index = 0;
    //     index < categoryModel.categoryDataList.length;
    //     index++) {
    //   CategoryData category = categoryModel.categoryDataList[index];
    //   FinalCategoryData finalCategory;
    //   if (category.level == 2) {
    //     finalCategory = FinalCategoryData(
    //       id: category.id,
    //       userID: category.userID,
    //       name: category.name,
    //       isIncome: category.isIncome,
    //       parentID: category.parentID,
    //       level: category.level,
    //       isOnboarding: category.isOnboarding,
    //       createdAt: category.createdAt,
    //       updatedAt: category.updatedAt,
    //       subcategory: [],
    //     );

    //     categories.add(finalCategory);
    //   }
    // }

    // // Adding the category level 1 to parent subcategory
    // for (int i = 0; i < categories.length; i++) {
    //   FinalCategoryData parentCategory = categories[i];

    //   for (int j = 0; j < categoryModel.categoryDataList.length; j++) {
    //     CategoryData subcategory = categoryModel.categoryDataList[j];

    //     if (subcategory.parentID == parentCategory.id) {
    //       debugPrint('Statse ll ${parentCategory.id}');
    //       // Add subcategory to the subcategory list of the parent category
    //       parentCategory.subcategory.add(subcategory);
    //     }
    //   }
    // }

    // debugPrint('Statse ${categories[9].subcategory[0].name}');

    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              categoryHeader(),
              const SizedBox(
                height: 16,
              ),
              Observer(
                builder: (context) {
                  LoadingStatus status = context.watch<CategoryStore>().status;
                  debugPrint('Statoose: $status');

                  switch (status) {
                    case LoadingStatus.loading:
                      return const Expanded(
                        child: Center(
                          child: Text('Loading'),
                        ),
                      );
                    case LoadingStatus.done:
                      return Expanded(child: mainContent());
                    default:
                      return const Expanded(
                        child: Center(
                          child: Text('Loading'),
                        ),
                      );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget categoryHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomIconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: IconConstant.close,
        ),
        Text(
          'Select Category',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            letterSpacing: 1,
            color: ColorConstant.black,
          ),
        ),
        CustomIconButton(
          onPressed: () {},
          icon: IconConstant.addSquare,
        )
      ],
    );
  }

  Widget mainContent() {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 12,
        ),
        decoration: BoxDecoration(
          color: ColorConstant.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Text('Search'),
              const SizedBox(
                height: 16,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: categoryModel.categoryDataList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      if (categoryModel.categoryDataList[index].level == 2)
                        mainCategoryTile(
                            categoryModel.categoryDataList[index].name),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: categoryModel
                              .categoryDataList[index].subcategory?.length,
                          itemBuilder: (context, innerIndex) {
                            if (categoryModel
                                    .categoryDataList[index].subcategory !=
                                null) {
                              return Container(
                                padding: const EdgeInsets.only(left: 32),
                                child: mainCategoryTile(categoryModel
                                    .categoryDataList[index]
                                    .subcategory![innerIndex]
                                    .name),
                              );
                            }
                          })
                    ],
                  );
                },
              )
            ],
          ),
        ));
  }

  Widget mainCategoryTile(String name) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CustomIconButton(
            onPressed: () {},
            icon: IconConstant.close,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              letterSpacing: 0.75,
              color: ColorConstant.black,
            ),
          ),
        ],
      ),
    );
  }
}
