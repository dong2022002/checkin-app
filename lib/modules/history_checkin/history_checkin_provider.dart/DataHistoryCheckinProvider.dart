import 'package:checkin_app/models/event.dart';
import 'package:checkin_app/models/nhomSuKien.dart';
import 'package:flutter/cupertino.dart';

class DataHistoryCheckinProvider with ChangeNotifier {
  static List<Event> _dsSuKien = [];
  static List<NhomSuKien> _dsNhomSuKien = [];
  static int _tongSoSKien = 0;
  static int _tongSoNhomSuKien = 0;

  List<Event> get dsSuKien => _dsSuKien;
  List<NhomSuKien> get dsNhomSuKien => _dsNhomSuKien;

  int get tongSoSuKien => _tongSoSKien;
  int get tongSoNhomSuKien => _tongSoNhomSuKien;

  setDSSuKien(ds) {
    _dsSuKien = ds;
    notifyListeners();
  }

  setDSNhomSuKien(ds) {
    _dsNhomSuKien = ds;
    notifyListeners();
  }

  setTongSoSK(tongSK) {
    _tongSoSKien = tongSK;
    notifyListeners();
  }

  setTongSoNhomSK(tongSK) {
    _tongSoNhomSuKien = tongSK;
    notifyListeners();
  }
}
