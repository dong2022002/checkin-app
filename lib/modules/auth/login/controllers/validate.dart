import 'package:checkin_app/models/user.dart';
import 'package:checkin_app/modules/auth/auth_provider/user_provider.dart';
import 'package:flutter/material.dart';

class Validate {
  static UserProvider user = UserProvider();

  static String? userValidate(
      value, List<User> usersdata, TextEditingController userController) {
    bool _isfound = false;
    if (value!.isEmpty) {
      return 'Tài khoản không được để trống';
    } else {
      for (var item in usersdata) {
        if (item.email?.compareTo(userController.text) == 0) {
          _isfound = true;
          user.setUser(item);
          break;
        }
      }
      return _isfound ? null : "Sai tài khoản";
    }
  }

  static String? passValidate(
      value,
      List<User> usersdata,
      TextEditingController passController,
      TextEditingController userController) {
    if (value!.isEmpty) {
      return 'Mật khẩu không được để trống';
    } else {
      //print(user.user.password);
      if (user.user.email == passController.text &&
          user.user.email == userController.text) {
      } else {
        return "Sai mật khẩu";
      }
    }
    return null;
  }
}
