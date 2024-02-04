import 'package:finwise/core/constants/color_constant.dart';
import 'package:finwise/core/widgets/general_detail_layout.dart';
import 'package:flutter/material.dart';

class TransactionDetailScreen extends StatefulWidget {
  const TransactionDetailScreen({super.key});

  @override
  State<TransactionDetailScreen> createState() =>
      _TransactionDetailScreenState();
}

class _TransactionDetailScreenState extends State<TransactionDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return const GeneralDetailLayout(
      themeColor: ColorConstant.income,
      gradient: LinearGradient(
        colors: [
          ColorConstant.smartGoalLight,
          ColorConstant.smartGoalThick,
        ],
      ),
    );
  }
}
