import 'package:checkin_app/core/values/app_color.dart';
import 'package:checkin_app/core/values/app_style.dart';
import 'package:flutter/material.dart';

class InfoItem extends StatelessWidget {
  const InfoItem({
    Key? key,
    required this.title,
    required this.text,
    required this.icon,
  }) : super(key: key);
  final String title;
  final String text;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.075,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black26.withOpacity(.3)),
        ),
        // color: Colors.white,
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Icon(
              icon,
              color: Colors.black26.withOpacity(.5),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppStyles.h6.copyWith(
                    fontSize: 14,
                    color: AppColors.kGreyText.withOpacity(.7),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  text,
                  style: AppStyles.h6.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.kTextColor.withOpacity(.8),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
