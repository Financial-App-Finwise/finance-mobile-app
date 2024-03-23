import 'package:finwise/core/constants/color_constant.dart';
import 'package:flutter/material.dart';

class BudgetGridTile extends StatefulWidget {
  final String month;
  final int budget;
  int? monthNumber;
  void Function(DateTime)? setList;
  DateTime? date;
  VoidCallback? addItem;

  BudgetGridTile({
    super.key,
    required this.month,
    required this.budget,
    this.monthNumber,
    this.setList,
    this.date,
    this.addItem,
  });

  @override
  State<BudgetGridTile> createState() => _BudgetGridTileState();
}

class _BudgetGridTileState extends State<BudgetGridTile> {
  @override
  Widget build(BuildContext context) {
    String budgetString = widget.budget > 1 ? 'budgets' : 'budget';

    return InkWell(
      onTap: () {
        widget.setList!(DateTime(widget.date!.year, widget.monthNumber!));
      },
      child: Container(
        width: 103.67,
        decoration: BoxDecoration(
          color: ColorConstant.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.month,
              style: const TextStyle(
                letterSpacing: 0.75,
                color: ColorConstant.primary,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              '${widget.budget} $budgetString',
              style: const TextStyle(
                letterSpacing: 0.75,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: ColorConstant.mainText,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              width: 24,
              height: 24,
              child: IconButton(
                onPressed: widget.addItem,
                icon: const Icon(
                  Icons.add,
                  size: 16,
                ),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                  iconColor: MaterialStateProperty.all(
                    ColorConstant.secondary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
