import 'package:intl/intl.dart';

class DatetimeFormat {
  static DateTime now = DateTime.now();
  static DateTime test = DateTime(2022, 9, 6, 20, 0);
  static getDatetimeNow(now) {
    return DateFormat("h:mm a, dd/MM/yyyy").format(now);
  }

  String getWeekday(weekday) {
    switch (weekday) {
      case 7:
        return "Chủ nhật";

      default:
        return "Thứ ${weekday + 1}";
    }
  }
}
