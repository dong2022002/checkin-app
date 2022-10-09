import 'package:checkin_app/components/icon_appbar.dart';
import 'package:checkin_app/components/title_appbar.dart';
import 'package:checkin_app/core/values/app_color.dart';
import 'package:checkin_app/core/values/app_style.dart';
import 'package:checkin_app/modules/auth/auth_provider/user_provider.dart';
import 'package:checkin_app/modules/checkin/checkin_provider/checkin_provider.dart';
import 'package:checkin_app/modules/checkin/checkin_provider/data_checkin.dart';
import 'package:checkin_app/modules/history_checkin/components/lan_diem_danh.dart';
import 'package:checkin_app/modules/history_checkin/components/status_checkin.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailHistoryCheckin extends StatefulWidget {
  const DetailHistoryCheckin(
      {Key? key,
      required this.idSuKien,
      required this.tenSk,
      required this.isAdmin})
      : super(key: key);
  final int idSuKien;
  final String tenSk;
  final bool isAdmin;
  @override
  State<DetailHistoryCheckin> createState() => _DetailHistoryCheckinState();
}

class _DetailHistoryCheckinState extends State<DetailHistoryCheckin> {
  late int id;
  late bool _isLoading;
  @override
  void initState() {
    _isLoading = true;
    id = widget.idSuKien;
    widget.isAdmin
        ?

        ///Admin !!!
        Provider.of<CheckinProvider>(context, listen: false)
            .getDanhSachDiemDanhSKAdmin(
            UserProvider().chiDoan.iD,
            id,
            'in',
          )
            .then((value) {
            setState(() {
              _isLoading = false;
              if (!mounted) return;
            });
          })
        :
        ////khong thuoc admin
        Provider.of<CheckinProvider>(context, listen: false)
            .getDanhSachDiemDanhSK(
                UserProvider().user.chiDoanId,
                id,
                'all',
                UserProvider().user.hoTen,
                UserProvider().user.mssv,
                UserProvider().user.dienThoai)
            .then((value) {
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

    return Consumer<DataCheckin>(builder: ((context, dataCheckin, child) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.kBackgroundColor,
            elevation: 0,
            leading: const IconAppBar(),
            title: TitleAppBar(size: size, tenSK: widget.tenSk),
          ),
          backgroundColor: AppColors.kBackgroundColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : FutureBuilder(
                        future: CheckinProvider().getDanhSachLanDiemDanh(id),
                        builder: ((context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Column(
                              children: List.generate(
                                  dataCheckin.tongSoLanDiemDanh, (index) {
                                return LanDiemDanhItem(
                                  lanDiemDanh:
                                      dataCheckin.dsLanDiemDanh[index].lanThu!,
                                  beginTime: dataCheckin
                                      .dsLanDiemDanh[index].thoiGianMo!,
                                  endTime: dataCheckin
                                      .dsLanDiemDanh[index].thoiGianDong!,
                                  lanDiemDanhSK:
                                      dataCheckin.dsLanDiemDanh[index],
                                  listCheckin: dataCheckin.dsDiemDanhSK,
                                  isAdmin: widget.isAdmin,
                                );
                              }),
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        }),
                      )),
          ));
    }));
  }
}
