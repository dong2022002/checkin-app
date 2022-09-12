// ignore_for_file: file_names

import 'package:intl/intl.dart';

class LanDiemDanh {
  int? iD;

  int? suKienId;
  int? lanThu;
  DateTime? thoiGianMo;
  DateTime? thoiGianDong;
  DateFormat dateFormat = DateFormat("h:mm a dd/MM/yyyy");
  List<String>? date;
  LanDiemDanh(
      {this.iD,
      this.suKienId,
      this.lanThu,
      this.thoiGianMo,
      this.thoiGianDong});

  LanDiemDanh.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];

    suKienId = json['suKienId'];
    lanThu = json['lanThu'];
    var tgMo = json['thoiGianMo'].toString().split(', ');
    var tgDong = json['thoiGianDong'].toString().split(', ');
    thoiGianMo = dateFormat.parse('${tgMo[1].trim()} ${tgMo[2].trim()}');
    thoiGianDong = dateFormat.parse('${tgDong[1].trim()} ${tgDong[2].trim()}');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;

    data['suKienId'] = suKienId;
    data['lanThu'] = lanThu;
    data['thoiGianMo'] = thoiGianMo;
    data['thoiGianDong'] = thoiGianDong;
    return data;
  }
}
