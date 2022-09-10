import 'package:checkin_app/core/values/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static var header = GoogleFonts.roboto();

  static var h1 =
      header.copyWith(fontSize: 109.66, color: AppColors.kTextColor);
  static var h2 = header.copyWith(fontSize: 67.77, color: AppColors.kTextColor);
  static var h3 = header.copyWith(fontSize: 41.89, color: AppColors.kTextColor);
  static var h4 = header.copyWith(fontSize: 25.89, color: AppColors.kTextColor);
  static var h5 = header.copyWith(fontSize: 16, color: AppColors.kTextColor);
  static var h6 = header.copyWith(fontSize: 9.89, color: AppColors.kTextColor);
}
