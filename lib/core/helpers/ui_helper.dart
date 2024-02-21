import 'package:intl/intl.dart';

abstract class UIHelper {
  static getFormattedDate(String? date) {
    date = date ?? 'no date';
    if (DateTime.tryParse(date) != null) {
      DateTime parsedDate = DateTime.parse(date);
      String formattedDate = DateFormat('dd MMMM, yyyy').format(parsedDate);
      return formattedDate;
    }
    return date;
  }

  static getInputDate(String? date) {
    date = date ?? 'no date';
    if (DateTime.tryParse(date) != null) {
      DateTime parsedDate = DateTime.parse(date);
      String formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);
      return formattedDate;
    }
    return date;
  }

  static getYYYYMMDD(String? date) {
    date = date ?? 'no date';

    if (DateTime.tryParse(date) != null) {
      DateTime parsedDate = DateTime.parse(date);
      String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
      return formattedDate;
    }
    return date;
  }

  static getDateFormat(String? date, String format) {
    date = date ?? 'no date';
    if (DateTime.tryParse(date) != null) {
      DateTime parsedDate = DateTime.parse(date);
      String formattedDate = DateFormat(format).format(parsedDate);
      return formattedDate;
    }
    return date;
  }
}
