import 'package:checkin_app/core/values/app_color.dart';
import 'package:checkin_app/core/values/app_style.dart';
import 'package:flutter/material.dart';

class ItemMember extends StatelessWidget {
  const ItemMember({
    Key? key,
    required this.stt,
    required this.mssv,
    required this.hoTen,
    required this.color,
  }) : super(key: key);
  final String stt;
  final String mssv;
  final String hoTen;
  final Color color;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
        decoration: BoxDecoration(color: color),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: size.width * 0.1,
              child: Text(
                stt,
                style: AppStyles.h5,
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            Text(
              mssv,
              style: AppStyles.h5.copyWith(
                color: AppColors.kTextColor.withOpacity(.8),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: size.width * 0.5,
              child: Text(
                hoTen,
                style: AppStyles.h5.copyWith(
                  color: AppColors.kTextColor.withOpacity(.7),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
