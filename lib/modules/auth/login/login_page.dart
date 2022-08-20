import 'package:checkin_app/components/loginpage_component/register_button.dart';
import 'package:checkin_app/core/values/app_style.dart';
import 'package:checkin_app/modules/auth/login/background.dart';
import 'package:checkin_app/modules/auth/login/controllers/input_field_account_pass.dart';
import 'package:flutter/material.dart';

import '../../../core/values/app_style.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: GestureDetector(
        onTap: (() => FocusScope.of(context).unfocus()),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Đăng nhập tài khoản",
                  style: AppStyles.h4.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: size.height * 0.03),
                Image.asset(
                  "assets/images/logo_dlu_1.png",
                  height: size.height * 0.35,
                ),
                SizedBox(height: size.height * 0.03),
                const InputFieldAccountPass(),
                SizedBox(height: size.height * 0.03),
                const RegisterButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
