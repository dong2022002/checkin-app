import 'package:checkin_app/core/values/app_color.dart';
import 'package:checkin_app/core/values/app_style.dart';
import 'package:checkin_app/models/checkin.dart';
import 'package:checkin_app/route/route_name.dart';
import 'package:checkin_app/route/router.dart';
import 'package:flutter/material.dart';

class EndDrawerEvent extends StatelessWidget {
  const EndDrawerEvent({
    Key? key,
    required this.listIn,
    required this.listOut,
    required this.lanDiemDanh,
  }) : super(key: key);
  final List<Checkin> listIn;
  final List<Checkin> listOut;
  final int lanDiemDanh;
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
              text: 'Chi đoàn CTK44B',
              onPress: () {
                Navigator.pushReplacementNamed(
                    context, RouteName.adminListHistoryPage,
                    arguments: AdminListHistoryPageAR(
                        lanDiemDanh, listIn, listOut, true));
              },
            ),
            Divider(
              color: AppColors.kPrimaryColor.withOpacity(.5),
            ),
            ItemDrawer(
              size: size,
              icon: Icons.person,
              text: "Danh sách sinh viên khác chi đoàn",
              onPress: () {
                Navigator.pushReplacementNamed(
                    context, RouteName.adminListHistoryPage,
                    arguments: AdminListHistoryPageAR(
                        lanDiemDanh, listIn, listOut, false));
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
