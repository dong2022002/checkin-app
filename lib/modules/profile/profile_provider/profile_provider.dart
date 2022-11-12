import 'dart:convert';

import 'package:checkin_app/core/values/app_url/app_url.dart';
import 'package:checkin_app/models/user.dart';
import 'package:checkin_app/modules/home_admin/home_admin_provider/home_admin_provider.dart';
import 'package:checkin_app/modules/profile/profile_provider/data_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ProfileProvider with ChangeNotifier {
  Future<void> getdataUserIdChiDoan(idChidoan) async {
    final reponse = await http
        .get(Uri.parse(AppUrl.login + "?chiDoanId=$idChidoan"),
            headers: headersToken)
        .catchError(onError);
    if (reponse.statusCode == 200) {
      List<User> users = (json.decode(reponse.body)['data']['list'] as List)
          .map((e) => User.fromJson(e))
          .toList();
      DataProfile().setDsDoanVienChiDoan(users);
      notifyListeners();
    } else {
      throw Exception('Failed to load');
    }
  }
}
