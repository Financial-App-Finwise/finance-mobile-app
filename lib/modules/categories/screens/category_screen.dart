import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:finwise/core/constants/loading_status_constant.dart';
import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/widgets/custom_icon_button.dart';
import 'package:finwise/modules/categories/models/categories_model.dart';
import 'package:finwise/modules/categories/stores/category_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  final void Function(CategoryData) setCategory;
  const CategoryScreen({
    super.key,
    required this.setCategory,
  });

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 0), () async {
      if (mounted) {
        await context.read<CategoryStore>().read();
      }
    });
  }

  late CategoryModel categoryModel =
      context.watch<CategoryStore>().categoryModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              categoryHeader(),
              headerFilter(),
              const SizedBox(
                height: 16,
              ),
              Observer(
                builder: (context) {
                  LoadingStatus status = context.watch<CategoryStore>().status;

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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomIconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: IconHelper.getSVG(
              SVGName.arrowBack,
              color: ColorConstant.black,
            ),
          ),
          const Text(
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
            icon: IconHelper.getSVG(
              SVGName.plus,
              color: ColorConstant.secondary,
            ),
          )
        ],
      ),
    );
  }

  Widget headerFilter() {
    return Observer(
      builder: (context) {
        bool isIncome = context.watch<CategoryStore>().isIncome;

        return Row(
          children: [
            filterButton(
                'Expense',
                isIncome ? const Color(0xFFA4A7C6) : ColorConstant.secondary,
                isIncome ? ColorConstant.colorE9EAF1 : ColorConstant.secondary,
                () {
              context.read<CategoryStore>().setIsIncome(false);
            }),
            filterButton(
                'Income',
                isIncome ? ColorConstant.secondary : const Color(0xFFA4A7C6),
                isIncome ? ColorConstant.secondary : ColorConstant.colorE9EAF1,
                () {
              context.read<CategoryStore>().setIsIncome(true);
            }),
          ],
        );
      },
    );
  }

  Widget filterButton(
      String title, Color textColor, Color buttonColor, VoidCallback action) {
    return Expanded(
      child: InkWell(
        onTap: action,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: buttonColor,
                width: 2,
              ),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              letterSpacing: 1,
              color: textColor,
            ),
          ),
        ),
      ),
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
              searchInput(),
              const SizedBox(
                height: 16,
              ),
              categoryList(),
            ],
          ),
        ));
  }

  Widget categoryList() {
    return Observer(builder: (context) {
      ObservableList<CategoryData> categories =
          context.read<CategoryStore>().searchCategory;

      String searchText = context.watch<CategoryStore>().searchText;

      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              if (categories[index].level == 2 ||
                  (categories[index].level == 1 && searchText != ''))
                categoryTile(categories[index]),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: categories[index].subcategory?.length,
                  itemBuilder: (context, innerIndex) {
                    if (categories[index].subcategory != null) {
                      return Container(
                        padding: const EdgeInsets.only(left: 32),
                        child: categoryTile(
                            categories[index].subcategory![innerIndex]),
                      );
                    }
                  })
            ],
          );
        },
      );
    });
  }

  Widget categoryTile(CategoryData category) {
    return InkWell(
      onTap: () {
        widget.setCategory(category);
        Navigator.pop(context);
      },
      child: Container(
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
              category.name,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                letterSpacing: 0.75,
                color: ColorConstant.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget searchInput() {
    return TextField(
      onChanged: context.read<CategoryStore>().setSearchText,
      decoration: InputDecoration(
        filled: true,
        fillColor: ColorConstant.backgroundColor,
        hintText: 'Search category',
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          letterSpacing: 0.5,
          color: ColorConstant.thin,
        ),
        prefixIcon: const Icon(
          Icons.search,
          size: 24,
          color: ColorConstant.thin,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
