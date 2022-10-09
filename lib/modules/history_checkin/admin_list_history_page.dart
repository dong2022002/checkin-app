import 'package:checkin_app/components/icon_appbar.dart';
import 'package:checkin_app/components/title_appbar.dart';
import 'package:checkin_app/core/values/app_color.dart';
import 'package:checkin_app/core/values/app_style.dart';
import 'package:checkin_app/models/checkin.dart';
import 'package:flutter/material.dart';

class AdminListHistoryPage extends StatelessWidget {
  const AdminListHistoryPage(
      {Key? key, required this.lanDiemDanh, required this.dsDiemDanh})
      : super(key: key);
  final int lanDiemDanh;
  final List<Checkin> dsDiemDanh;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int _count = 0;
    Color _color;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.kBackgroundColor,
          elevation: 0,
          leading: const IconAppBar(),
          title: TitleAppBar(size: size, tenSK: "Điểm danh lần $lanDiemDanh"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              ItemMember(
                hoTen: 'Họ và tên',
                mssv: 'MSSV',
                stt: 'STT',
                color: AppColors.kPrimaryColor.withOpacity(.8),
              ),
              SingleChildScrollView(
                child: SizedBox(
                  height: size.height * 0.8,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: dsDiemDanh.length,
                    itemBuilder: ((context, index) {
                      _count++;
                      (index % 2 == 0)
                          ? _color = Colors.white
                          : _color = AppColors.kPrimaryColor.withOpacity(.2);
                      return ItemMember(
                          stt: _count.toString(),
                          mssv: dsDiemDanh[index].mssv!,
                          hoTen: dsDiemDanh[index].hoTen!,
                          color: _color);
                    }),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Tổng số sinh viên trong danh sách :" +
                      dsDiemDanh.length.toString(),
                  style: AppStyles.h5,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ));
  }
}

class ItemMember extends StatelessWidget {
  const ItemMember({
    Key? key,
    required this.stt,
    required this.mssv,
    required this.hoTen,
    required this.color,
  }) : super(key: key);
  final String stt;
  final String mssv;
  final String hoTen;
  final Color color;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
        decoration: BoxDecoration(color: color),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: size.width * 0.1,
              child: Text(
                stt,
                style: AppStyles.h5,
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            Text(
              mssv,
              style: AppStyles.h5.copyWith(
                color: AppColors.kTextColor.withOpacity(.8),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: size.width * 0.5,
              child: Text(
                hoTen,
                style: AppStyles.h5.copyWith(
                  color: AppColors.kTextColor.withOpacity(.7),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
