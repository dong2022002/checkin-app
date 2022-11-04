import 'package:checkin_app/core/values/app_color.dart';
import 'package:checkin_app/core/values/app_style.dart';
import 'package:flutter/material.dart';

class TitleAppBar extends StatelessWidget {
  const TitleAppBar({
    Key? key,
    required this.size,
    required this.tenSK,
  }) : super(key: key);

  final Size size;
  final String tenSK;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(),
      padding: EdgeInsets.zero,
      width: size.width * 0.62,
      child: Text(
        tenSK,
        textAlign: TextAlign.center,
        style: AppStyles.h4.copyWith(
          fontSize: 24,
          color: AppColors.kPrimaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
