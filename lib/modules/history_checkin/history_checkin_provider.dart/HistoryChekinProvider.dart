import 'dart:convert';

import 'package:checkin_app/core/api/token.dart';
import 'package:checkin_app/core/values/app_url/app_url.dart';
import 'package:checkin_app/models/event.dart';
import 'package:checkin_app/modules/history_checkin/history_checkin_provider.dart/DataHistoryCheckinProvider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HistoryChekinProvider with ChangeNotifier {
  final DataHistoryCheckinProvider _historyCheckinProvider =
      DataHistoryCheckinProvider();

  ///------GET---------
  Future<void> getDanhSachSK(idChiDoan) async {
    final response = await http
        .get(Uri.parse(AppUrl.danhSachSuKien + "?chiDoanId=$idChiDoan"),
            headers: headersToken)
        .catchError(onError);
    if (response.statusCode == 200) {
      _historyCheckinProvider.setDSSuKien(
          (json.decode(response.body)['data']['list'] as List)
              .map((data) => Event.fromJson(data))
              .toList());
      var tongSK = json.decode(response.body)['data'];

      _historyCheckinProvider.setTongSoSK(tongSK['total']);
      notifyListeners();
    } else {
      throw Exception('Failed to load');
    }
  }

  ///----END GET-------
  Map<String, String> get headersToken {
    return {'Content-Type': 'application/json', 'x-token': Token.token};
  }

  onError(e) {
    throw Exception("failed to connect" + e);
  }
}
