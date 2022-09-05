class ChiDoan {
  int? iD;
  String? createdAt;
  String? updatedAt;
  String? ten;
  int? adminId;
  int? parentId;
  int? loaiCapCoSoId;

  ChiDoan(
      {this.iD,
      this.createdAt,
      this.updatedAt,
      this.ten,
      this.adminId,
      this.parentId,
      this.loaiCapCoSoId});

  ChiDoan.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    ten = json['ten'];
    adminId = json['adminId'];
    parentId = json['parentId'];
    loaiCapCoSoId = json['loaiCapCoSoId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['CreatedAt'] = createdAt;
    data['UpdatedAt'] = updatedAt;
    data['ten'] = ten;
    data['adminId'] = adminId;
    data['parentId'] = parentId;
    data['loaiCapCoSoId'] = loaiCapCoSoId;
    return data;
  }
}
