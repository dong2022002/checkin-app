import 'package:checkin_app/models/checkin.dart';
import 'package:checkin_app/models/event.dart';
import 'package:checkin_app/models/lanDiemDanh.dart';
import 'package:flutter/cupertino.dart';

class DataCheckin with ChangeNotifier {
  static List<LanDiemDanh> _dsLanDiemDanh = [];
  static List<Checkin> _dsDiemDanhSkTrongChiDoan = [];
  static List<Checkin> _dsDiemDanhSkKhacChiDoan = [];

  static int _tongSoLanDiemDanh = 0;
  static Event? _event;
  int get tongSoLanDiemDanh => _tongSoLanDiemDanh;
  List<LanDiemDanh> get dsLanDiemDanh => _dsLanDiemDanh;
  List<Checkin> get dsDiemDanhSKTrongChiDoan => _dsDiemDanhSkTrongChiDoan;
  List<Checkin> get dsDiemDanhSKKhacChiDoan => _dsDiemDanhSkKhacChiDoan;

  Event? get event => _event;

  setEvent(event) {
    _event = event;
    notifyListeners();
  }

  setTongSoLanDiemDanh(tongSoLanDiemDanh) {
    _tongSoLanDiemDanh = tongSoLanDiemDanh;
    notifyListeners();
  }

  setDSLanDiemDanh(ds) {
    _dsLanDiemDanh = ds;
    notifyListeners();
  }

  setDSDiemDanhSKTrongChiDoan(ds) {
    _dsDiemDanhSkTrongChiDoan = ds;
    notifyListeners();
  }

  setDSDiemDanhSKKhacChiDoan(ds) {
    _dsDiemDanhSkKhacChiDoan = ds;
    notifyListeners();
  }
}
