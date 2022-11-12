import 'package:checkin_app/models/user.dart';
import 'package:flutter/cupertino.dart';

class DataProfile with ChangeNotifier {
  static List<User> _dsDoanVienChiDoan = [];

  List<User> get dsDoanVienChiDoan => _dsDoanVienChiDoan;

  setDsDoanVienChiDoan(ds) {
    _dsDoanVienChiDoan = ds;
    notifyListeners();
  }
}
