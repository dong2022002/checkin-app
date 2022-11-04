import 'package:checkin_app/components/icon_appbar.dart';
import 'package:checkin_app/components/title_appbar.dart';
import 'package:checkin_app/core/values/app_color.dart';
import 'package:checkin_app/core/values/app_style.dart';
import 'package:checkin_app/models/checkin.dart';
import 'package:checkin_app/modules/history_checkin/components/drawer/end_drawer_event.dart';
import 'package:checkin_app/modules/history_checkin/components/item_member.dart';
import 'package:flutter/material.dart';

class AdminListHistoryPage extends StatefulWidget {
  const AdminListHistoryPage({
    Key? key,
    required this.lanDiemDanh,
    required this.dsDiemDanhTrongChiDoan,
    required this.dsDiemDanhKhacChiDoan,
    required this.isInCheckin,
  }) : super(key: key);
  final int lanDiemDanh;
  final List<Checkin> dsDiemDanhTrongChiDoan;
  final List<Checkin> dsDiemDanhKhacChiDoan;
  final bool isInCheckin;

  @override
  State<AdminListHistoryPage> createState() => _AdminListHistoryPageState();
}

class _AdminListHistoryPageState extends State<AdminListHistoryPage> {
  late List<Checkin> _ds;
  @override
  void initState() {
    widget.isInCheckin
        ? _ds = widget.dsDiemDanhTrongChiDoan
        : _ds = widget.dsDiemDanhKhacChiDoan;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int _count = 0;
    Color _color;
    return Scaffold(
        endDrawer: EndDrawerEvent(
          listIn: widget.dsDiemDanhTrongChiDoan,
          listOut: widget.dsDiemDanhKhacChiDoan,
          lanDiemDanh: widget.lanDiemDanh,
        ),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
          backgroundColor: AppColors.kBackgroundColor,
          elevation: 0,
          leading: const IconAppBar(),
          title: TitleAppBar(
              size: size, tenSK: "Điểm danh lần ${widget.lanDiemDanh}"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: size.width,
              child: Column(
                children: [
                  ItemMember(
                    hoTen: 'Họ và tên',
                    mssv: 'MSSV',
                    stt: 'STT',
                    color: AppColors.kPrimaryColor.withOpacity(.8),
                  ),

                  SizedBox(
                    height: size.height * 0.8,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _ds.length,
                      itemBuilder: ((context, index) {
                        _count++;

                        (index % 2 == 0)
                            ? _color = Colors.white
                            : _color = AppColors.kPrimaryColor.withOpacity(.2);
                        return ItemMember(
                          stt: _count.toString(),
                          mssv: _ds[index].mssv!,
                          hoTen: _ds[index].hoTen!,
                          color: _color,
                        );
                      }),
                    ),
                  ),
                  // SizedBox(
                  //   height: size.height * 0.8,
                  //   child: ListView.builder(
                  //     shrinkWrap: true,
                  //     itemCount: 30,
                  //     itemBuilder: ((context, index) {
                  //       _count++;
                  //       (index % 2 == 0)
                  //           ? _color = Colors.white
                  //           : _color = AppColors.kPrimaryColor.withOpacity(.2);
                  //       index = 0;
                  //       return ItemMember(
                  //         stt: _count.toString(),
                  //         mssv: dsDiemDanh[index].mssv!,
                  //         hoTen: dsDiemDanh[index].hoTen!,
                  //         color: _color,
                  //       );
                  //     }),
                  //   ),
                  // ),
                  SizedBox(height: size.height * 0.01),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Tổng số sinh viên trong danh sách: " +
                          _ds.length.toString(),
                      style: AppStyles.h5,
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
