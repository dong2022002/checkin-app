import 'package:checkin_app/core/values/app_color.dart';
import 'package:checkin_app/core/values/app_style.dart';
import 'package:checkin_app/core/values/app_url/app_url.dart';
import 'package:checkin_app/modules/home/components/button_event.dart';
import 'package:checkin_app/route/route_name.dart';
import 'package:checkin_app/route/router.dart';
import 'package:flutter/material.dart';

class EventItems extends StatelessWidget {
  const EventItems({
    Key? key,
    this.tenSK,
    required this.pathImage,
    this.suKienID,
  }) : super(key: key);
  final String? tenSK;
  final String? pathImage;
  final int? suKienID;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        width: double.infinity,
        height: size.height * 0.1,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 1)],
          // border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 12, bottom: 8),
                  child: SizedBox(
                    width: size.width * 0.5,
                    child: RichText(
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: tenSK,
                        style: AppStyles.h5.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ButtonEvent(
                        onPress: () {
                          Navigator.pushNamed(
                              context, RouteName.detailHistoryCheckin,
                              arguments:
                                  DetailHistoryCheckinAr(suKienID!, tenSK!));
                        },
                        text: 'Xem điểm danh',
                        boxDecoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    AppColors.kPrimaryColor.withOpacity(.8))),
                      ),
                      ButtonEvent(
                        onPress: () {
                          Navigator.pushNamed(
                              context, RouteName.informationEventPage);
                        },
                        text: 'Thông tin',
                        boxDecoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(4),
                          color: Colors.black26.withOpacity(.2),
                          border: Border.all(
                            color: Colors.black26.withOpacity(.2),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: (pathImage != null)
                      ? DecorationImage(
                          image:
                              NetworkImage(AppUrl.baseUrl + '/' + pathImage!),
                          fit: BoxFit.cover)
                      : null,
                  // borderRadius: BorderRadius.circular(4)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
