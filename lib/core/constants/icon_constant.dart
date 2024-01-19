import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

const _svgPath = 'assets/images/svg/';

class IconConstant {
  static SvgPicture avatar = SvgPicture.asset('${_svgPath}avatar.svg');

  static SvgPicture budgetPlan = SvgPicture.asset('${_svgPath}budget_plan.svg');

  static SvgPicture earn = SvgPicture.asset('${_svgPath}earn.svg');

  static SvgPicture expense = SvgPicture.asset('${_svgPath}expense.svg');

  static SvgPicture myBudget = SvgPicture.asset('${_svgPath}my_budget.svg');

  static SvgPicture notification =
      SvgPicture.asset('${_svgPath}notification.svg');

  static SvgPicture piggyBank = SvgPicture.asset('${_svgPath}piggy_bank.svg');

  static SvgPicture getSmartGoal({Color color = Colors.black}) =>
      SvgPicture.asset(
        '${_svgPath}smart_goal.svg',
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      );

  static SvgPicture upcomingBill =
      SvgPicture.asset('${_svgPath}upcoming_bill.svg');

  static SvgPicture warning = SvgPicture.asset('${_svgPath}warning.svg');

  // static
}
