import 'package:checkin_app/components/loginpage_component/button.dart';
import 'package:checkin_app/core/values/app_color.dart';
import 'package:checkin_app/models/user.dart';
import 'package:checkin_app/modules/auth/auth_provider/auth_provider.dart';
import 'package:checkin_app/modules/auth/auth_provider/user_provider.dart';
import 'package:checkin_app/modules/auth/login/controllers/validate.dart';
import 'package:checkin_app/route/route_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InputFieldAccountPass extends StatefulWidget {
  const InputFieldAccountPass({Key? key}) : super(key: key);

  // final TextEditingController _userController = TextEditingController();
  // TextEditingController get userController => _userController;
  @override
  State<InputFieldAccountPass> createState() => _InputFieldAccountPassState();
}

class _InputFieldAccountPassState extends State<InputFieldAccountPass> {
  bool _showPass = false;

  //final List<User> _listUser = usersdata.map((e) => User.fromJson(e)).toList();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _userController = TextEditingController();

  bool _isloading = false;
  List<User> dataUser = [];
  UserProvider user = UserProvider();
  late final String _userName, _password;

  @override
  void initState() {
    setState(() {
      _isloading = true;
    });
    Provider.of<AuthProvider>(context, listen: false).fetchUser().then((value) {
      setState(() {
        dataUser = value;
        _isloading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  Validate.userValidate(value, dataUser, _userController),
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
                  value, dataUser, _passController, _userController.text),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
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
        borderRadius: BorderRadius.circular(100),
        borderSide:
            const BorderSide(color: AppColors.kPrimaryLightColor, width: 5.0));
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
          Navigator.pushNamed(context, RouteName.homePage);
        }
      } else {}
    });
    // Navigator.pushNamed(context, RouteName.homePage);
  }
}
