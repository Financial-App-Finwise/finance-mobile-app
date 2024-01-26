import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  Category({super.key});

  final Map<String, List<String>> categories = {
    'income': ['Food and Beverage', 'transportation', 'Education'],
    'expense': ['Food and Beverage', 'transportation', 'Education'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: categories['income']!.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(categories['income']![index]),
            );
          },
        ),
      ),
    );
  }
}
