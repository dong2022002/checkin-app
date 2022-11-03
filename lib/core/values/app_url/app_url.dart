class AppUrl {
  static const String baseUrl = 'http://10.0.2.2:8080/api';
  // static const String baseUrl = 'http://192.168.1.7:8080/api';

  static const String login = baseUrl + '/doanVien/getDoanVienList';
  static const String checkin = baseUrl + '/diemDanh/createDiemDanh';
  static const String changePassword = baseUrl + '/doanVien/changePassword';
  static const String activeUser = baseUrl + '/doanVien/activeAccount';
  static const String chiDoan = baseUrl + '/capCoSo/findCapCoSo';
  static const String danhSachLanDiemDanh =
      baseUrl + '/lanDiemDanh/getLanDiemDanhList';
  static const String danhSachNhomSK =
      baseUrl + '/nhomSuKien/getNhomSuKienList';
  static const String timSKTheoIdSK = "/suKien/findSuKien";
  static const String danhSachDiemDanhSK =
      baseUrl + '/diemDanh/getDiemDanhList';
  static const String timCacSuKienDoanVienThamGia =
      baseUrl + "/suKien/timCacSuKienDoanVienThamGia";
  static const String danhSachSuKien = baseUrl + "/suKien/getSuKienList";
  static const String danhSachDiemDanh = baseUrl + "/diemDanh/getDiemDanhList";
  static const String timNhomSuKien = baseUrl + "/nhomSuKien/findNhomSuKien";
  static const String timSuKienTheoID = baseUrl + "/suKien/findSuKien";
  static const String kiemtraAdmin =
      baseUrl + "/user/findByUsernameAndPassword";
  static const String timChiDoanTheoAdmin =
      baseUrl + "/capCoSo/findCapCoSoByAdminId";
  static const String createLanDiemDanh =
      baseUrl + "/lanDiemDanh/createLanDiemDanh";
}
