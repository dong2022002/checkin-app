import 'dart:convert';

import 'package:checkin_app/components/box_thong_bao.dart';
import 'package:checkin_app/components/grey_text.dart';
import 'package:checkin_app/components/homepage_component/icon_home_page.dart';
import 'package:checkin_app/core/values/app_color.dart';
import 'package:checkin_app/core/values/app_style.dart';
import 'package:checkin_app/models/lanDiemDanh.dart';
import 'package:checkin_app/modules/auth/auth_provider/auth_provider.dart';
import 'package:checkin_app/modules/auth/auth_provider/user_provider.dart';
import 'package:checkin_app/modules/checkin/checkin_provider/checkin_provider.dart';
import 'package:checkin_app/modules/checkin/checkin_provider/data_checkin.dart';
import 'package:checkin_app/modules/checkin/component/datetime_format.dart';
import 'package:checkin_app/modules/history_checkin/history_checkin_provider.dart/DataHistoryCheckinProvider.dart';
import 'package:checkin_app/modules/history_checkin/history_checkin_provider.dart/HistoryChekinProvider.dart';
import 'package:checkin_app/modules/home/components/button_event.dart';
import 'package:checkin_app/modules/home/components/event_category.dart';
import 'package:checkin_app/modules/home/components/event_items.dart';
import 'package:checkin_app/route/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CheckinProvider _checkinProvider = CheckinProvider();

  String qrCode = '';

  //lay vi tri location
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

  late bool _isActive;

  var user = UserProvider();
  @override
  void initState() {
    _isActive = true;

    Provider.of<AuthProvider>(context, listen: false)
        .getChiDoan(user)
        .then((_) {
      setState(() {
        _isActive = false;
      });
    });

    super.initState();
  }

  ///////////////////////// --location
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer2<UserProvider, DataHistoryCheckinProvider>(
        builder: ((context, user, dataEvent, child) {
      return Scaffold(
        backgroundColor: AppColors.kBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: Stack(
            children: [
              Positioned(
                  top: size.height * 0.45,
                  left: size.width * 0.24,
                  child: Image.asset(
                    'assets/images/logo_dlu_1.png',
                    height: size.height * 0.15,
                    colorBlendMode: BlendMode.modulate,
                    color: AppColors.kBackgroundColor.withOpacity(.4),
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: size.width * 0.8,
                    height: size.height * 0.075,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      // gradient: AppColors.kPrimaryGradient)
                      // border: Border.all(color: AppColors.kPrimaryColor),
                    ),
                    child: !_isActive
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 4),
                            child: Text(
                              '${user.user.hoTen} -  ${user.chiDoan.ten}',
                              style: AppStyles.h5.copyWith(
                                  fontSize: 22,
                                  color:
                                      const Color(0xff0B4619).withOpacity(.8),
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ))
                        : Container(),
                  ),
                  // SizedBox(height: size.height * 0.04),
                  Container(
                    height: size.height * 0.05,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.search)),
                        SizedBox(
                          width: size.width * 0.5,
                          child: const TextField(
                            decoration: InputDecoration(
                                hintText: "Tìm kiếm", border: InputBorder.none),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, left: 4, right: 4),
                    child: Text(
                      'Sự kiện liên chi đoàn',
                      style: AppStyles.h5.copyWith(
                        fontSize: 20,
                        color: AppColors.kPrimaryColor,
                      ),
                    ),
                  ),
                  const Divider(
                    color: AppColors.kPrimaryColor,
                  ),
                  SizedBox(
                    height: size.height * 0.6,
                    child: SingleChildScrollView(
                      child: SafeArea(
                        child: Column(
                          children: [
                            FutureBuilder(
                              future: HistoryChekinProvider()
                                  .getDanhSachNhomSK(user.chiDoan.parentId),
                              builder: ((context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  if (dataEvent.dsNhomSuKien.isEmpty) {
                                    return Center(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Hiện không có sự kiện điểm danh',
                                        style: AppStyles.h5,
                                      ),
                                    ));
                                  } else {
                                    return EventCategory(
                                      dsNhomSK: dataEvent.dsNhomSuKien,
                                      idChiDoan: user.chiDoan.iD!,
                                    );
                                  }
                                } else {
                                  return const CircularProgressIndicator();
                                }
                              }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    color: AppColors.kPrimaryColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }));

    // return Consumer2<UserProvider, DataCheckin>(
    //     builder: (context, user, checkin, child) {
    //   return Scaffold(
    //     backgroundColor: AppColors.kPrimaryLightColor,
    //     body: Stack(
    //       children: [
    //         SafeArea(
    //           child: Container(
    //             margin: const EdgeInsets.all(16),
    //             height: double.infinity,
    //             width: double.infinity,
    //             decoration: BoxDecoration(
    //                 color: AppColors.kPrimaryColor,
    //                 borderRadius: BorderRadius.circular(16)),
    //             child: Column(
    //               // crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Padding(
    //                   padding: const EdgeInsets.only(top: 28),
    //                   child: Text(
    //                     'Điểm danh'.toUpperCase(),
    //                     style: AppStyles.h4.copyWith(
    //                         fontWeight: FontWeight.bold, color: Colors.white),
    //                   ),
    //                 ),
    //                 Padding(
    //                   padding: const EdgeInsets.symmetric(vertical: 24),
    //                   child: SizedBox(
    //                     height: size.height * 0.2,
    //                     child: const Image(
    //                         image: AssetImage('assets/images/logo_dlu_2.png')),
    //                   ),
    //                 ),
    //                 Text(
    //                   "${user.user.hoTen}",
    //                   style: const TextStyle(
    //                       fontWeight: FontWeight.bold,
    //                       color: Colors.white,
    //                       fontSize: 20),
    //                 ),
    //                 user.chiDoan.ten == null
    //                     ? const Text("loading ...")
    //                     : Padding(
    //                         padding: const EdgeInsets.symmetric(vertical: 12),
    //                         child: Text(
    //                           "${user.chiDoan.ten}",
    //                           style: const TextStyle(
    //                               fontWeight: FontWeight.bold,
    //                               color: Colors.white,
    //                               fontSize: 18),
    //                         ),
    //                       )
    //               ],
    //             ),
    //           ),
    //         ),
    //         Positioned(
    //           left: 16,
    //           right: 16,
    //           top: size.height * 0.6,
    //           bottom: 16,
    //           child: Container(
    //             // fixx
    //             decoration: const BoxDecoration(
    //                 color: Colors.white,
    //                 borderRadius: BorderRadius.only(
    //                     bottomLeft: Radius.circular(16),
    //                     bottomRight: Radius.circular(16))),

    //             child: Column(
    //               children: [
    //                 const Spacer(flex: 2),
    //                 Padding(
    //                   padding: const EdgeInsets.symmetric(vertical: 18),
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                     children: [
    //                       IconHomePage(
    //                           icon: Icons.history,
    //                           text: 'Lịch sử',
    //                           onPress: () {
    //                             Navigator.pushNamed(
    //                                 context, RouteName.historyCheckin);
    //                           }),
    //                       IconHomePage(
    //                         icon: Icons.chat_bubble_outline,
    //                         text: 'Gửi phản ánh',
    //                         onPress: () {},
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 const Spacer(flex: 2),
    //                 const Divider(thickness: 1),
    //                 Padding(
    //                   padding: const EdgeInsets.symmetric(vertical: 8),
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                     children: [
    //                       IconButton(
    //                           iconSize: 32,
    //                           onPressed: (() {
    //                             //bug
    //                           }),
    //                           icon: const Icon(Icons.notifications_none)),
    //                       IconButton(
    //                         iconSize: 32,
    //                         icon: Image.asset('assets/images/menu.png'),
    //                         onPressed: () {
    //                           Navigator.pushNamed(
    //                               context, RouteName.profilePage);
    //                         },
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 const Spacer(flex: 1)
    //               ],
    //             ),
    //           ),
    //         ),
    //         Positioned(
    //           left: 0,
    //           right: 0,
    //           top: size.height * 0.82,
    //           child: Container(
    //             width: 60,
    //             height: 60,
    //             decoration: const BoxDecoration(
    //               color: AppColors.kPrimaryColor,
    //               shape: BoxShape.circle,
    //             ),
    //             child: IconButton(
    //               icon: Image.asset(
    //                 'assets/images/scan.png',
    //                 height: size.height * 0.04,
    //               ),
    //               onPressed: () {
    //                 scanQrCode(user, checkin, context);
    //               },
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
    // });
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
        var jsonCode = jsonDecode(qrCode);
        code = jsonCode['suKienId'];
        CheckinProvider().getDanhSachLanDiemDanh(code);
        _getCurrentLocation().whenComplete(() {
          var list = checkin.dsLanDiemDanh;
          var now = DateTime.now();

          if (dieuKienDiemDanh) {
            LanDiemDanh lanDiemDanh = list.firstWhere(
              (e) =>
                  (e.thoiGianDong!.isAfter(now) && e.thoiGianMo!.isBefore(now)),
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
                  if (ck.suKienId == code &&
                      ck.lanDiemDanh == lanDiemDanh.lanThu) {
                    statusCheckin = true;
                    break;
                  }
                }
                print(statusCheckin);
                if (!statusCheckin) {
                  _checkinProvider.postCheckinUser(code, user.user.iD,
                      _position!, lanDiemDanh.lanThu, context);
                } else {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return BoxThongBao(
                          icon: Icons.check_circle,
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
                      icon: Icons.check_circle,
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
    } on PlatformException {
      qrCode = 'Failed scan ';
    }
  }

  bool get dieuKienDiemDanh {
    return (_position != null && DataCheckin().dsLanDiemDanh.isNotEmpty);
  }
}
