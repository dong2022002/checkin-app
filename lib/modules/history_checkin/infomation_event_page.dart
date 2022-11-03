import 'package:checkin_app/core/values/app_color.dart';
import 'package:checkin_app/core/values/app_style.dart';
import 'package:checkin_app/core/values/app_url/app_url.dart';
import 'package:checkin_app/models/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_image/flutter_image.dart';

class InfomationEventPage extends StatefulWidget {
  const InfomationEventPage(
      {Key? key, required this.tenNhomSK, required this.event})
      : super(key: key);
  final String tenNhomSK;
  final Event event;

  @override
  State<InfomationEventPage> createState() => _InfomationEventPageState();
}

class _InfomationEventPageState extends State<InfomationEventPage> {
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
              height: size.height * 0.85,
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
                        child: img

                        // child: Image.network(
                        //   AppUrl.baseUrl + '/123' + event.anhChinh!,
                        //   fit: BoxFit.cover,
                        //   errorBuilder: (BuildContext context, Object exception,
                        //       StackTrace? stackTrace) {
                        //     return Image.asset('assets/images/no_image.png');
                        //   },
                        // ),
                        ),
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
                            fontSize: const FontSize(16),
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
            widget.event.choPhepDoanVienKhacChiDoanThamGia!
                ? DoanVienKhacChiDoanThamGia(
                    color: AppColors.kPrimaryColor.withOpacity(.8),
                    iconData: Icons.check,
                    text: "Cho phép đoàn viên khác chi đoàn tham gia",
                  )
                : DoanVienKhacChiDoanThamGia(
                    text: "Không cho phép đoàn viên khác chi đoàn tham gia",
                    iconData: Icons.cancel,
                    color: Colors.orange.withOpacity(.8))
          ],
        ),
      ),
    );
  }
}

class DoanVienKhacChiDoanThamGia extends StatelessWidget {
  const DoanVienKhacChiDoanThamGia({
    Key? key,
    required this.text,
    required this.iconData,
    required this.color,
  }) : super(key: key);
  final String text;
  final IconData iconData;
  final Color color;

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
        Icon(
          iconData,
          color: color,
        )
      ],
    );
  }
}
