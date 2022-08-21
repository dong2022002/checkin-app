import 'dart:convert';

import 'package:checkin_app/core/api/token.dart';
import 'package:checkin_app/core/values/app_url/app_url.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CheckinProvider with ChangeNotifier {
  Future<void> postCheckinUser(int? code, int? id) async {
    final Map<String, dynamic> checkinApi = {
      "doanVienId": id,
      "sukienId": code,
      "lanDiemDanh": 1,
      "thoiGian": "T6, 01:35 PM, 05/08/2022",
      "viTri": "11.954546348293173, 108.4441818400426",
      "hinh thuc": "online"
    };
    //final Map<String, dynamic> userApi = user.toJson();
    final response = await http
        .post(
          Uri.parse(AppUrl.checkin),
          body: json.encode(checkinApi),
          headers: headersToken,
        )
        .catchError(onError);

    if (response.statusCode == 200) {
    } else {
      throw Exception("Failed to post");
    }
  }

  Map<String, String> get headersToken {
    return {'Content-Type': 'application/json', 'x-token': Token.token};
  }

  onError(e) {
    throw Exception("failed to connect" + e);
  }
}
