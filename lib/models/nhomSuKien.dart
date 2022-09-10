class NhomSuKien {
  int? iD;
  String? createdAt;
  String? updatedAt;
  String? ten;
  int? lienChiDoanId;

  NhomSuKien(
      {this.iD, this.createdAt, this.updatedAt, this.ten, this.lienChiDoanId});

  NhomSuKien.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    ten = json['ten'];
    lienChiDoanId = json['lienChiDoanId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['CreatedAt'] = createdAt;
    data['UpdatedAt'] = updatedAt;
    data['ten'] = ten;
    data['lienChiDoanId'] = lienChiDoanId;
    return data;
  }
}
