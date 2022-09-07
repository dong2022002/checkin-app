class Event {
  int? iD;
  String? createdAt;
  String? updatedAt;
  String? tieuDe;
  String? noiDung;
  String? anhChinh;
  int? chiDoanId;
  String? lienKet;
  int? nhomId;
  bool? choPhepDoanVienKhacChiDoanThamGia;

  Event(
      {this.iD,
      this.createdAt,
      this.updatedAt,
      this.tieuDe,
      this.noiDung,
      this.anhChinh,
      this.chiDoanId,
      this.lienKet,
      this.nhomId,
      this.choPhepDoanVienKhacChiDoanThamGia});

  Event.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    tieuDe = json['tieuDe'];
    noiDung = json['noiDung'];
    anhChinh = json['anhChinh'];
    chiDoanId = json['chiDoanId'];
    lienKet = json['lienKet'];
    nhomId = json['nhomId'];
    choPhepDoanVienKhacChiDoanThamGia =
        json['choPhepDoanVienKhacChiDoanThamGia'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['CreatedAt'] = createdAt;
    data['UpdatedAt'] = updatedAt;
    data['tieuDe'] = tieuDe;
    data['noiDung'] = noiDung;
    data['anhChinh'] = anhChinh;
    data['chiDoanId'] = chiDoanId;
    data['lienKet'] = lienKet;
    data['nhomId'] = nhomId;
    data['choPhepDoanVienKhacChiDoanThamGia'] =
        choPhepDoanVienKhacChiDoanThamGia;
    return data;
  }
}
