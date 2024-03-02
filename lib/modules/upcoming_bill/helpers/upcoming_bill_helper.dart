import 'package:finwise/core/enums/upcoming_bill_enum.dart';

abstract class UpcomingBillHelper {
  static final DateTime currentDate = DateTime.now();

  static final DateTime startTomorrow =
      currentDate.add(const Duration(days: 1));
  static final DateTime endTomorrow = currentDate.add(const Duration(days: 2));

  static int weekDay = currentDate.weekday;
  static DateTime startWeek = currentDate.subtract(Duration(days: weekDay - 1));
  static DateTime endWeek = startWeek.add(const Duration(days: 6));

  static Map<UpcomingBillFilterEnum, String> enumToQuery = {
    UpcomingBillFilterEnum.all: '',
    UpcomingBillFilterEnum.tomorrow:
        'date[gte]=${startTomorrow.year}-${startTomorrow.month}-${startTomorrow.day}&date[lte]=${endTomorrow.year}-${endTomorrow.month}-${endTomorrow.day}',
    UpcomingBillFilterEnum.thisWeek:
        'date[gte]=${startWeek.year}-${startWeek.month}-${startWeek.day}&date[lte]=${endWeek.year}-${endWeek.month}-${endWeek.day}',
  };
}
