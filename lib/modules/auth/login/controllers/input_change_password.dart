import 'package:checkin_app/components/loginpage_component/button.dart';
import 'package:checkin_app/core/values/app_color.dart';
import 'package:checkin_app/models/user.dart';
import 'package:checkin_app/modules/auth/auth_provider/auth_provider.dart';
import 'package:checkin_app/modules/auth/auth_provider/user_provider.dart';
import 'package:checkin_app/modules/auth/login/controllers/validate.dart';
import 'package:checkin_app/route/route_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  late String _password, _confirmPassword;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _isloading = false;
  List<User> dataUser = [];

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
    Size size = MediaQuery.of(context).size;
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    void Function() action = (() {});

    void doChangePass() async {
      final form = formKey.currentState;
      if (form!.validate()) {
        form.save();

        await authProvider.putUser(user.user.iD!, _password);
        await authProvider.putActiveUser(user.user.iD!);
        Navigator.pushReplacementNamed(context, RouteName.loginPage);
      }
    }

    return Form(
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
                  value, dataUser, _passController, user.user.email!),
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
        borderRadius: BorderRadius.circular(100),
        borderSide:
            const BorderSide(color: AppColors.kPrimaryLightColor, width: 5.0));
  }

  void showTogglePassWord() {
    setState(() {
      _showPass = !_showPass;
    });
  }
}
