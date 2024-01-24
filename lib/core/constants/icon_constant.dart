import 'package:finwise/core/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

const _svgPath = 'assets/images/svg/';

class IconConstant {
  static SvgPicture avatar = SvgPicture.asset('${_svgPath}avatar.svg');

  static SvgPicture budgetPlan = SvgPicture.asset('${_svgPath}budget_plan.svg');

  static SvgPicture earn = SvgPicture.asset('${_svgPath}earn.svg');

  static SvgPicture expense = SvgPicture.asset('${_svgPath}expense.svg');

  static SvgPicture myBudget({Color color = Colors.white}) => SvgPicture.asset(
        '${_svgPath}my_budget.svg',
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      );

  static SvgPicture notification =
      SvgPicture.asset('${_svgPath}notification.svg');

  static SvgPicture piggyBank = SvgPicture.asset('${_svgPath}piggy_bank.svg');

  static SvgPicture piggyBank2 = SvgPicture.asset('${_svgPath}piggy_bank.svg');

  static SvgPicture getSmartGoal({Color color = Colors.black}) =>
      SvgPicture.asset(
        '${_svgPath}smart_goal.svg',
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      );

  static SvgPicture warning = SvgPicture.asset('${_svgPath}warning.svg');

  // methods

  static SvgPicture getUpcomingBill({Color color = Colors.white}) =>
      SvgPicture.asset(
        '${_svgPath}upcoming_bill.svg',
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      );

  // bottom navigation
  static SvgPicture getHome({bool isSelected = false}) => SvgPicture.asset(
        '${_svgPath}home.svg',
        colorFilter: ColorFilter.mode(
            isSelected ? Color(0xff00A6FB) : ColorConstant.mainText,
            BlendMode.srcIn),
      );
  static SvgPicture available = SvgPicture.asset('${_svgPath}available.svg');

  static SvgPicture spend = SvgPicture.asset('${_svgPath}spend.svg');

  static SvgPicture overBudget = SvgPicture.asset('${_svgPath}over_budget.svg');

  static SvgPicture contentManagerDashboard =
      SvgPicture.asset('${_svgPath}content_manager_dashboard.svg');

  static SvgPicture addSquare = SvgPicture.asset('${_svgPath}add_square.svg');

  static SvgPicture close = SvgPicture.asset('${_svgPath}close.svg');

  // static
}
