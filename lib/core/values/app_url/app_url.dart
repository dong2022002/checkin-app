class AppUrl {
  static const String baseUrl = 'http://10.0.2.2:8080/api/';

  static const String login = baseUrl + 'doanVien/getDoanVienList';
  static const String register = baseUrl + '/api/member/createMember';
  static const String update = baseUrl + '/api/member/updateMember';
  static const String forgotPassword = baseUrl + '/forgot_password';
  static const String checkin = baseUrl + '/api/checkin/createCheckin';
}
