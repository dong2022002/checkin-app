import 'package:checkin_app/models/admin.dart';
import 'package:checkin_app/models/chidoan.dart';
import 'package:checkin_app/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  @override
  void dispose() {
    _user = User();
    _dataUser = [];
    _chiDoan = ChiDoan();
    _ad = Admin();
    super.dispose();
  }

  static User _user = User();
  static List<User> _dataUser = [];
  static ChiDoan _chiDoan = ChiDoan();
  static Admin? _ad;
  static int? _code;
  int? get code => _code;
  ChiDoan get chiDoan => _chiDoan;
  List<User> get dataUser => _dataUser;
  Admin? get admin => _ad;
  User get user => _user;
  setCode(code) {
    _code = code;
    notifyListeners();
  }

  setAdmin(admin, code) {
    _ad = admin;
    _code = code;
    notifyListeners();
  }

  setUser(User user) {
    _user = user;
    notifyListeners();
  }

  setChiDoan(ChiDoan chiDoan) {
    _chiDoan = chiDoan;
    notifyListeners();
  }

  setDataUser(dataUser) {
    _dataUser = dataUser;
    notifyListeners();
  }
}
