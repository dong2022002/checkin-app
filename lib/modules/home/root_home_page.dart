import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:checkin_app/core/values/app_color.dart';
import 'package:checkin_app/core/values/app_style.dart';
import 'package:checkin_app/modules/home/home_page.dart';
import 'package:checkin_app/modules/profile/profile_page.dart';
import 'package:checkin_app/route/route_name.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _bottomNavIndex = 0;
  List<Widget> pages = const [
    HomePage(),
    ProfilePage(),
  ];
  List<IconData> iconList = [
    Icons.home,
    Icons.person,
  ];
  List<String> titleList = <String>[
    'Trang chủ',
    'Thông tin cá nhân',
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(18),
          child: SizedBox(
            width: size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: size.width * 0.7,
                  child: Text(
                    titleList[_bottomNavIndex],
                    style: AppStyles.h4.copyWith(
                      color: AppColors.kPrimaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Icon(
                  Icons.notifications,
                  color: Colors.black.withOpacity(.7),
                  size: 30,
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: IndexedStack(
        index: _bottomNavIndex,
        children: pages,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          Navigator.pushNamed(context, RouteName.qrScanPage);
        }),
        child: Image.asset(
          'assets/images/scan.png',
          height: 30,
        ),
        backgroundColor: AppColors.kPrimaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
          splashColor: AppColors.kPrimaryColor,
          activeColor: AppColors.kPrimaryColor,
          inactiveColor: Colors.black54.withOpacity(0.5),
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.softEdge,
          icons: iconList,
          activeIndex: _bottomNavIndex,
          onTap: (index) {
            setState(() {
              _bottomNavIndex = index;
            });
          }),
    );
  }
}
