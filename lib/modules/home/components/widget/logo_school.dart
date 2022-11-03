import 'package:checkin_app/core/values/app_color.dart';
import 'package:flutter/material.dart';

class LogoSchool extends StatelessWidget {
  const LogoSchool({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Positioned(
        top: size.height * 0.45,
        left: size.width * 0.24,
        child: Image.asset(
          'assets/images/logo_dlu_1.png',
          height: size.height * 0.15,
          colorBlendMode: BlendMode.modulate,
          color: AppColors.kBackgroundColor.withOpacity(.4),
        ));
  }
}
