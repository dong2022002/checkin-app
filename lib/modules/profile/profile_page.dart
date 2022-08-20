import 'package:checkin_app/modules/auth/auth_provider/user_provider.dart';
import 'package:flutter/material.dart';

import '../../core/values/app_color.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider _userProvider = UserProvider();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Thông tin cá nhân'.toUpperCase(),
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 30,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.fromLTRB(25, 50, 25, 10),
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(width: 5, color: Colors.white),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 20,
                        offset: Offset(5, 5),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.person,
                    size: 80,
                    color: Colors.grey.shade300,
                  ),
                ),
                // const CircleAvatar(
                //   radius: 50.0,
                //   backgroundImage: AssetImage('assets/images/dunloc.jpg'),
                // ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  '${_userProvider.user.hoTen}',
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                // const Text(
                //   'Sinh viên',
                //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                // ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                        alignment: Alignment.topLeft,
                        child: const Text(
                          "Thông tin cá nhân",
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Card(
                        child: Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  ...ListTile.divideTiles(
                                    color: Colors.black,
                                    tiles: [
                                      ListTile(
                                        leading: const Icon(
                                          Icons.person,
                                          color: AppColors.kPrimaryColor,
                                        ),
                                        title: const Text("Mã số sinh viên"),
                                        subtitle:
                                            Text("${_userProvider.user.mssv}"),
                                      ),
                                      const ListTile(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 4),
                                        leading: Icon(
                                          Icons.class_outlined,
                                          color: AppColors.kPrimaryColor,
                                        ),
                                        title: Text("Chi Đoàn"),
                                        subtitle: Text("CTK44B"),
                                      ),
                                      ListTile(
                                        leading: const Icon(
                                          Icons.calendar_month_rounded,
                                          color: AppColors.kPrimaryColor,
                                        ),
                                        title: const Text("Ngày sinh"),
                                        subtitle: Text("..."),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
