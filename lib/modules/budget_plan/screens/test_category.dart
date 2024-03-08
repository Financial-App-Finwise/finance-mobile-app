import 'package:finwise/core/layouts/overlay_header_layout.dart';
import 'package:finwise/modules/categories/models/categories_model.dart';
import 'package:finwise/modules/categories/stores/category_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class TestCategory extends StatefulWidget {
  const TestCategory({super.key});

  @override
  State<TestCategory> createState() => _TestCategoryState();
}

class _TestCategoryState extends State<TestCategory> {
  @override
  void initState() {
    super.initState();
    // debugPrint('--> START: splash screen initState');
    Future.delayed(Duration(seconds: 1), () async {
      // if the state object is mounted
      if (mounted) {
        await context.read<CategoryStore>().read();
        // debugPrint('<-- END: splash screen initState');
      }
    });
  }

  late CategoryModel categoryModel =
      context.watch<CategoryStore>().categoryModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OverlayHeaderLayout(
          title: 'title',
          description: 'description',
          firstColor: Colors.blue,
          secondColor: Colors.red,
          height: 100,
          overlayChild: const Text(
            'texty',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          child: Observer(builder: (context) {
            return Text(context
                .watch<CategoryStore>()
                .categoryModel
                .categoryDataList[0]
                .name);
          })),
    );
  }
}
