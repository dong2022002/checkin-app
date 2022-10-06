class Admin {
  int? iD;
  String? userName;
  String? nickName;
  String? phone;
  String? email;

  Admin({this.iD, this.userName, this.nickName, this.phone, this.email});

  Admin.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    userName = json['userName'];
    nickName = json['nickName'];
    phone = json['phone'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['userName'] = userName;
    data['nickName'] = nickName;
    data['phone'] = phone;
    data['email'] = email;
    return data;
  }
}
