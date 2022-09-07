import 'dart:convert';

import 'package:checkin_app/components/box_thong_bao.dart';
import 'package:checkin_app/core/api/token.dart';
import 'package:checkin_app/core/values/app_url/app_url.dart';
import 'package:checkin_app/models/checkin.dart';
import 'package:checkin_app/models/lanDiemDanh.dart';
import 'package:checkin_app/modules/checkin/checkin_provider/data_checkin.dart';
import 'package:checkin_app/modules/checkin/component/datetime_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class CheckinProvider with ChangeNotifier {
  DataCheckin _dataCheckin = DataCheckin();
  // ---- POST---------
  Future<void> postCheckinUser(
      int? code, int? id, Position position, lanDiemDanh, context) async {
    final Map<String, dynamic> checkinApi = {
      "doanVienId": id,
      "sukienId": code,
      "lanDiemDanh": lanDiemDanh,
      "thoiGian": DatetimeFormat().getWeekday(DateTime.now().weekday) +
          ", " +
          DatetimeFormat.getDatetimeNow(DateTime.now()),
      "viTri": "${position.latitude}, ${position.longitude}",
      "hinhThuc": false
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
      showDialog(
          context: context,
          builder: (context) {
            return BoxThongBao(
              icon: Icons.check_circle,
              onPress: () {
                Navigator.pop(context);
              },
              tittle: 'Điểm danh thành công ',
              textArlert: 'Tiếp tục',
            );
          });
    } else {
      throw Exception("Failed to post");
    }
  }

  /// ------ END POST -------

  /// ------   GET    -------
  Future<void> getDanhSachLanDiemDanh(suKienID) async {
    final response = await http
        .get(Uri.parse(AppUrl.danhSachLanDiemDanh + "?suKienId=$suKienID"),
            headers: headersToken)
        .catchError(onError);
    if (response.statusCode == 200) {
      _dataCheckin.setDSLanDiemDanh(
          (json.decode(response.body)['data']['list'] as List)
              .map((data) => LanDiemDanh.fromJson(data))
              .toList());
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<void> getDanhSachDiemDanhSK(
      idChiDoan, idSuKien, resultData, hoTen, mssv, dienThoai) async {
    final response = await http
        .get(
            Uri.parse(AppUrl.danhSachDiemDanhSK +
                "?chiDoanId=$idChiDoan&suKienId=$idSuKien&resultData=$resultData&hoTen=$hoTen&mssv=$mssv&dienThoai=$dienThoai"),
            headers: headersToken)
        .catchError(onError);
    if (response.statusCode == 200) {
      _dataCheckin.setDSDiemDanhSK(
          (json.decode(response.body)['data']['list'] as List)
              .map((data) => Checkin.fromJson(data))
              .toList());
    } else {
      throw Exception('Failed to load');
    }
  }

  /// ------ END GET  -------

  Map<String, String> get headersToken {
    return {'Content-Type': 'application/json', 'x-token': Token.token};
  }

  onError(e) {
    throw Exception("failed to connect" + e);
  }
}
