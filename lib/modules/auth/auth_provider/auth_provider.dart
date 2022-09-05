import 'dart:async';
import 'dart:convert';

import 'package:checkin_app/core/api/token.dart';
import 'package:checkin_app/core/md5/hash_code_md5.dart';
import 'package:checkin_app/core/values/app_url/app_url.dart';
import 'package:checkin_app/models/chidoan.dart';
import 'package:checkin_app/models/user.dart';
import 'package:checkin_app/modules/auth/auth_provider/user_provider.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  ///----------PUT--------------------
  //----Thay doi mat khau nguoi dung
  Future<void> putUser(int id, String newPass) async {
    var pass = HashCodeMD5().generateMd5(newPass);
    final Map<String, dynamic> userApi = {
      "ID": id,
      "matKhau": pass,
    };

    final response = await http
        .put(
          Uri.parse(AppUrl.changePassword),
          body: json.encode(userApi),
          headers: headersToken,
        )
        .catchError(onError);

    if (response.statusCode == 200) {
    } else {
      throw Exception("Failed to post");
    }
  }

  ///--- kich hoat tai khoan
  Future<void> putActiveUser(int id) async {
    bool active = true;
    final Map<String, dynamic> userApi = {
      "ID": id,
      "kichHoat": active,
    };
    final response = await http
        .put(
          Uri.parse(AppUrl.activeUser),
          body: json.encode(userApi),
          headers: headersToken,
        )
        .catchError(onError);

    if (response.statusCode == 200) {
    } else {
      throw Exception("Failed to post");
    }
  }

  ///----------END PUT--------------------
  ///------------GET----------------------
  ///- lay danh sach user
  Future<List<User>> fetchUser() async {
    final reponse = await http
        .get(Uri.parse(AppUrl.login), headers: headersToken)
        .catchError(onError);
    if (reponse.statusCode == 200) {
      List<User> users = (json.decode(reponse.body)['data']['list'] as List)
          .map((e) => User.fromJson(e))
          .toList();

      return users;
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<void> getChiDoan(UserProvider user) async {
    final reponse = await http
        .get(Uri.parse(AppUrl.chiDoan + "?ID=${user.user.chiDoanId}"),
            headers: headersToken)
        .catchError(onError);
    if (reponse.statusCode == 200) {
      var data = (json.decode(reponse.body)['data']['recapCoSo']);
      ChiDoan chiDoan = ChiDoan.fromJson(data);
      user.setChiDoan(chiDoan);
    } else {
      throw Exception('Failed to load');
    }
  }
}

///----------END GET--------------------

Map<String, String> get headersToken {
  return {'Content-Type': 'application/json', 'x-token': Token.token};
}

onError(e) {
  throw Exception("failed to connect" + e);
}
