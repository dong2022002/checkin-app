import 'package:checkin_app/components/box_thong_bao.dart';
import 'package:checkin_app/core/values/app_color.dart';
import 'package:checkin_app/core/values/app_style.dart';
import 'package:checkin_app/core/values/app_url/app_url.dart';
import 'package:checkin_app/models/event.dart';
import 'package:checkin_app/modules/history_checkin/history_checkin_provider.dart/HistoryChekinProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_image/flutter_image.dart';

class InfomationEventPage extends StatefulWidget {
  const InfomationEventPage(
      {Key? key,
      required this.tenNhomSK,
      required this.event,
      required this.isAdmin})
      : super(key: key);
  final String tenNhomSK;
  final Event event;
  final bool isAdmin;
  @override
  State<InfomationEventPage> createState() => _InfomationEventPageState();
}

class _InfomationEventPageState extends State<InfomationEventPage> {
  // ignore: prefer_typing_uninitialized_variables
  var img;
  @override
  void initState() {
    try {
      img = Image(
        image: NetworkImageWithRetry(
            AppUrl.baseUrl + '/' + widget.event.anhChinh!),
        fit: BoxFit.cover,
        errorBuilder:
            (BuildContext context, Object exception, StackTrace? stackTrace) {
          return Image.asset('assets/images/no_image.png');
        },
      );
    } catch (e) {
      img = Image.asset('assets/images/no_image.png');
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
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
            widget.tenNhomSK,
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
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.82,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: Text(
                        widget.event.tieuDe!,
                        style: AppStyles.h4.copyWith(
                            color: AppColors.kTextColor.withOpacity(.65),
                            fontWeight: FontWeight.bold),
                        maxLines: 3,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                        height: size.height * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: img),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Nội dung",
                              textAlign: TextAlign.start,
                              style: AppStyles.h4.copyWith(
                                fontSize: 20,
                                color: AppColors.kGreyText,
                              ),
                            ),
                            InkWell(
                              onTap: (() {}),
                              child: Text(
                                "Link liên kết",
                                textAlign: TextAlign.start,
                                style: AppStyles.h4.copyWith(
                                  fontSize: 20,
                                  color: AppColors.kGreyText,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      color: AppColors.kGreyText,
                    ),
                    Html(
                      data: widget.event.noiDung!,
                      style: {
                        "p": Style(
                            fontSize: FontSize(16),
                            color: AppColors.kTextColor.withOpacity(.7))
                      },
                    )
                  ],
                ),
              ),
            ),
            const Divider(
              color: AppColors.kGreyText,
            ),
            DoanVienKhacChiDoanThamGia(
              isAdmin: widget.isAdmin,
              isCheckin: widget.event.choPhepDoanVienKhacChiDoanThamGia!,
              idSukien: widget.event.iD!,
            )
          ],
        ),
      ),
    );
  }
}

class DoanVienKhacChiDoanThamGia extends StatefulWidget {
  const DoanVienKhacChiDoanThamGia({
    Key? key,
    required this.isAdmin,
    required this.isCheckin,
    required this.idSukien,
  }) : super(key: key);

  final bool isAdmin;
  final bool isCheckin;
  final int idSukien;

  @override
  State<DoanVienKhacChiDoanThamGia> createState() =>
      _DoanVienKhacChiDoanThamGiaState();
}

class _DoanVienKhacChiDoanThamGiaState
    extends State<DoanVienKhacChiDoanThamGia> {
  late String text;
  late IconData iconData;
  late Color color;
  late bool isCheckin;
  @override
  void initState() {
    isCheckin = widget.isCheckin;
    getDataDoanVienKhacChiDoan(isCheckin);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            child: Text(
          text,
          style: AppStyles.h5.copyWith(
            fontSize: 14,
            color: color,
          ),
        )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: switchButton(context),
        ),
      ],
    );
  }

  Container switchButton(BuildContext context) {
    return Container(
      child: widget.isAdmin
          ? Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Switch(
                    value: isCheckin,
                    activeColor: AppColors.kPrimaryColor,
                    inactiveThumbColor: Colors.orange.withOpacity(.8),
                    onChanged: (value) {
                      HistoryChekinProvider()
                          .putChaneRightToParticipation(widget.idSukien, value)
                          .whenComplete(
                        () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return BoxThongBao(
                                    tittle: "Thay đổi thành công",
                                    icon: Icons.check_circle,
                                    textArlert: "xác nhận",
                                    onPress: () {
                                      Navigator.pop(context);
                                    });
                              });
                        },
                      );

                      setState(() {
                        isCheckin = !isCheckin;
                        getDataDoanVienKhacChiDoan(isCheckin);
                      });
                    }),
              ],
            )
          : Icon(
              iconData,
              color: color,
            ),
    );
  }

  void getDataDoanVienKhacChiDoan(bool isCheckin) {
    switch (isCheckin) {
      case true:
        setState(() {
          text = "Cho phép đoàn viên khác chi đoàn tham gia";
          iconData = Icons.check;
          color = AppColors.kPrimaryColor.withOpacity(.8);
        });

        break;
      case false:
        setState(() {
          text = "Không cho phép đoàn viên khác chi đoàn tham gia";
          iconData = Icons.cancel;
          color = Colors.orange.withOpacity(.8);
        });
        break;
      default:
    }
  }
}
