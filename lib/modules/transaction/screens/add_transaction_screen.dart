import 'package:finwise/modules/budget_plan/widgets/filter_bar.dart';
import 'package:flutter/material.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Scaffold(
      body: Container(
        alignment: Alignment.topLeft,
        color: Colors.blue[200],
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Icon(Icons.close),
                Text('Add transaction'),
                FilterBar(filterTitles: ['Income', 'Expense']),
                TextFormField(),
                TextFormField(),
                TextFormField(),
                TextFormField(),
                ElevatedButton(onPressed: () {}, child: SizedBox()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
