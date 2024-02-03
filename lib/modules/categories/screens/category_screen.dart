import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/constants/icon_constant.dart';
import 'package:finwise/core/constants/loading_status_constant.dart';
import 'package:finwise/core/widgets/custom_icon_button.dart';
import 'package:finwise/modules/categories/models/categories_model.dart';
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
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 1), () async {
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
              for (int index = 0;
                  index < categoryModel.categoryDataList.length;
                  index++)
                Column(
                  children: [
                    mainCategoryTile(categoryModel.categoryDataList[index].name)
                  ],
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
            style: TextStyle(
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
