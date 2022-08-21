import 'package:checkin_app/modules/auth/login/background.dart';
import 'package:checkin_app/modules/auth/login/controllers/input_change_password.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;

    return Background(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Thay đổi mật khẩu lần đầu đăng nhập',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20.0),
              InputChangePassword(),
            ],
          ),
        ),
      ),
    );
  }
}
