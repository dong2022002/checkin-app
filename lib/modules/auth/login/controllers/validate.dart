import 'package:checkin_app/core/md5/hash_code_md5.dart';
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

  ///New Pass
  static String? newPassValidate(value, _passController) {
    if (value!.isEmpty) {
      return 'Mật khẩu không được để trống';
    }
    return null;
  }

  static String? confirmPassValidate(
      value,
      TextEditingController _confirmPassController,
      TextEditingController _passController) {
    if (value!.isEmpty) {
      return 'Mật khẩu không được để trống';
    } else {
      if (_confirmPassController.text.compareTo(_passController.text) != 0) {
        return 'mật khẩu xác nhận không đúng';
      }
    }
    return null;
  }

  /// Password

  static String? passValidate(value, List<User> usersdata,
      TextEditingController passController, String emailUser) {
    String passUser = HashCodeMD5().generateMd5(passController.text);
    if (value!.isEmpty) {
      return 'Mật khẩu không được để trống';
    } else {
      if (user.user.matKhau == passUser && user.user.email == emailUser) {
      } else {
        return "Sai mật khẩu";
      }
    }
    return null;
  }
}
