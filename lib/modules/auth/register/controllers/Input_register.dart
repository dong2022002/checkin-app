import 'package:checkin_app/components/loginpage_component/button.dart';
import 'package:checkin_app/core/values/app_color.dart';
import 'package:checkin_app/core/values/app_style.dart';
import 'package:checkin_app/modules/auth/auth_provider/auth_provider.dart';
import 'package:checkin_app/modules/auth/register/controllers/validate_register.dart';
import 'package:checkin_app/route/route_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InputRegister extends StatefulWidget {
  const InputRegister({Key? key}) : super(key: key);

  @override
  State<InputRegister> createState() => _InputRegisterState();
}

class _InputRegisterState extends State<InputRegister> {
  bool _showPass = false;
  late final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  late String _userName, _password, _confirmPassword, _firstName, _lastName;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime _dateTime = DateTime(2002);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    void Function() action = (() {});
    String dob = "";
    void doRegister() async {
      final form = formKey.currentState;
      if (form!.validate()) {
        form.save();
        print(_userName);
        print(_password);
        dob = '${_dateTime.day}/${_dateTime.month}/${_dateTime.year}';
        await authProvider.postUser(
            _userName, _password, dob, _lastName, _firstName);
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
              controller: _userController,
              keyboardType: TextInputType.number,
              decoration: registerDecoration(label: "Tài khoản"),
              validator: (value) =>
                  ValidateRegister.userValidate(value!, _userController),
              onSaved: (value) => _userName = value!,
            ),
          ),
          Padding(
            padding: registerPadding().copyWith(top: 10),
            child: Row(children: [
              SizedBox(
                width: size.width * 0.4,
                child: TextFormField(
                  controller: _lastNameController,
                  decoration: registerDecoration(label: "Họ tên"),
                  validator: (value) => ValidateRegister.nameValidate(
                      value!, _lastNameController),
                  onSaved: (value) => _lastName = value!,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: SizedBox(
                  width: size.width * 0.36,
                  child: TextFormField(
                    controller: _firstNameController,
                    decoration: registerDecoration(label: "Tên"),
                    validator: (value) => ValidateRegister.nameValidate(
                        value!, _firstNameController),
                    onSaved: (value) => _firstName = value!,
                  ),
                ),
              ),
            ]),
          ),
          Padding(
            padding: registerPadding().copyWith(top: 10, bottom: 10),
            child: Container(
              alignment: Alignment.centerLeft,
              width: size.width * 0.8,
              height: size.height * 0.06,
              padding: EdgeInsets.only(left: size.width * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.calendar_month,
                      color: AppColors.kGreyText,
                    ),
                  ),
                  Text(
                    '${_dateTime.day}/${_dateTime.month}/${_dateTime.year}',
                    style: AppStyles.h5
                        .copyWith(color: Colors.black54, fontSize: 18),
                    //textAlign: TextAlign.center,
                  ),
                  Container(
                    width: size.width * 0.45,
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () async {
                        final date = await pickDate(context, _dateTime);
                        if (date == null) {
                          return;
                        } else {
                          setState(() => _dateTime = date);
                        }
                      },
                      icon: const Icon(Icons.create),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: AppColors.kPrimaryLightColor),
            ),
          ),
          Padding(
            padding: registerPadding(),
            child: TextFormField(
              controller: _passController,
              obscureText: !_showPass,
              decoration: passInputDecoration(label: "Mật khẩu"),
              validator: (value) =>
                  ValidateRegister.passValidate(value!, _userController),
              onSaved: (value) => _password = value!,
            ),
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: registerPadding(),
            child: TextFormField(
              controller: _confirmPassController,
              obscureText: !_showPass,
              decoration: passInputDecoration(label: "Mật khẩu xác nhận"),
              validator: (value) => ValidateRegister.confirmPassValidate(
                  value!, _confirmPassController, _passController),
              onSaved: (value) => _confirmPassword = value!,
            ),
          ),
          const SizedBox(height: 10.0),
          Button(text: 'Đăng ký', press: doRegister),
        ],
      ),
    );
  }

  EdgeInsets registerPadding() =>
      const EdgeInsets.only(top: 4, right: 8, left: 8);

  Future<DateTime?> pickDate(BuildContext context, DateTime _dateTime) {
    return showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(1900),
        lastDate: DateTime(2020));
  }

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

  InputDecoration registerDecoration({String label = ""}) {
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
