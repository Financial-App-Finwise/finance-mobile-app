import 'package:intl/intl.dart';

class UIHelper {
  static getFormattedDate(String date) {
    if (DateTime.tryParse(date) != null) {
      DateTime parsedDate = DateTime.parse(date);
      String formattedDate = DateFormat('dd MMMM, yyyy').format(parsedDate);
      return formattedDate;
    }
    return date;
  }
}
