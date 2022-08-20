import 'package:checkin_app/core/values/app_color.dart';
import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          "Chưa có tài khoản ? ",
          style: TextStyle(color: AppColors.kPrimaryColor),
        ),
        GestureDetector(
          onTap: () {
            // Navigator.pushNamed(context, RouteName.register);
          },
          child: const Text(
            "Đăng ký",
            style: TextStyle(
              color: AppColors.kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
