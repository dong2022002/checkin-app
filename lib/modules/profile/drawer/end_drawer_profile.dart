import 'package:checkin_app/core/values/app_color.dart';
import 'package:checkin_app/core/values/app_style.dart';
import 'package:checkin_app/modules/auth/auth_provider/user_provider.dart';
import 'package:checkin_app/route/route_name.dart';
import 'package:flutter/material.dart';

class EndDrawerProfile extends StatelessWidget {
  const EndDrawerProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.kPrimaryLightColor,
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                "Danh sách",
                textAlign: TextAlign.center,
                style: AppStyles.h4.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.kPrimaryColor.withOpacity(.7),
                ),
              ),
            ),
            Divider(
              color: AppColors.kPrimaryColor.withOpacity(.5),
            ),
            ItemDrawer(
              size: size,
              icon: Icons.person,
              text: "Đoàn viên Chi đoàn " + UserProvider().chiDoan.ten!,
              onPress: () {
                Navigator.pushReplacementNamed(context, RouteName.listProfile,
                    arguments: 0);
              },
            ),
            Divider(
              color: AppColors.kPrimaryColor.withOpacity(.5),
            ),
            ItemDrawer(
              size: size,
              icon: Icons.person,
              text: "Đoàn viên đã kích hoạt tài khoản",
              onPress: () {
                Navigator.pushReplacementNamed(context, RouteName.listProfile,
                    arguments: 1);
              },
            ),
            Divider(
              color: AppColors.kPrimaryColor.withOpacity(.5),
            ),
            ItemDrawer(
              size: size,
              icon: Icons.person,
              text: "Đoàn viên chưa kích hoạt tài khoản",
              onPress: () {
                Navigator.pushReplacementNamed(context, RouteName.listProfile,
                    arguments: 2);
              },
            ),
            Divider(
              color: AppColors.kPrimaryColor.withOpacity(.5),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemDrawer extends StatelessWidget {
  const ItemDrawer({
    Key? key,
    required this.size,
    required this.icon,
    required this.text,
    required this.onPress,
  }) : super(key: key);

  final Size size;
  final IconData icon;
  final String text;
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
        child: Text(text),
      ),
      onTap: onPress,
    );
  }
}
