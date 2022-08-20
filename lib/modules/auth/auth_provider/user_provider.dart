import 'package:checkin_app/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  static User _user = User();
  User get user => _user;
  setUser(User user) {
    _user = user;
    notifyListeners();
  }
}
