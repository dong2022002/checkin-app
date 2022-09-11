class NhomSuKien {
  int? iD;

  String? ten;
  int? lienChiDoanId;

  NhomSuKien({this.iD, this.ten, this.lienChiDoanId});

  NhomSuKien.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];

    ten = json['ten'];
    lienChiDoanId = json['lienChiDoanId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;

    data['ten'] = ten;
    data['lienChiDoanId'] = lienChiDoanId;
    return data;
  }
}
