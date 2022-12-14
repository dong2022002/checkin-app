class User {
  int? iD;

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;

    data['hoTen'] = hoTen;
    data['mssv'] = mssv;
    data['chiDoanId'] = chiDoanId;
    data['dienThoai'] = dienThoai;
    data['email'] = email;
    data['matKhau'] = matKhau;
    data['kichHoat'] = kichHoat;
    data['biKhoa'] = biKhoa;
    data['thoiGianDangNhapLanCuoi'] = thoiGianDangNhapLanCuoi;
    return data;
  }
}
