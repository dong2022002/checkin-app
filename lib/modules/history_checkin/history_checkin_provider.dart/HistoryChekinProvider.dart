// ignore_for_file: file_names

import 'dart:convert';

import 'package:checkin_app/core/api/token.dart';
import 'package:checkin_app/core/values/app_url/app_url.dart';
import 'package:checkin_app/models/event.dart';
import 'package:checkin_app/models/nhomSuKien.dart';
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

  Future<void> getcacSuKienDoanVienThamGia(idDoanVien) async {
    final response = await http
        .get(
            Uri.parse(
                AppUrl.timCacSuKienDoanVienThamGia + "?doanVienId=$idDoanVien"),
            headers: headersToken)
        .catchError(onError);
    if (response.statusCode == 200) {
      _historyCheckinProvider.setDSToanBoSuKienDoanVien(
          (json.decode(response.body)['data']['list'] as List)
              .map((data) => Event.fromJson(data))
              .toList());

      notifyListeners();
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<void> getDanhSachNhomSK(idLienChiDoan) async {
    final response = await http
        .get(Uri.parse(AppUrl.danhSachNhomSK + "?lienChiDoanId=$idLienChiDoan"),
            headers: headersToken)
        .catchError(onError);
    if (response.statusCode == 200) {
      _historyCheckinProvider.setDSNhomSuKien(
          (json.decode(response.body)['data']['list'] as List)
              .map((data) => NhomSuKien.fromJson(data))
              .toList());
      var tongSK = json.decode(response.body)['data'];

      _historyCheckinProvider.setTongSoNhomSK(tongSK['total']);
      notifyListeners();
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<void> getTenNhomSK(idNhom) async {
    final response = await http
        .get(Uri.parse(AppUrl.timNhomSuKien + "?ID=$idNhom"),
            headers: headersToken)
        .catchError(onError);
    if (response.statusCode == 200) {
      var data = (json.decode(response.body)['data']['renhomSuKien']);
      _historyCheckinProvider.setTenNhom(NhomSuKien.fromJson(data));
      notifyListeners();
    } else {
      throw Exception('Failed to load');
    }
  }

  ///----END GET-------
  ///----PUT-----------
  Future<void> putChaneRightToParticipation(
      int idSuKien, bool isCheckin) async {
    final Map<String, dynamic> userApi = {
      "ID": idSuKien,
      "choPhepDoanVienKhacChiDoanThamGia": isCheckin,
    };
    final response = await http
        .put(
          Uri.parse(AppUrl.putChangeRightToParticipation),
          body: json.encode(userApi),
          headers: headersToken,
        )
        .catchError(onError);
    print(response.statusCode);
    if (response.statusCode == 200) {
    } else {
      throw Exception("Failed to post");
    }
  }

  ///----END PUT-------
  Map<String, String> get headersToken {
    return {'Content-Type': 'application/json', 'x-token': Token.token};
  }

  onError(e) {
    throw Exception("failed to connect" + e);
  }
}
