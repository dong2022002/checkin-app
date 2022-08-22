import 'package:jiffy/jiffy.dart';

class DatetimeNow {
  static DateTime now = DateTime.now();
  static getDatetimeNow() {
    return Jiffy(now).format('EEEE, h:mm a, dd/MM/yyyy');
  }
}
