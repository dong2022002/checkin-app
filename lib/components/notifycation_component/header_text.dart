import 'package:checkin_app/core/values/app_style.dart';
import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {
  const HeaderText({
    required this.text,
    Key? key,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppStyles.h5.copyWith(
        fontSize: 18,
      ),
    );
  }
}
