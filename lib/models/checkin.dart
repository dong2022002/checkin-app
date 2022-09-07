import 'package:intl/intl.dart';

class Checkin {
  int? iD;
  String? createdAt;
  String? updatedAt;
  int? doanVienId;
  int? suKienId;
  int? lanDiemDanh;
  DateTime? thoiGian;
  String? viTri;
  bool? hinhThuc;
  String? hoTen;
  String? mssv;
  String? dienThoai;
  DateFormat dateFormat = DateFormat("h:mm a dd/MM/yyyy");

  Checkin(
      {this.iD,
      this.createdAt,
      this.updatedAt,
      this.doanVienId,
      this.suKienId,
      this.lanDiemDanh,
      this.thoiGian,
      this.viTri,
      this.hinhThuc,
      this.hoTen,
      this.mssv,
      this.dienThoai});

  Checkin.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    doanVienId = json['doanVienId'];
    suKienId = json['suKienId'];
    lanDiemDanh = json['lanDiemDanh'];
    var tg = json['thoiGian'].toString().split(', ');
    thoiGian = dateFormat.parse('${tg[1].trim()} ${tg[2].trim()}');
    viTri = json['viTri'];
    hinhThuc = json['hinhThuc'];
    hoTen = json['hoTen'];
    mssv = json['mssv'];
    dienThoai = json['dienThoai'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['CreatedAt'] = createdAt;
    data['UpdatedAt'] = updatedAt;
    data['doanVienId'] = doanVienId;
    data['suKienId'] = suKienId;
    data['lanDiemDanh'] = lanDiemDanh;
    data['thoiGian'] = thoiGian;
    data['viTri'] = viTri;
    data['hinhThuc'] = hinhThuc;
    data['hoTen'] = hoTen;
    data['mssv'] = mssv;
    data['dienThoai'] = dienThoai;
    return data;
  }
}
