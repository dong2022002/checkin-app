import 'dart:convert';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:checkin_app/components/box_thong_bao.dart';
import 'package:checkin_app/core/values/app_color.dart';
import 'package:checkin_app/core/values/app_style.dart';
import 'package:checkin_app/models/lanDiemDanh.dart';
import 'package:checkin_app/modules/auth/auth_provider/auth_provider.dart';
import 'package:checkin_app/modules/auth/auth_provider/user_provider.dart';
import 'package:checkin_app/modules/checkin/checkin_provider/checkin_provider.dart';
import 'package:checkin_app/modules/checkin/checkin_provider/data_checkin.dart';
import 'package:checkin_app/modules/home/home_page.dart';
import 'package:checkin_app/modules/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  String qrCode = '';
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

  ///------VI Tri-----------
  Position? _position;
  var code = -1;
  var now = DateTime.now();

  Future<Position> _determinePosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Permissions are denied');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> _getCurrentLocation() async {
    Position position = await _determinePosition();
    setState(() {
      _position = position;
      if (!mounted) return;
    });
  }

  late bool _isLoading;
  @override
  void initState() {
    _isLoading = true;
    Provider.of<AuthProvider>(context, listen: false)
        .getChiDoan(UserProvider().user.chiDoanId!)
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
    return Consumer2<UserProvider, DataCheckin>(
        builder: ((context, user, checkin, child) {
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
            scanQrCode(user, checkin, context);
          },
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
    }));
  }

  Future<void> scanQrCode(
      UserProvider user, DataCheckin checkin, context) async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#5fa693', 'Cancel', true, ScanMode.QR);
      setState(() {
        this.qrCode = qrCode.isEmpty
            ? ''
            : qrCode == '-1'
                ? ''
                : qrCode;
      });

      if (qrCode.isNotEmpty && qrCode != '-1') {
        try {
          var jsonCode = jsonDecode(qrCode);
          code = jsonCode['suKienId'];
        } catch (e) {
          showDialog(
              context: context,
              builder: (context) {
                return BoxThongBao(
                  icon: Icons.error_outline,
                  onPress: () {
                    Navigator.pop(context);
                  },
                  tittle: 'Mã code không hợp lệ',
                  textArlert: 'Thử lại',
                );
              });
          return;
        }
        bool? isCheckin;
        try {
          CheckinProvider().getSuKienTheoID(code).whenComplete(() {
            isCheckin = checkin.event?.choPhepDoanVienKhacChiDoanThamGia;
            if (user.chiDoan.iD == checkin.event?.chiDoanId) {
              setDiemDanh(code, checkin, user);
            } else if (isCheckin!) {
              setDiemDanh(code, checkin, user);
            } else {
              showDialog(
                  context: context,
                  builder: (context) {
                    return BoxThongBao(
                      icon: Icons.error_sharp,
                      onPress: () {
                        Navigator.pop(context);
                      },
                      tittle:
                          'Sự kiện không cho phép đoàn viên khác chi đoàn tham gia',
                      textArlert: 'xác nhận',
                    );
                  });
            }
          });
        } catch (e) {
          showDialog(
              context: context,
              builder: (context) {
                return BoxThongBao(
                  icon: Icons.error_outline,
                  onPress: () {
                    Navigator.pop(context);
                  },
                  tittle: 'Mã code không tồn tại hoặc hết hạn',
                  textArlert: 'Thử lại',
                );
              });
          return;
        }
      }
    } on PlatformException {
      qrCode = 'Failed scan ';
    }
  }

  bool get dieuKienDiemDanh {
    return (_position != null && DataCheckin().dsLanDiemDanh.isNotEmpty);
  }

  void setDiemDanh(int code, DataCheckin checkin, UserProvider user) {
    CheckinProvider().getDanhSachLanDiemDanh(code);

    _getCurrentLocation().whenComplete(() {
      var list = checkin.dsLanDiemDanh;
      var now = DateTime.now();

      if (dieuKienDiemDanh) {
        LanDiemDanh lanDiemDanh = list.firstWhere(
          (e) => (e.thoiGianDong!.isAfter(now) && e.thoiGianMo!.isBefore(now)),
          orElse: () => LanDiemDanh(lanThu: -1),
        );
        if (lanDiemDanh.lanThu != -1) {
          CheckinProvider()
              .getDanhSachDiemDanhSK(user.user.chiDoanId, code, "all",
                  user.user.hoTen, user.user.mssv, user.user.dienThoai)
              .whenComplete(() {
            var listCheckin = checkin.dsDiemDanhSK;
            bool statusCheckin = false;
            for (var ck in listCheckin) {
              if (ck.suKienId == code && ck.lanDiemDanh == lanDiemDanh.lanThu) {
                statusCheckin = true;
                break;
              }
            }
            if (!statusCheckin) {
              CheckinProvider().postCheckinUser(
                  code, user.user.iD, _position!, lanDiemDanh.lanThu, context);
            } else {
              showDialog(
                  context: context,
                  builder: (context) {
                    return BoxThongBao(
                      icon: Icons.notifications,
                      onPress: () {
                        Navigator.pop(context);
                      },
                      tittle: 'Đã điểm danh rồi',
                      textArlert: 'Xác nhận',
                    );
                  });
            }
          });
        } else {
          showDialog(
              context: context,
              builder: (context) {
                return BoxThongBao(
                  icon: Icons.error_outline,
                  onPress: () {
                    Navigator.pop(context);
                  },
                  tittle: 'Không tìm thấy phiên điểm danh',
                  textArlert: 'Thử lại',
                );
              });
        }
      }
    });
    showDialog(
        context: context,
        builder: (context) {
          return BoxThongBao(
            icon: Icons.check_circle,
            onPress: () {
              Navigator.pop(context);
            },
            tittle: 'Đang xử lý dữ liệu xin chờ giây lát',
            textArlert: 'xác nhận',
          );
        });

    if (!mounted) return;
  }
}
