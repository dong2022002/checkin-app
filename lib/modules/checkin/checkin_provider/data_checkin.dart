import 'package:checkin_app/models/checkin.dart';
import 'package:checkin_app/models/lanDiemDanh.dart';
import 'package:flutter/cupertino.dart';

class DataCheckin with ChangeNotifier {
  static List<LanDiemDanh> _dsLanDiemDanh = [];
  static List<Checkin> _dsDiemDanhSK = [];
  List<LanDiemDanh> get dsLanDiemDanh => _dsLanDiemDanh;
  List<Checkin> get dsDiemDanhSK => _dsDiemDanhSK;

  setDSLanDiemDanh(ds) {
    _dsLanDiemDanh = ds;
    notifyListeners();
  }

  setDSDiemDanhSK(ds) {
    _dsDiemDanhSK = ds;
    notifyListeners();
  }
}
