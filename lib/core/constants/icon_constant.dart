import 'package:finwise/core/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

const _svgPath = 'assets/images/svg/';

class IconConstant {
  static SvgPicture arrowLeft = SvgPicture.asset('${_svgPath}arrow_left.svg');

  static SvgPicture arrowRight = SvgPicture.asset('${_svgPath}arrow_right.svg');

  static SvgPicture infoALert = SvgPicture.asset('${_svgPath}info_alert.svg');

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

  static SvgPicture available = SvgPicture.asset('${_svgPath}available.svg');

  static SvgPicture spend = SvgPicture.asset('${_svgPath}spend.svg');

  static SvgPicture overBudget = SvgPicture.asset('${_svgPath}over_budget.svg');

  static SvgPicture contentManagerDashboard =
      SvgPicture.asset('${_svgPath}content_manager_dashboard.svg');

  static SvgPicture addSquare = SvgPicture.asset('${_svgPath}add_square.svg');

  static SvgPicture close = SvgPicture.asset('${_svgPath}close.svg');

  static SvgPicture delete = SvgPicture.asset('${_svgPath}delete.svg');

  static SvgPicture edit = SvgPicture.asset('${_svgPath}edit.svg');

  // methods

  static SvgPicture getUpcomingBill({Color color = Colors.white}) =>
      SvgPicture.asset(
        '${_svgPath}upcoming_bill.svg',
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      );

  // bottom navigation
  static SvgPicture getHome({Color color = Colors.black}) => SvgPicture.asset(
        '${_svgPath}home.svg',
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      );

  static SvgPicture getReport({Color color = Colors.black}) => SvgPicture.asset(
        '${_svgPath}report.svg',
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      );

  static SvgPicture getSchoolBus({Color color = Colors.white}) =>
      SvgPicture.asset(
        '${_svgPath}school_bus.svg',
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      );

  static SvgPicture getUser({Color color = Colors.white}) => SvgPicture.asset(
        '${_svgPath}user.svg',
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      );

  static SvgPicture getBottomUser({Color color = Colors.white}) =>
      SvgPicture.asset(
        '${_svgPath}bottom_nav_user.svg',
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      );

  static SvgPicture getArrowRight({Color color = Colors.black}) =>
      SvgPicture.asset(
        '${_svgPath}arrow_right.svg',
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      );

  static SvgPicture getMore({Color color = Colors.black}) => SvgPicture.asset(
        '${_svgPath}more.svg',
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      );

  // static
}
