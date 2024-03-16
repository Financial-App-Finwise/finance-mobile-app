import 'package:finwise/core/constants/svg_name_constant.dart';
import 'package:finwise/core/enums/loading_status_enum.dart';
import 'package:finwise/core/helpers/icon_helper.dart';
import 'package:finwise/core/widgets/screens/loading_screen.dart';
import 'package:finwise/modules/categories/models/categories_model.dart';
import 'package:finwise/modules/categories/stores/category_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class CategoryCreateScreen extends StatefulWidget {
  final CategoryData categoryData;

  const CategoryCreateScreen({
    super.key,
    required this.categoryData,
  });

  @override
  State<CategoryCreateScreen> createState() => _CategoryCreateScreenState();
}

class _CategoryCreateScreenState extends State<CategoryCreateScreen> {
  late final store = context.read<CategoryStore>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      bool success = await store.post(widget.categoryData);

      if (success) {
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pop(context, success);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildLoadingScreen();
  }

  Widget _buildLoadingScreen() {
    return Observer(builder: (context) {
      return store.createStatus == LoadingStatusEnum.done
          ? LoadingScreen(
              title: 'Category Added Successfully!',
              description: 'Please wait...\nYou will be directed back.',
              icon: IconHelper.getSVG(SVGName.check, color: Colors.white),
            )
          : LoadingScreen(
              title: 'Just a moment',
              description: 'Please wait...\nWe are preparing for you...',
              icon: IconHelper.getSVG(SVGName.transaction, color: Colors.white),
            );
    });
  }
}
