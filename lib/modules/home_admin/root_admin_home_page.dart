import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:checkin_app/core/values/app_color.dart';
import 'package:checkin_app/core/values/app_style.dart';
import 'package:checkin_app/modules/auth/auth_provider/auth_provider.dart';
import 'package:checkin_app/modules/auth/auth_provider/user_provider.dart';
import 'package:checkin_app/modules/checkin/checkin_provider/data_checkin.dart';
import 'package:checkin_app/modules/history_checkin/history_checkin_provider.dart/DataHistoryCheckinProvider.dart';
import 'package:checkin_app/modules/home/home_page.dart';
import 'package:checkin_app/modules/home_admin/home_admin_page.dart';
import 'package:checkin_app/modules/profile/profile_admin_page.dart';
import 'package:checkin_app/modules/profile/profile_page.dart';
import 'package:checkin_app/route/route_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RootAdminPage extends StatefulWidget {
  const RootAdminPage({Key? key}) : super(key: key);

  @override
  State<RootAdminPage> createState() => _RootAdminPageState();
}

class _RootAdminPageState extends State<RootAdminPage> {
  String qrCode = '';
  int _bottomNavIndex = 0;
  List<Widget> pages = const [
    HomeAdminPage(),
    ProfileAdminPage(),
  ];
  List<IconData> iconList = [
    Icons.home,
    Icons.person,
  ];
  List<String> titleList = <String>[
    'Trang chủ',
    'Thông tin Chi Đoàn',
  ];

  ///------VI Tri-----------

  late bool _isLoading;
  @override
  void initState() {
    _isLoading = true;
    Provider.of<AuthProvider>(context, listen: false)
        .getChiDoanTheoAdmin(UserProvider().admin!.iD!)
        .then((_) {
      setState(() {
        _isLoading = false;
        if (!mounted) return;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer3<UserProvider, DataCheckin, DataHistoryCheckinProvider>(
        builder: ((context, user, checkin, event, child) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.kBackgroundColor,
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(18),
            child: SizedBox(
              width: size.width * 0.8,
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
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : IndexedStack(
                index: _bottomNavIndex,
                children: pages,
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, RouteName.createEventPage,
                arguments: event.dsNhomSuKien);
          },
          child: const Icon(
            Icons.add,
            color: AppColors.kPrimaryLightColor,
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
    }));
  }
}
