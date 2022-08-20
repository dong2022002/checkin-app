import 'dart:convert';

import 'package:checkin_app/core/values/app_url/app_url.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CheckinProvider with ChangeNotifier {
  Future<void> postCheckinUser(String? code, int? id) async {
    final Map<String, dynamic> checkinApi = {
      "memberId": id,
      "eventId": int.parse(code!)
    };
    //final Map<String, dynamic> userApi = user.toJson();
    final response = await http
        .post(
          Uri.parse(AppUrl.checkin),
          body: json.encode(checkinApi),
          headers: headersToken,
        )
        .catchError(onError);
    print(response.statusCode);
    if (response.statusCode == 200) {
    } else {
      throw Exception("Failed to post");
    }
  }

  Map<String, String> get headersToken {
    return {
      'Content-Type': 'application/json',
      'x-token':
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZTFkYmI1OTMtZGUwOC00NTQ3LWE1MmItNjUyZTNmZDMyMDA2IiwiSUQiOjI1LCJVc2VybmFtZSI6ImRvYW52aWVuQ1RLIiwiTmlja05hbWUiOiLEkG_DoG4gdmnDqm4gS2hvYSBDTlRUIiwiQXV0aG9yaXR5SWQiOiIzIiwiQnVmZmVyVGltZSI6ODY0MDAsImV4cCI6NDgwODc0OTc1MCwiaXNzIjoicW1QbHVzIiwibmJmIjoxNjUzMDUzNTUwfQ.EeapvBUnpbkZKhxRrrt-LudayRYapL4WNRrWsMNcP7c'
    };
  }

  onError(e) {
    throw Exception("failed to connect" + e);
  }
}
