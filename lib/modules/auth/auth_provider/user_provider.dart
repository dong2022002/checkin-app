import 'package:checkin_app/models/chidoan.dart';
import 'package:checkin_app/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  static User _user = User();
  static List<User> _dataUser = [];
  static ChiDoan _chiDoan = ChiDoan();
  ChiDoan get chiDoan => _chiDoan;
  List<User> get dataUser => _dataUser;

  User get user => _user;
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
