class ChiDoan {
  int? iD;

  String? ten;
  int? adminId;
  int? parentId;
  int? loaiCapCoSoId;

  ChiDoan({this.iD, this.ten, this.adminId, this.parentId, this.loaiCapCoSoId});

  ChiDoan.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];

    ten = json['ten'];
    adminId = json['adminId'];
    parentId = json['parentId'];
    loaiCapCoSoId = json['loaiCapCoSoId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;

    data['ten'] = ten;
    data['adminId'] = adminId;
    data['parentId'] = parentId;
    data['loaiCapCoSoId'] = loaiCapCoSoId;
    return data;
  }
}
