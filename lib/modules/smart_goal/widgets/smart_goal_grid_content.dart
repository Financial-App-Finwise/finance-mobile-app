import 'package:finwise/modules/smart_goal/models/smart_goal_yearly_model.dart';
import 'package:finwise/modules/smart_goal/widgets/smart_goal_grid_tile.dart';
import 'package:flutter/material.dart';

class SmartGoalGridView extends StatefulWidget {
  SmartGoalGridView({
    super.key,
    required this.data,
    required this.onTap,
  });

  final Map<String, SmartGoalMonth> data;
  final void Function(int) onTap;

  @override
  State<SmartGoalGridView> createState() => _SmartGoalGridViewState();
}

class _SmartGoalGridViewState extends State<SmartGoalGridView> {
  late List<String> months = [];

  @override
  void initState() {
    super.initState();
    widget.data.forEach((key, value) {
      months.add(key);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _mainContentGridView(),
    );
  }

  Widget _mainContentGridView() {
    return Container(
      color: const Color(0xFFF5F7F8),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.data.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          crossAxisCount: 3,
        ),
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            widget.onTap(index);
          },
          child: SmartGoalGridTile(
            month: months[index],
            amount: widget.data[months[index]] == null
                ? 0
                : widget.data[months[index]]!.numberOfGoals,
          ),
        ),
      ),
    );
  }
}
