import 'package:intl/intl.dart';

class DatetimeFormat {
  static DateTime now = DateTime.now();
  static DateTime test = DateTime(2022, 9, 6, 20, 0);
  static getDatetimeNow(DateTime now) {
    String week = DatetimeFormat().getWeekday(now.weekday);
    return week + ', ' + DateFormat("h:mm a, dd/MM/yyyy").format(now);
  }

  static getDMYTime(DateTime dateTime) {
    String week = DatetimeFormat().getWeekday(dateTime.weekday);
    return week + ', ' + DateFormat("dd-MM-yyyy").format(dateTime);
  }

  static getTime(DateTime dateTime) {
    return DateFormat("h:mm a").format(dateTime);
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
