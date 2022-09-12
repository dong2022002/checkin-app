import 'package:checkin_app/components/button.dart';
import 'package:checkin_app/core/values/app_color.dart';
import 'package:checkin_app/core/values/app_style.dart';
import 'package:checkin_app/modules/auth/auth_provider/auth_provider.dart';
import 'package:checkin_app/modules/auth/auth_provider/user_provider.dart';
import 'package:checkin_app/modules/auth/login/controllers/validate.dart';
import 'package:checkin_app/route/route_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InputFieldAccountPass extends StatefulWidget {
  const InputFieldAccountPass({Key? key}) : super(key: key);

  @override
  State<InputFieldAccountPass> createState() => _InputFieldAccountPassState();
}

class _InputFieldAccountPassState extends State<InputFieldAccountPass> {
  bool _showPass = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _userController = TextEditingController();

  bool _isloading = false;

  UserProvider user = UserProvider();
  late final String _userName, _password;

  @override
  void initState() {
    setState(() {
      _isloading = true;
    });

    Provider.of<AuthProvider>(context, listen: false).fetchUser().then((value) {
      setState(() {
        user.setDataUser(value);
        _isloading = false;
        if (!mounted) return;
      });
    }).catchError((Object e, StackTrace stackTrace) {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              controller: _userController,

              // keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: loginOutlineInputBorder(),
                labelText: 'Tài khoản',
                fillColor: AppColors.kPrimaryLightColor,
                filled: true,
                prefixIcon: const Icon(Icons.person),
                enabledBorder: loginOutlineInputBorder(),
                contentPadding: const EdgeInsets.all(16),
                isDense: true,
              ),
              validator: (value) =>
                  Validate.userValidate(value, user.dataUser, _userController),
              onSaved: (value) => _userName = value!,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4, right: 8, left: 8),
            child: TextFormField(
              controller: _passController,
              obscureText: !_showPass,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: GestureDetector(
                    onTap: showTogglePassWord,
                    child: Icon(
                        !_showPass ? Icons.visibility : Icons.visibility_off)),
                border: loginOutlineInputBorder(),
                labelText: 'Mật khẩu',
                fillColor: AppColors.kPrimaryLightColor,
                filled: true,
                enabledBorder: loginOutlineInputBorder(),
                contentPadding: const EdgeInsets.all(16),
                isDense: true,
              ),
              validator: (value) => Validate.passValidate(
                  value, user.dataUser, _passController, _userController.text),
            ),
          ),
          SizedBox(height: size.height * 0.02),
          SizedBox(
            width: size.width * 0.8,
            child: Text('Quên mật khẩu?',
                textAlign: TextAlign.right,
                style: AppStyles.h5.copyWith(
                    fontSize: 14,
                    letterSpacing: 0.7,
                    color: AppColors.kPrimaryColor,
                    fontWeight: FontWeight.w600)),
          ),
          SizedBox(height: size.height * 0.03),
          Button(
            text: 'Đăng nhập',
            press: doLogin,
          ),
        ],
      ),
    );
  }

  OutlineInputBorder loginOutlineInputBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.kGreyText, width: 1));
  }

  void showTogglePassWord() {
    setState(() {
      _showPass = !_showPass;
    });
  }

  void doLogin() {
    setState(() {
      bool _check = formKey.currentState!.validate();
      if (_check) {
        if (!user.user.kichHoat!) {
          Navigator.pushNamed(context, RouteName.changePassword);
        } else {
          Navigator.pushReplacementNamed(context, RouteName.rootPage);
        }
      } else {}
    });
  }
}
