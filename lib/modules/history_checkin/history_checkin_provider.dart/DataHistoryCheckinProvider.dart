// ignore_for_file: file_names

import 'dart:math';

import 'package:checkin_app/models/event.dart';
import 'package:checkin_app/models/nhomSuKien.dart';
import 'package:flutter/cupertino.dart';

class DataHistoryCheckinProvider with ChangeNotifier {
  static List<Event> _dsSuKien = [];
  static List<Event> _dsToanBoSuKienDoanVienThamGia = [];
  static List<Event> _dsSuKienTheoDoanVien = [];

  static List<NhomSuKien> _dsNhomSuKien = [];
  static int _tongSoSKien = 0;
  static int _tongSoNhomSuKien = 0;
  static NhomSuKien? _tenNhom;
  List<Event> get dsSuKien => _dsSuKien;
  List<Event> get dsToanBoSuKienDoanVien => _dsToanBoSuKienDoanVienThamGia;
  List<Event> get dsSuKienTheoDoanVien => _dsSuKienTheoDoanVien;

  List<NhomSuKien> get dsNhomSuKien => _dsNhomSuKien;

  NhomSuKien? get tenNhom => _tenNhom;
  int get tongSoSuKien => _tongSoSKien;
  int get tongSoNhomSuKien => _tongSoNhomSuKien;

  setDSSuKien(ds) {
    _dsSuKien = ds;
    notifyListeners();
  }

  setTenNhom(tenNhom) {
    _tenNhom = tenNhom;
    notifyListeners();
  }

  setDSToanBoSuKienDoanVien(ds) {
    _dsToanBoSuKienDoanVienThamGia = ds;
    setdanhSachSuKienthamGiaTheoDoanVien();
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

  setdanhSachSuKienthamGiaTheoDoanVien() {
    bool isEvent = true;
    for (var sk in _dsToanBoSuKienDoanVienThamGia) {
      isEvent = true;
      for (var skdv in _dsSuKienTheoDoanVien) {
        if (sk.iD == skdv.iD) {
          isEvent = false;
          break;
        }
      }
      if (isEvent) {
        _dsSuKienTheoDoanVien.add(sk);
      }
    }
  }
}
