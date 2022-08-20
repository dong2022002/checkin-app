import 'package:checkin_app/core/values/app_style.dart';
import 'package:flutter/material.dart';

class HeaderTextDeTail extends StatelessWidget {
  const HeaderTextDeTail({
    required this.text,
    Key? key,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Text(
        text,
        style: AppStyles.h4.copyWith(fontWeight: FontWeight.w500),
      ),
    );
  }
}
