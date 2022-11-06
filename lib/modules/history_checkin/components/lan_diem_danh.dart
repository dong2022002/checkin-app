import 'package:checkin_app/core/values/app_color.dart';
import 'package:checkin_app/core/values/app_style.dart';
import 'package:checkin_app/models/checkin.dart';
import 'package:checkin_app/models/lanDiemDanh.dart';
import 'package:checkin_app/modules/auth/auth_provider/user_provider.dart';
import 'package:checkin_app/modules/checkin/checkin_provider/checkin_provider.dart';
import 'package:checkin_app/modules/checkin/checkin_provider/data_checkin.dart';
import 'package:checkin_app/modules/checkin/component/datetime_format.dart';
import 'package:checkin_app/modules/history_checkin/components/status_checkin.dart';
import 'package:checkin_app/modules/history_checkin/components/time_begin_end.dart';
import 'package:checkin_app/route/route_name.dart';
import 'package:checkin_app/route/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanDiemDanhItem extends StatefulWidget {
  const LanDiemDanhItem({
    Key? key,
    required this.lanDiemDanh,
    required this.beginTime,
    required this.endTime,
    required this.lanDiemDanhSK,
    required this.listCheckin,
    required this.isAdmin,
    required this.idSuKien,
  }) : super(key: key);
  final int idSuKien;
  final DateTime beginTime;
  final DateTime endTime;
  final int lanDiemDanh;
  final bool isAdmin;
  final LanDiemDanh lanDiemDanhSK;
  final List<Checkin> listCheckin;
  @override
  State<LanDiemDanhItem> createState() => _LanDiemDanhState();
}

class _LanDiemDanhState extends State<LanDiemDanhItem> {
  late String _statusCheckin;
  late IconData _iconStatusCheckin;
  late Color _colorStatusCheckin;
  late int _statusCheckinEvent;
  late bool _isAdmin;
  late bool _isLoading;
  @override
  void initState() {
    _isAdmin = widget.isAdmin;
    if (!_isAdmin) {
      _statusCheckinEvent =
          StatusCheckin.statusCheckin(widget.lanDiemDanhSK, widget.listCheckin);
      switch (_statusCheckinEvent) {
        case -1:
          _statusCheckin = "Vắng";
          _iconStatusCheckin = Icons.cancel;
          _colorStatusCheckin = Colors.red;
          break;
        case 0:
          _statusCheckin = "Chưa điểm danh";
          _iconStatusCheckin = Icons.today;
          _colorStatusCheckin = Colors.orange;
          break;
        case 1:
          _statusCheckin = "Đã điểm danh";
          _iconStatusCheckin = Icons.check_circle;
          _colorStatusCheckin = AppColors.kPrimaryColor;
          break;
        default:
      }
    } else {
      _isLoading = true;
      Provider.of<CheckinProvider>(context, listen: false)
          .getDanhSachDiemDanhSKAdmin(
        UserProvider().chiDoan.iD,
        widget.idSuKien,
        'out',
      )
          .then((value) {
        setState(() {
          _isLoading = false;
          if (!mounted) return;
        });
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Container(
        height: size.height * 0.2,
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 2)],
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Điểm danh lần ${widget.lanDiemDanh}',
                style: AppStyles.h5.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.kTextColor.withOpacity(.7),
                ),
              ),
            ),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TimeBeginEnd(
                    dateTime: DatetimeFormat.getDMYTime(widget.beginTime),
                    time: DatetimeFormat.getTime(widget.beginTime),
                    title: 'Thời gian bắt đầu',
                  ),
                  VerticalDivider(
                    color: Colors.black45.withOpacity(.2),
                    thickness: 1,
                  ),
                  TimeBeginEnd(
                    dateTime: DatetimeFormat.getDMYTime(widget.endTime),
                    time: DatetimeFormat.getTime(widget.endTime),
                    title: 'Thời gian kết thúc',
                  ),
                ],
              ),
            ),
            !_isAdmin
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      _statusCheckin,
                      style: AppStyles.h5.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _colorStatusCheckin,
                      ),
                    ),
                  )
                : Container(),
            !_isAdmin
                ? SizedBox(
                    width: size.width,
                    child: Icon(
                      _iconStatusCheckin,
                      color: _colorStatusCheckin,
                    ),
                  )
                : _isLoading
                    ? const CircularProgressIndicator()
                    : Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: AppColors.kPrimaryColor),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                List<Checkin> _listIn = <Checkin>[];
                                List<Checkin> _listOut = <Checkin>[];

                                widget.listCheckin.map((e) {
                                  if (e.lanDiemDanh == widget.lanDiemDanh) {
                                    _listIn.add(e);
                                  }
                                }).toList();
                                _listIn.sort(
                                    ((a, b) => a.hoTen!.compareTo(b.hoTen!)));
                                DataCheckin().dsDiemDanhSKKhacChiDoan.map((e) {
                                  if (e.lanDiemDanh == widget.lanDiemDanh) {
                                    _listOut.add(e);
                                  }
                                }).toList();
                                _listOut.sort(
                                    ((a, b) => a.hoTen!.compareTo(b.hoTen!)));
                                Navigator.pushNamed(
                                    context, RouteName.adminListHistoryPage,
                                    arguments: AdminListHistoryPageAR(
                                        widget.lanDiemDanh,
                                        _listIn,
                                        _listOut,
                                        true));
                              },
                              child: Text(
                                "Xem Danh Sách",
                                style: AppStyles.h5.copyWith(
                                  color: AppColors.kPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
          ],
        ),
      ),
    );
  }
}
