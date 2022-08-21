import 'package:checkin_app/components/homepage_component/icon_home_page.dart';
import 'package:checkin_app/core/values/app_color.dart';
import 'package:checkin_app/core/values/app_style.dart';
import 'package:checkin_app/modules/auth/auth_provider/user_provider.dart';
import 'package:checkin_app/route/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String qrCode = '';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    UserProvider _userProvider = UserProvider();
    String department = "CTK44B";
    //   _userProvider.user.departmentId == 57 ? "CTK44A" : "CTK44B";
    return Scaffold(
      backgroundColor: AppColors.kPrimaryLightColor,
      body: Stack(
        children: [
          SafeArea(
            child: Container(
              margin: const EdgeInsets.all(16),
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.kPrimaryColor,
                  borderRadius: BorderRadius.circular(16)),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 28),
                    child: Text(
                      'Điểm danh'.toUpperCase(),
                      style: AppStyles.h4.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: SizedBox(
                      height: size.height * 0.2,
                      child: const Image(
                          image: AssetImage('assets/images/logo_dlu_2.png')),
                    ),
                  ),
                  Text(
                    "${_userProvider.user.hoTen}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      department,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            top: size.height * 0.6,
            bottom: 16,
            child: Container(
              // margin: const EdgeInsets.only(bottom: 16),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16))),

              child: Column(
                children: [
                  const Spacer(flex: 2),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        IconHomePage(icon: Icons.history, text: 'Lịch sử'),
                        IconHomePage(
                            icon: Icons.chat_bubble_outline,
                            text: 'Gửi phản ánh'),
                      ],
                    ),
                  ),
                  const Spacer(flex: 2),
                  const Divider(thickness: 1),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            iconSize: 32,
                            onPressed: (() {
                              Navigator.pushNamed(
                                  context, RouteName.notifacationPage);
                            }),
                            icon: const Icon(Icons.notifications_none)),
                        IconButton(
                          iconSize: 32,
                          icon: Image.asset('assets/images/menu.png'),
                          onPressed: () {
                            Navigator.pushNamed(context, RouteName.profilePage);
                          },
                        ),
                      ],
                    ),
                  ),
                  const Spacer(flex: 1)
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: size.height * 0.82,
            child: Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                color: AppColors.kPrimaryColor,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Image.asset(
                  'assets/images/scan.png',
                  height: size.height * 0.04,
                ),
                onPressed: () {
                  // Navigator.pushNamed(context, RouteName.qrScanPage);
                  scanQrCode();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> scanQrCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#5fa693', 'Cancel', true, ScanMode.QR);
      if (!mounted) return;
      setState(() {
        this.qrCode = qrCode.isEmpty
            ? ''
            : qrCode == '-1'
                ? ''
                : qrCode;
      });
      if (qrCode.isNotEmpty) {
        Navigator.pushNamed(
          context,
          RouteName.qrScanPage,
          arguments: qrCode,
        );
      }
    } on PlatformException {
      qrCode = 'Failed scan ';
    }
  }
}
