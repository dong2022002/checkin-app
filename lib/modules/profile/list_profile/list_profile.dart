import 'package:checkin_app/components/icon_appbar.dart';
import 'package:checkin_app/components/title_appbar.dart';
import 'package:checkin_app/core/values/app_color.dart';
import 'package:checkin_app/core/values/app_style.dart';
import 'package:checkin_app/models/user.dart';
import 'package:checkin_app/modules/auth/auth_provider/user_provider.dart';
import 'package:checkin_app/modules/profile/drawer/end_drawer_profile.dart';
import 'package:checkin_app/modules/profile/profile_provider/data_profile.dart';
import 'package:checkin_app/modules/profile/profile_provider/profile_provider.dart';
import 'package:flutter/material.dart';

class ListProfile extends StatefulWidget {
  const ListProfile({Key? key, required this.indexMenu}) : super(key: key);
  final int indexMenu;
  @override
  State<ListProfile> createState() => _ListProfileState();
}

class _ListProfileState extends State<ListProfile> {
  late List<User> _ds;
  late bool _isLoading = true;
  @override
  void initState() {
    ProfileProvider()
        .getdataUserIdChiDoan(UserProvider().chiDoan.iD)
        .then((value) {
      setState(() {
        _isLoading = false;

        switch (widget.indexMenu) {
          case 0:
            _ds = DataProfile().dsDoanVienChiDoan;
            break;
          case 1:
            _ds = [];
            DataProfile().dsDoanVienChiDoan.map((e) {
              if (e.kichHoat!) {
                _ds.add(e);
              }
            }).toList();
            break;
          case 2:
            _ds = [];
            DataProfile().dsDoanVienChiDoan.map((e) {
              if (!e.kichHoat!) {
                _ds.add(e);
              }
            }).toList();
            break;
          default:
            _ds = [];
            DataProfile().dsDoanVienChiDoan.map((e) {
              if (e.kichHoat!) {
                _ds.add(e);
              }
            }).toList();
        }
        _ds.sort(((a, b) => a.hoTen!.compareTo(b.hoTen!)));
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int _count = 0;
    Color _color;
    return Scaffold(
        endDrawer: const EndDrawerProfile(),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
          backgroundColor: AppColors.kBackgroundColor,
          elevation: 0,
          leading: const IconAppBar(),
          title: TitleAppBar(
              size: size, tenSK: "Chi đoàn " + UserProvider().chiDoan.ten!),
        ),
        body: _isLoading
            ? const Center(
                child: SizedBox(
                    height: 50, width: 50, child: CircularProgressIndicator()),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: size.width,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ItemMemberProfile(
                            hoTen: ' Họ và tên',
                            mssv: 'MSSV',
                            stt: 'STT',
                            color: AppColors.kPrimaryColor.withOpacity(.8),
                            trangThai: 'Trạng thái',
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
                                    : _color =
                                        AppColors.kPrimaryColor.withOpacity(.2);
                                return ItemMemberProfile(
                                  stt: _count.toString(),
                                  mssv: _ds[index].mssv!,
                                  hoTen: _ds[index].hoTen!,
                                  color: _color,
                                  trangThai: _ds[index].kichHoat!.toString(),
                                );
                              }),
                            ),
                          ),
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
                ),
              ));
  }
}

class ItemMemberProfile extends StatelessWidget {
  const ItemMemberProfile({
    Key? key,
    required this.stt,
    required this.mssv,
    required this.hoTen,
    required this.color,
    required this.trangThai,
  }) : super(key: key);
  final String stt;
  final String mssv;
  final String hoTen;
  final Color color;
  final String trangThai;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {},
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: 14),
        decoration: BoxDecoration(color: color),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
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
              width: size.width * 0.35,
              child: Text(
                hoTen,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: AppStyles.h5.copyWith(
                  color: AppColors.kTextColor.withOpacity(.7),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            trangThai == "Trạng thái"
                ? SizedBox(
                    width: size.width * 0.2,
                    child: Text(
                      "Trạng thái",
                      style: AppStyles.h5.copyWith(
                        color: AppColors.kTextColor.withOpacity(.8),
                      ),
                    ),
                  )
                : trangThai == "true"
                    ? SizedBox(
                        width: size.width * 0.2,
                        child: Text(
                          "Đã kích hoạt",
                          style: AppStyles.h6.copyWith(
                            fontSize: 14,
                            color: AppColors.kTextColor.withOpacity(.7),
                          ),
                        ),
                      )
                    : SizedBox(
                        width: size.width * 0.2,
                        child: Text(
                          "Chưa kích hoạt",
                          style: AppStyles.h6.copyWith(
                            fontSize: 14,
                            color: Colors.orange.withOpacity(.8),
                          ),
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
