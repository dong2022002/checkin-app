import 'package:flutter/material.dart';

class AppColors {
  static const Color kPrimaryColor = Color(0xFF30ad4a);

  ///00c577
  static const Color kPrimaryLightColor = Color(0xFFffffff); //dfe3ef
  static const Color kBackgroundColor = Color(0xfff7fcf8); //f0f2f8
  static const Color kTextColor = Color(0xff121212);
  static const Color kGreyText = Color(0xffa0a3a9);
  static const kPrimaryGradient = LinearGradient(
    colors: [Color(0xFF94B49F), Color(0xFFFCF8E8)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static const kPrimaryLightGradient = LinearGradient(
    colors: [Color(0xFFf7fcf8), Color(0xfff5f5f5)],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  );
}
