import 'package:checkin_app/core/values/app_color.dart';
import 'package:checkin_app/core/values/app_style.dart';
import 'package:flutter/material.dart';

class TimeBeginEnd extends StatelessWidget {
  const TimeBeginEnd({
    Key? key,
    required this.title,
    required this.time,
    required this.dateTime,
  }) : super(key: key);
  final String title;
  final String time;
  final String dateTime;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: AppStyles.h5.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.kTextColor.withOpacity(.7),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(dateTime,
              style: AppStyles.h5.copyWith(
                color: AppColors.kTextColor.withOpacity(.65),
              )),
        ),
        Text(
          time,
          style: AppStyles.h5.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.kTextColor.withOpacity(.95),
          ),
        ),
      ],
    );
  }
}
