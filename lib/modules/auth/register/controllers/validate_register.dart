import 'package:flutter/cupertino.dart';

class ValidateRegister {
  static String? userValidate(value, TextEditingController _userController) {
    if (value.isEmpty) {
      return 'Tài khoản không được để trống';
    } else {
      return null;
    }
  }

  static String? passValidate(value, _passController) {
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

  static nameValidate(String s, TextEditingController lastNameController) {
    if (s.isEmpty) {
      return 'Không được để trống';
    } else {
      return null;
    }
  }
}
