import 'package:checkin_app/core/values/app_style.dart';
import 'package:flutter/material.dart';

class NameHomePage extends StatelessWidget {
  const NameHomePage({
    Key? key,
    required this.name,
  }) : super(key: key);
  final String name;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
      child: Text(
        name,
        style: AppStyles.h5.copyWith(
            fontSize: 22,
            color: const Color(0xff0B4619).withOpacity(.8),
            fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }
}
