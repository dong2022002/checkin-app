import 'package:intl/intl.dart';

class LanDiemDanh {
  int? iD;
  String? createdAt;
  String? updatedAt;
  int? suKienId;
  int? lanThu;
  DateTime? thoiGianMo;
  DateTime? thoiGianDong;
  DateFormat dateFormat = DateFormat("h:mm a dd-MM-yyyy");
  List<String>? date;
  LanDiemDanh(
      {this.iD,
      this.createdAt,
      this.updatedAt,
      this.suKienId,
      this.lanThu,
      this.thoiGianMo,
      this.thoiGianDong});

  LanDiemDanh.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    suKienId = json['suKienId'];
    lanThu = json['lanThu'];
    var tgMo = json['thoiGianMo'].toString().split(', ');
    var tgDong = json['thoiGianDong'].toString().split(', ');
    date = tgMo[2].trim().split('/');
    thoiGianMo = dateFormat
        .parse('${tgMo[1].trim()} ${date![0]}-${date![1]}-${date![2]}');
    date = tgDong[2].trim().split('/');
    thoiGianDong = dateFormat
        .parse('${tgDong[1].trim()} ${date![0]}-${date![1]}-${date![2]}');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['CreatedAt'] = createdAt;
    data['UpdatedAt'] = updatedAt;
    data['suKienId'] = suKienId;
    data['lanThu'] = lanThu;
    data['thoiGianMo'] = thoiGianMo;
    data['thoiGianDong'] = thoiGianDong;
    return data;
  }
}
