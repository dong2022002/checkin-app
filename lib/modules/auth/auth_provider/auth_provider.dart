import 'dart:async';
import 'dart:convert';

import 'package:checkin_app/core/values/app_url/app_url.dart';
import 'package:checkin_app/models/user.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  Future<void> postUser(String account, String password, String dob,
      String lastName, String firstName) async {
    final Map<String, dynamic> userApi = {
      "firstname": firstName,
      "lastname": lastName,
      "uid": account,
      "dob": dob,
      "departmentId": 58
    };
    //final Map<String, dynamic> userApi = user.toJson();
    final response = await http
        .post(
          Uri.parse(AppUrl.register),
          body: json.encode(userApi),
          headers: headersToken,
        )
        .catchError(onError);
    //print(response.statusCode);
    if (response.statusCode == 200) {
      //   MessageBox(
      //     action: null,
      //     button: 'Yes',
      //     content: 'Đăng ký thành công',
      //     title: 'Thông báo',
      //   );
    } else {
      throw Exception("Failed to post");
    }
  }

  Future<List<User>> fetchUser() async {
    final reponse = await http
        .get(Uri.parse(AppUrl.login), headers: headersToken)
        .catchError(onError);
    //print(json.decode(reponse.body)['data']['list']);
    if (reponse.statusCode == 200) {
      List<User> users = (json.decode(reponse.body)['data']['list'] as List)
          .map((e) => User.fromJson(e))
          .toList();
      notifyListeners();
      return users;
    } else {
      throw Exception('Failed to load');
    }
  }

  Map<String, String> get headersToken {
    return {
      'Content-Type': 'application/json',
      'x-token':
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiYWUzMDAyMjUtYTVjMi00MmIyLWE5NDUtOGZkNGE0OWMwZGE4IiwiSUQiOjcxLCJVc2VybmFtZSI6IkNoZWNraW5BcHBVc2VyIiwiTmlja05hbWUiOiJDaGVja2luQXBwIFVzZXIiLCJBdXRob3JpdHlJZCI6IjEiLCJCdWZmZXJUaW1lIjo4NjQwMCwiZXhwIjoxNjkyNTM1MDIxLCJpc3MiOiJxbVBsdXMiLCJuYmYiOjE2NjA5OTgwMjF9.waxeub10fU24gmVeWWfez9RKHBSncd0hg6Tv1qQOLCk'
    };
  }

  Future<User> updateUser(Map<String, dynamic> params) async {
    final response = await http
        .put(
          Uri.parse(
            AppUrl.update + "/${params["id"]}",
          ),
          body: params,
          headers: headersToken,
        )
        .catchError(onError);
    if (response.statusCode == 200) {
      final responseBody = await json.decode(response.body);
      return User.fromJson(responseBody);
    } else {
      throw Exception("Failed to update a User");
    }
  }

  onError(e) {
    throw Exception("failed to connect" + e);
  }
}
