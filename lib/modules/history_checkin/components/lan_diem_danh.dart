import 'package:checkin_app/core/values/app_color.dart';
import 'package:checkin_app/core/values/app_style.dart';
import 'package:checkin_app/modules/checkin/component/datetime_format.dart';
import 'package:checkin_app/modules/history_checkin/components/time_begin_end.dart';
import 'package:flutter/material.dart';

class LanDiemDanhItem extends StatefulWidget {
  const LanDiemDanhItem({
    Key? key,
    required this.lanDiemDanh,
    required this.beginTime,
    required this.endTime,
    required this.statusCheckin,
  }) : super(key: key);
  final DateTime beginTime;
  final DateTime endTime;
  final int lanDiemDanh;
  final int statusCheckin;

  @override
  State<LanDiemDanhItem> createState() => _LanDiemDanhState();
}

class _LanDiemDanhState extends State<LanDiemDanhItem> {
  late String _statusCheckin;
  late IconData _iconStatusCheckin;
  late Color _colorStatusCheckin;
  @override
  void initState() {
    switch (widget.statusCheckin) {
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                _statusCheckin,
                style: AppStyles.h5.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: _colorStatusCheckin,
                ),
              ),
            ),
            Icon(
              _iconStatusCheckin,
              color: _colorStatusCheckin,
            )
          ],
        ),
      ),
    );
  }
}
