import 'package:checkin_app/modules/auth/login/background.dart';
import 'package:checkin_app/modules/auth/register/controllers/Input_register.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
                'Đăng ký tài khoản',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 20.0),
              InputRegister(),

              // Row(
              //   children: [
              //     Expanded(
              //       child: InputField(
              //         hintText: 'Họ',
              //         icon: Icons.person,
              //       ),
              //     ),
              //     const SizedBox(
              //       width: 10,
              //     ),
              //     Expanded(
              //       child: InputField(
              //         hintText: 'Tên',
              //         icon: Icons.person,
              //       ),
              //     ),
              //   ],
              // ),

              // InputField(
              //   hintText: 'Chi đoàn',
              //   icon: Icons.class__outlined,
              // ),
              // InputField(
              //   hintText: 'Email',
              //   icon: Icons.person,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
