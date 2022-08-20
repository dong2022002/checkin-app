import 'package:checkin_app/core/values/app_color.dart';
import 'package:checkin_app/core/values/app_style.dart';
import 'package:flutter/material.dart';

class GreyTextDetail extends StatelessWidget {
  const GreyTextDetail({
    required this.text,
    Key? key,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppStyles.h6.copyWith(
        color: AppColors.kGreyText,
        fontSize: 18,
      ),
    );
  }
}
