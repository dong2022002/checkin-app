import 'package:checkin_app/models/checkin.dart';
import 'package:checkin_app/models/lanDiemDanh.dart';

class StatusCheckin {
  static statusCheckin(LanDiemDanh lanDiemDanh, List<Checkin> listCheckin) {
    bool kt = kiemTraDieuKien(lanDiemDanh, listCheckin);
    bool chuaDiemDanh = kiemTraDieuKien2(lanDiemDanh);
    if (!kt) {
      if (chuaDiemDanh) {
        return 0;
      } else {
        return -1;
      }
    } else {
      return 1;
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
