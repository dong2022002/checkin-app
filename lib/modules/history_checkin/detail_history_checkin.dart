import 'dart:math';

import 'package:checkin_app/models/checkin.dart';
import 'package:checkin_app/models/lanDiemDanh.dart';
import 'package:checkin_app/modules/auth/auth_provider/user_provider.dart';
import 'package:checkin_app/modules/checkin/checkin_provider/checkin_provider.dart';
import 'package:checkin_app/modules/checkin/checkin_provider/data_checkin.dart';
import 'package:checkin_app/modules/checkin/component/datetime_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailHistoryCheckin extends StatefulWidget {
  const DetailHistoryCheckin({Key? key, required this.idSuKien})
      : super(key: key);
  final int idSuKien;
  @override
  State<DetailHistoryCheckin> createState() => _DetailHistoryCheckinState();
}

class _DetailHistoryCheckinState extends State<DetailHistoryCheckin> {
  late int id;

  @override
  void initState() {
    id = widget.idSuKien;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text("Chi Tiết")),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Consumer2<UserProvider, DataCheckin>(
            builder: (context, user, data, child) {
              return Column(
                children: [
                  FutureBuilder(
                      future: CheckinProvider().getDanhSachLanDiemDanh(id),
                      builder: ((context, snapshot) {
                        return SizedBox(
                          height: size.height * 0.9,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: data.tongSoLanDiemDanh,
                            itemBuilder: (context, index) {
                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 16),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.blue, width: 2)),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Row(
                                    children: [
                                      Text('Lần ' +
                                          data.dsLanDiemDanh[index].lanThu
                                              .toString()),
                                      SizedBox(width: size.width * 0.03),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12),
                                        child: Column(
                                          children: [
                                            Text('thời gian mở: ' +
                                                DatetimeFormat.getDatetimeNow(
                                                        data
                                                            .dsLanDiemDanh[
                                                                index]
                                                            .thoiGianMo!)
                                                    .toString()),
                                            SizedBox(
                                                height: size.height * 0.02),
                                            Text('thời gian đóng: ' +
                                                DatetimeFormat.getDatetimeNow(
                                                    data.dsLanDiemDanh[index]
                                                        .thoiGianDong!)),
                                            Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12),
                                                child: FutureBuilder(
                                                  future: CheckinProvider()
                                                      .getDanhSachDiemDanhSK(
                                                          user.user.chiDoanId,
                                                          id,
                                                          "all",
                                                          user.user.hoTen,
                                                          user.user.mssv,
                                                          user.user.dienThoai),
                                                  builder: (context, snapshot) {
                                                    return StatusCheckin(
                                                      lanDiemDanh: data
                                                          .dsLanDiemDanh[index],
                                                      listCheckin:
                                                          data.dsDiemDanhSK,
                                                    );
                                                  },
                                                ))
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }))
                ],
              );
            },
          )),
    );
  }
}

class StatusCheckin extends StatelessWidget {
  const StatusCheckin({
    Key? key,
    required this.lanDiemDanh,
    this.listCheckin,
  }) : super(key: key);
  final LanDiemDanh? lanDiemDanh;
  final List<Checkin>? listCheckin;

  @override
  Widget build(BuildContext context) {
    bool kt = kiemTraDieuKien(lanDiemDanh, listCheckin);
    bool chuaDiemDanh = kiemTraDieuKien2(lanDiemDanh);
    if (!kt) {
      if (chuaDiemDanh) {
        return const Text('Chưa điểm danh');
      } else {
        return const Text('Vắng');
      }
    } else {
      return const Text('Đã điểm danh');
    }
  }

  bool kiemTraDieuKien(LanDiemDanh? lanDiemDanh, List<Checkin>? listCheckin) {
    bool statusCheckin = false;

    for (var ck in listCheckin!) {
      if (ck.suKienId == lanDiemDanh!.suKienId &&
          ck.lanDiemDanh == lanDiemDanh.lanThu) {
        statusCheckin = true;
        listCheckin.remove(ck);
        break;
      }
    }
    return statusCheckin;
  }

  bool kiemTraDieuKien2(LanDiemDanh? lanDiemDanh) {
    DateTime now = DateTime.now();

    if (lanDiemDanh!.thoiGianDong!.isAfter(now)) {
      return true;
    }
    return false;
  }
}
