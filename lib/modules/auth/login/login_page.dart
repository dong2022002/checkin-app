import 'package:checkin_app/core/values/app_color.dart';
import 'package:checkin_app/core/values/app_style.dart';
import 'package:checkin_app/modules/auth/login/controllers/input_field_account_pass.dart';
import 'package:flutter/material.dart';

import '../../../core/values/app_style.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body: GestureDetector(
        onTap: (() => FocusScope.of(context).unfocus()),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.04,
                ),
                Image.asset(
                  "assets/images/logo_dlu_1.png",
                  height: size.height * 0.2,
                ),
                SizedBox(height: size.height * 0.08),
                Text(
                  "Đăng nhập",
                  style: AppStyles.h4.copyWith(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.kPrimaryColor),
                ),
                SizedBox(height: size.height * 0.05),
                const InputFieldAccountPass(),
                SizedBox(height: size.height * 0.03),
                SizedBox(
                  width: size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Expanded(
                          child: Divider(
                            color: AppColors.kGreyText,
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.15,
                          child: Text(
                            'OR',
                            textAlign: TextAlign.center,
                            style: AppStyles.h5.copyWith(
                                color: const Color(0xffa0a3a9),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Expanded(
                          child: Divider(
                            color: AppColors.kGreyText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.03),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: size.width * 0.8,
                      height: size.width * 0.12,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: AppColors.kGreyText),
                          borderRadius: BorderRadius.circular(10)),
                      child: IconButton(
                          onPressed: () {},
                          icon: Image.asset('assets/images/google-logo.png')),
                    ),
                  ],
                ),

                ///---------------Đăng ký-----------------
                // const RegisterButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
