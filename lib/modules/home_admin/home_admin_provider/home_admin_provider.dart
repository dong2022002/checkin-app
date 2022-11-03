import 'dart:convert';

import 'package:checkin_app/components/box_thong_bao.dart';
import 'package:checkin_app/core/api/token.dart';
import 'package:checkin_app/core/values/app_url/app_url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeAdminProvider extends ChangeNotifier {
  // ---- POST---------
  Future<void> postCreateEvent(int suKienId, int lanThu, String dateBegin,
      String dateEnd, context) async {
    final Map<String, dynamic> checkinApi = {
      "suKienId": suKienId,
      "lanThu": lanThu,
      "thoiGianMo": dateBegin,
      "thoiGianDong": dateEnd,
    };

    //final Map<String, dynamic> userApi = user.toJson();
    final response = await http
        .post(
          Uri.parse(AppUrl.createLanDiemDanh),
          body: json.encode(checkinApi),
          headers: headersToken,
        )
        .catchError(onError);

    if (response.statusCode == 200) {
      showDialog(
          context: context,
          builder: (context) {
            return BoxThongBao(
              icon: Icons.check_circle,
              onPress: () {
                Navigator.pop(context);
              },
              tittle: 'Tạo điểm danh thành công',
              textArlert: 'Tiếp tục',
            );
          });
    } else {
      throw Exception("Failed to post");
    }
  }
}

/// ------ END POST -------

Map<String, String> get headersToken {
  return {'Content-Type': 'application/json', 'x-token': Token.token};
}

onError(e) {
  throw Exception("failed to connect" + e);
}
