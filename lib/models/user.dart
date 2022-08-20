class User {
  int? iD;
  String? createdAt;
  String? updatedAt;
  String? hoTen;
  String? mssv;
  int? chiDoanId;
  String? dienThoai;
  String? email;
  String? matKhau;
  bool? kichHoat;
  bool? biKhoa;
  String? thoiGianDangNhapLanCuoi;

  User(
      {this.iD,
      this.createdAt,
      this.updatedAt,
      this.hoTen,
      this.mssv,
      this.chiDoanId,
      this.dienThoai,
      this.email,
      this.matKhau,
      this.kichHoat,
      this.biKhoa,
      this.thoiGianDangNhapLanCuoi});

  User.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    createdAt = json['CreatedAt'];
    updatedAt = json['UpdatedAt'];
    hoTen = json['hoTen'];
    mssv = json['mssv'];
    chiDoanId = json['chiDoanId'];
    dienThoai = json['dienThoai'];
    email = json['email'];
    matKhau = json['matKhau'];
    kichHoat = json['kichHoat'];
    biKhoa = json['biKhoa'];
    thoiGianDangNhapLanCuoi = json['thoiGianDangNhapLanCuoi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['CreatedAt'] = this.createdAt;
    data['UpdatedAt'] = this.updatedAt;
    data['hoTen'] = this.hoTen;
    data['mssv'] = this.mssv;
    data['chiDoanId'] = this.chiDoanId;
    data['dienThoai'] = this.dienThoai;
    data['email'] = this.email;
    data['matKhau'] = this.matKhau;
    data['kichHoat'] = this.kichHoat;
    data['biKhoa'] = this.biKhoa;
    data['thoiGianDangNhapLanCuoi'] = this.thoiGianDangNhapLanCuoi;
    return data;
  }
}
