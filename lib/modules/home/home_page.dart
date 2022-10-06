import 'dart:convert';

import 'package:checkin_app/components/box_thong_bao.dart';
import 'package:checkin_app/core/values/app_color.dart';
import 'package:checkin_app/core/values/app_style.dart';
import 'package:checkin_app/models/lanDiemDanh.dart';
import 'package:checkin_app/modules/auth/auth_provider/user_provider.dart';
import 'package:checkin_app/modules/checkin/checkin_provider/checkin_provider.dart';
import 'package:checkin_app/modules/checkin/checkin_provider/data_checkin.dart';
import 'package:checkin_app/modules/history_checkin/history_checkin_provider.dart/DataHistoryCheckinProvider.dart';
import 'package:checkin_app/modules/history_checkin/history_checkin_provider.dart/HistoryChekinProvider.dart';
import 'package:checkin_app/modules/home/components/event_category.dart';
import 'package:checkin_app/modules/home/components/event_more.dart';
import 'package:flutter/material.dart';
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

  var user = UserProvider();
  @override
  void initState() {
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
              SingleChildScrollView(
                child: Column(
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 4),
                        child: Text(
                          '${user.user.hoTen}  -  ${user.chiDoan.ten}',
                          style: AppStyles.h5.copyWith(
                              fontSize: 22,
                              color: const Color(0xff0B4619).withOpacity(.8),
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
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
                                  hintText: "Tìm kiếm",
                                  border: InputBorder.none),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 16, left: 4, right: 4),
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
                      height: size.height * 0.575,
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
                    const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: EventMore(),
                    ),

                    const Divider(
                      color: AppColors.kPrimaryColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }));
  }
}
