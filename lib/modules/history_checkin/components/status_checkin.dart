import 'package:checkin_app/models/checkin.dart';
import 'package:checkin_app/models/lanDiemDanh.dart';
import 'package:flutter/material.dart';

class StatusCheckin {
  static statusCheckin(LanDiemDanh lanDiemDanh, List<Checkin> listCheckin) {
    bool kt = kiemTraDieuKien(lanDiemDanh, listCheckin);
    bool chuaDiemDanh = kiemTraDieuKien2(lanDiemDanh);
    if (!kt) {
      if (chuaDiemDanh) {
        return 'Chưa điểm danh';
      } else {
        return 'Vắng';
      }
    } else {
      return 'Đã điểm danh';
    }
  }

  static bool kiemTraDieuKien(
      LanDiemDanh? lanDiemDanh, List<Checkin>? listCheckin) {
    bool statusCheckin = false;

    for (var ck in listCheckin!) {
      if (ck.suKienId == lanDiemDanh!.suKienId &&
          ck.lanDiemDanh == lanDiemDanh.lanThu) {
        statusCheckin = true;
        listCheckin.remove(ck);
        break;
      }
    }
    return statusCheckin;
  }

  static bool kiemTraDieuKien2(LanDiemDanh? lanDiemDanh) {
    DateTime now = DateTime.now();

    if (lanDiemDanh!.thoiGianDong!.isAfter(now)) {
      return true;
    }
    return false;
  }
}
