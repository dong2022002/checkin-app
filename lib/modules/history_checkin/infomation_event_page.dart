import 'package:checkin_app/core/values/app_color.dart';
import 'package:checkin_app/core/values/app_style.dart';
import 'package:checkin_app/core/values/app_url/app_url.dart';
import 'package:checkin_app/models/event.dart';
import 'package:flutter/material.dart';

class InfomationEventPage extends StatelessWidget {
  const InfomationEventPage(
      {Key? key, required this.tenNhomSK, required this.event})
      : super(key: key);
  final String tenNhomSK;
  final Event event;
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
            tenNhomSK,
            textAlign: TextAlign.center,
            style: AppStyles.h4.copyWith(
              fontSize: 24,
              color: AppColors.kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Text(
                  event.tieuDe!,
                  style: AppStyles.h4.copyWith(
                      color: AppColors.kTextColor.withOpacity(.65),
                      fontWeight: FontWeight.bold),
                  maxLines: 3,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              event.anhChinh!.isEmpty
                  ? Container()
                  : Container(
                      height: size.height * 0.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Image.network(
                        AppUrl.baseUrl + '/' + event.anhChinh!,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProcess) {
                          if (loadingProcess == null) {
                            return child;
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  event.noiDung!,
                  style: AppStyles.h5,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
