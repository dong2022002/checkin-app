import 'package:checkin_app/models/event.dart';
import 'package:flutter/cupertino.dart';

class DataHistoryCheckinProvider with ChangeNotifier {
  static List<Event> _dsSuKien = [];

  static int _tongSoSKien = 0;
  List<Event> get dsSuKien => _dsSuKien;

  int get tongSoSuKien => _tongSoSKien;

  setDSSuKien(ds) {
    _dsSuKien = ds;
    notifyListeners();
  }

  setTongSoSK(tongSK) {
    _tongSoSKien = tongSK;
    notifyListeners();
  }
}
