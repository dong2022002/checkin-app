import 'package:checkin_app/components/box_thong_bao.dart';
import 'package:checkin_app/components/button.dart';
import 'package:checkin_app/core/values/app_color.dart';
import 'package:checkin_app/core/values/app_style.dart';
import 'package:checkin_app/modules/auth/auth_provider/auth_provider.dart';
import 'package:checkin_app/modules/auth/auth_provider/user_provider.dart';
import 'package:checkin_app/modules/auth/login/controllers/validate.dart';
import 'package:checkin_app/route/route_name.dart';
import 'package:flutter/material.dart';

class InputChangePassword extends StatefulWidget {
  const InputChangePassword({
    Key? key,
  }) : super(key: key);

  @override
  State<InputChangePassword> createState() => _InputChangePasswordState();
}

class _InputChangePasswordState extends State<InputChangePassword> {
  bool _showPass = false;

  final TextEditingController _passController = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  UserProvider user = UserProvider();

  // ignore: unused_field
  late String _password, _confirmPassword;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void doChangePass() async {
      final form = formKey.currentState;
      if (form!.validate()) {
        form.save();

        AuthProvider().putUser(user.user.iD!, _password);
        AuthProvider().putActiveUser(user.user.iD!).whenComplete(() {
          showDialog(
              context: context,
              builder: (context) {
                return BoxThongBao(
                  icon: Icons.check_circle,
                  onPress: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, RouteName.loginPage, (route) => false);
                  },
                  tittle: 'Thay đổi mật khẩu thành công',
                  textArlert: 'Tiếp tục',
                );
              });
        });
      }
    }

    return SafeArea(
      child: Form(
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: registerPadding(),
              child: TextFormField(
                enabled: false,
                decoration: userDecoration(text: "${user.user.email}"),
              ),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: registerPadding(),
              child: TextFormField(
                controller: _passController,
                obscureText: !_showPass,
                decoration: passInputDecoration(label: "Mật khẩu cũ"),
                validator: (value) => Validate.passValidate(
                    value, user.dataUser, _passController, user.user.email!),
                onSaved: (value) => _password = value!,
              ),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: registerPadding(),
              child: TextFormField(
                controller: _newPassController,
                obscureText: !_showPass,
                decoration: passInputDecoration(label: "Mật khẩu mới"),
                validator: (value) =>
                    Validate.newPassValidate(value!, _newPassController),
                onSaved: (value) => _password = value!,
              ),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: registerPadding(),
              child: TextFormField(
                controller: _confirmPassController,
                obscureText: !_showPass,
                decoration: passInputDecoration(label: "Nhập lại mật khẩu mới"),
                validator: (value) => Validate.confirmPassValidate(
                    value!, _confirmPassController, _newPassController),
                onSaved: (value) => _confirmPassword = value!,
              ),
            ),
            const SizedBox(height: 10.0),
            Button(text: 'Xác nhận', press: doChangePass),
          ],
        ),
      ),
    );
  }

  EdgeInsets registerPadding() =>
      const EdgeInsets.only(top: 4, right: 8, left: 8);

  InputDecoration passInputDecoration({String? label}) {
    return InputDecoration(
      prefixIcon: const Icon(Icons.lock),
      suffixIcon: GestureDetector(
          onTap: showTogglePassWord,
          child: Icon(!_showPass ? Icons.visibility : Icons.visibility_off)),
      border: loginOutlineInputBorder(),
      labelText: label,
      fillColor: AppColors.kPrimaryLightColor,
      filled: true,
      enabledBorder: loginOutlineInputBorder(),
      contentPadding: const EdgeInsets.all(16),
      isDense: true,
    );
  }

  InputDecoration changePassDecoration({String label = ""}) {
    return InputDecoration(
      border: loginOutlineInputBorder(),
      labelText: label,
      fillColor: AppColors.kPrimaryLightColor,
      filled: true,
      prefixIcon: const Icon(Icons.person),
      enabledBorder: loginOutlineInputBorder(),
      contentPadding: const EdgeInsets.all(16),
      isDense: true,
    );
  }

  InputDecoration userDecoration({String text = ""}) {
    return InputDecoration(
      border: loginOutlineInputBorder(),
      labelStyle: AppStyles.h5.copyWith(color: const Color(0xff414141)),
      labelText: text,
      fillColor: AppColors.kPrimaryLightColor,
      filled: true,
      prefixIcon: const Icon(Icons.person),
      enabledBorder: loginOutlineInputBorder(),
      contentPadding: const EdgeInsets.all(16),
      isDense: true,
    );
  }

  OutlineInputBorder loginOutlineInputBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide:
            const BorderSide(color: AppColors.kPrimaryLightColor, width: 5.0));
  }

  void showTogglePassWord() {
    setState(() {
      _showPass = !_showPass;
    });
  }
}
