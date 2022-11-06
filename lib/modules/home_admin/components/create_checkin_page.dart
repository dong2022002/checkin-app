import 'package:checkin_app/components/box_thong_bao.dart';
import 'package:checkin_app/components/button.dart';
import 'package:checkin_app/core/values/app_color.dart';
import 'package:checkin_app/core/values/app_style.dart';
import 'package:checkin_app/models/event.dart';
import 'package:checkin_app/models/lanDiemDanh.dart';
import 'package:checkin_app/models/nhomSuKien.dart';
import 'package:checkin_app/modules/checkin/checkin_provider/checkin_provider.dart';
import 'package:checkin_app/modules/checkin/checkin_provider/data_checkin.dart';
import 'package:checkin_app/modules/checkin/component/datetime_format.dart';
import 'package:checkin_app/modules/history_checkin/history_checkin_provider.dart/DataHistoryCheckinProvider.dart';
import 'package:checkin_app/modules/home_admin/home_admin_provider/home_admin_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({Key? key, required this.dsNhomSuKien})
      : super(key: key);
  final List<NhomSuKien> dsNhomSuKien;
  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  // ignore: prefer_typing_uninitialized_variables
  var selectedEventCategory;
  // ignore: prefer_typing_uninitialized_variables
  var selectedEvent;
  late int lanThu = 1;
  late DateTime now = DateTime.now();
  late DateTime dateBegin = now = now, dateEnd = now;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late List<DropdownMenuItem<String>> menuItemsEventCategory = [];
  late List<DropdownMenuItem<String>> menuItemsEvent = [];
  late List<Event> listEvent = [];
  @override
  void initState() {
    if (widget.dsNhomSuKien.isNotEmpty) {
      menuItemsEventCategory = widget.dsNhomSuKien
          .map((e) {
            return DropdownMenuItem<String>(
              child: Text(e.ten!),
              value: "${e.iD}",
            );
          })
          .cast<DropdownMenuItem<String>>()
          .toList();
      selectedEventCategory = "${widget.dsNhomSuKien.first.iD}";
      onSelect(selectedEventCategory);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    void doSwitchCreateEvent(idErorr) {
      switch (idErorr) {
        case 0:
          HomeAdminProvider().postCreateEvent(
              int.parse(selectedEvent),
              lanThu,
              DatetimeFormat.getDatetimeNow(dateBegin),
              DatetimeFormat.getDatetimeNow(dateEnd),
              context);
          break;
        case 1:
          showDialog(
              context: context,
              builder: (context) {
                return BoxThongBao(
                  icon: Icons.notification_important,
                  onPress: () {
                    Navigator.pop(context);
                  },
                  tittle:
                      'Thời gian kết thúc không được đặt trước thời gian bắt đầu',
                  textArlert: 'Tiếp tục',
                );
              });
          break;
        case 2:
          showDialog(
              context: context,
              builder: (context) {
                return BoxThongBao(
                  icon: Icons.notification_important,
                  onPress: () {
                    Navigator.pop(context);
                  },
                  tittle: 'Không có sự kiện để tạo điểm danh',
                  textArlert: 'Tiếp tục',
                );
              });
          break;
        case 3:
          showDialog(
              context: context,
              builder: (context) {
                return BoxThongBao(
                  icon: Icons.notification_important,
                  onPress: () {
                    Navigator.pop(context);
                  },
                  tittle:
                      'có lần diểm danh khác nằm trong khoảng thời gian đang thiết lập',
                  textArlert: 'Tiếp tục',
                );
              });
          break;
        case 4:
          showDialog(
              context: context,
              builder: (context) {
                return BoxThongBao(
                  icon: Icons.notification_important,
                  onPress: () {
                    Navigator.pop(context);
                  },
                  tittle: 'thời gian kết thúc nhỏ hơn thời gian hiện tại',
                  textArlert: 'Tiếp tục',
                );
              });
          break;

        default:
          HomeAdminProvider().postCreateEvent(
              int.parse(selectedEvent),
              lanThu,
              DatetimeFormat.getDatetimeNow(dateBegin),
              DatetimeFormat.getDatetimeNow(dateEnd),
              context);
          break;
      }
    }

    void doCreateEvent() async {
      List<LanDiemDanh> ds;
      CheckinProvider().getDanhSachLanDiemDanh(selectedEvent).whenComplete(() {
        ds = DataCheckin().dsLanDiemDanh;

        if (dateBegin.isAfter(dateEnd)) {
          doSwitchCreateEvent(1);
        } else if (selectedEvent == "-111") {
          doSwitchCreateEvent(2);
        } else if (dateEnd.isBefore(DateTime.now())) {
          doSwitchCreateEvent(4);
        } else {
          for (var lanDD in ds) {
            if ((lanDD.thoiGianDong!.isAfter(dateBegin) &&
                    lanDD.thoiGianMo!.isBefore(dateBegin)) ||
                (lanDD.thoiGianDong!.isAfter(dateEnd) &&
                    lanDD.thoiGianMo!.isBefore(dateEnd))) {
              doSwitchCreateEvent(3);
              return;
            }
          }
          doSwitchCreateEvent(0);
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.kBackgroundColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 26),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 28,
              color: AppColors.kPrimaryColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: SizedBox(
          width: size.width * 0.63,
          child: Text(
            "Tạo lần điểm danh",
            textAlign: TextAlign.center,
            style: AppStyles.h4.copyWith(
              fontSize: 24,
              color: AppColors.kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Form(
          // key: formKey,
          child: Column(children: [
            comboBoxEvent(
                menuItemsEventCategory, selectedEventCategory, onSelect),
            comboBoxEvent(menuItemsEvent, selectedEvent, onSelectEvent),
            lanThuSuKien(),
            const Divider(
              color: AppColors.kPrimaryColor,
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text("Thời gian bắt đầu",
                    style: AppStyles.h5.copyWith(
                      color: AppColors.kPrimaryColor,
                    )),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: size.width * 0.67,
                  decoration: stylesBox(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    child: Text(DatetimeFormat.getDMYTime(dateBegin)),
                  ),
                ),
                chonNgayThang(context, changeDateBegin, dateBegin),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: size.width * 0.67,
                  decoration: stylesBox(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    child: Text(DatetimeFormat.getTime(dateBegin)),
                  ),
                ),
                chonThoiGian(context, changeTimeBegin, dateBegin),
              ],
            ),
            Divider(
              height: size.height * 0.05,
              color: AppColors.kPrimaryColor,
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text("Thời gian Kết thúc",
                    style: AppStyles.h5.copyWith(
                      color: AppColors.kPrimaryColor,
                    )),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: size.width * 0.67,
                  decoration: stylesBox(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    child: Text(DatetimeFormat.getDMYTime(dateEnd)),
                  ),
                ),
                chonNgayThang(context, changeDateEnd, dateEnd),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: size.width * 0.67,
                  decoration: stylesBox(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    child: Text(DatetimeFormat.getTime(dateEnd)),
                  ),
                ),
                chonThoiGian(context, changeTimeEnd, dateEnd),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: Button(
                text: "Tạo điểm danh",
                press: doCreateEvent,
              ),
            )
          ]),
        ),
      ),
    );
  }

  TextButton chonThoiGian(
    BuildContext context,
    changeTime,
    DateTime time,
  ) {
    return TextButton(
        onPressed: () {
          DatePicker.showTimePicker(context,
              showTitleActions: true,
              onChanged: changeTime,
              onConfirm: changeTime,
              currentTime: time,
              locale: LocaleType.vi);
        },
        child: const Icon(Icons.alarm));
  }

  TextButton chonNgayThang(
    BuildContext context,
    changeTime,
    DateTime time,
  ) {
    return TextButton(
        onPressed: () {
          DatePicker.showDatePicker(context,
              showTitleActions: true,
              minTime: DateTime(2021, 1, 1, 0, 0, 0),
              maxTime: DateTime(2030, 1, 1, 0, 0, 0),
              onChanged: changeTime,
              onConfirm: changeTime,
              currentTime: time,
              locale: LocaleType.vi);
        },
        child: const Icon(Icons.calendar_month));
  }

  Padding lanThuSuKien() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
          decoration: stylesBox(),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Text(
              "Lần thứ " + lanThu.toString(),
              style: AppStyles.h5,
              textAlign: TextAlign.start,
            ),
          )),
    );
  }

  BoxDecoration stylesBox() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.kPrimaryColor, width: 2));
  }

  SizedBox comboBoxEvent(List<DropdownMenuItem<String>> menuItems,
      selectedValue, void Function(Object? value) onSelect) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: DropdownButtonFormField(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColors.kPrimaryColor, width: 2),
                borderRadius: BorderRadius.circular(4)),
            border: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColors.kPrimaryColor, width: 2),
                borderRadius: BorderRadius.circular(4)),
          ),
          isExpanded: true,
          items: menuItems,
          value: selectedValue,
          onChanged: onSelect,
        ),
      ),
    );
  }

  void onSelect(Object? value) {
    setState(() {
      selectedEventCategory = value! as String;
      try {
        listEvent.clear();

        for (var sk in DataHistoryCheckinProvider().dsSuKien) {
          if (sk.nhomId == int.parse(selectedEventCategory)) {
            listEvent.add(sk);
          }
        }
        menuItemsEvent.clear();

        if (listEvent.isNotEmpty) {
          menuItemsEvent = listEvent
              .map((e) {
                return DropdownMenuItem<String>(
                  child: Text(e.tieuDe!),
                  value: "${e.iD}",
                );
              })
              .cast<DropdownMenuItem<String>>()
              .toList();
          selectedEvent = "${listEvent.first.iD}";
          CheckinProvider()
              .getDanhSachLanDiemDanh(selectedEvent)
              .whenComplete(() {
            setState(() {
              lanThu = DataCheckin().tongSoLanDiemDanh + 1;
            });
          });
        } else {
          menuItemsEvent = [
            const DropdownMenuItem<String>(
              child: Text(""),
              value: "-111",
            ),
          ];
          selectedEvent = "-111";
          setState(() {
            lanThu = 0;
          });
        }
      } catch (e) {
        menuItemsEvent = [];
      }
    });
  }

  void onSelectEvent(Object? value) {
    setState(() {
      selectedEvent = value! as String;
    });
  }

  changeDateBegin(date) {
    setState(() {
      int hour = dateBegin.hour;
      int minutes = dateBegin.minute;
      int seconds = dateBegin.second;
      int year = date.year;
      int month = date.month;
      int day = date.day;

      dateBegin = DateTime(year, month, day, hour, minutes, seconds);
    });
  }

  changeDateEnd(date) {
    setState(() {
      int hour = dateEnd.hour;
      int minutes = dateEnd.minute;
      int seconds = dateEnd.second;
      int year = date.year;
      int month = date.month;
      int day = date.day;

      dateEnd = DateTime(year, month, day, hour, minutes, seconds);
    });
  }

  changeTimeBegin(date) {
    setState(() {
      dateBegin = date;
    });
  }

  changeTimeEnd(date) {
    setState(() {
      dateEnd = date;
    });
  }
}
