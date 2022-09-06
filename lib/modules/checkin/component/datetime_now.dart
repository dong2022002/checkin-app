import 'package:jiffy/jiffy.dart';

class DatetimeNow {
  static DateTime now = DateTime.now();
  static DateTime test = DateTime(2022, 9, 6, 20, 0);
  static getDatetimeNow(now) {
    return Jiffy(now).format('EEEE, h:mm a, dd/MM/yyyy');
  }
}
