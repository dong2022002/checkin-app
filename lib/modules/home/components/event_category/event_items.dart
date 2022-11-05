import 'package:checkin_app/core/values/app_color.dart';
import 'package:checkin_app/core/values/app_style.dart';
import 'package:checkin_app/core/values/app_url/app_url.dart';
import 'package:checkin_app/models/event.dart';
import 'package:checkin_app/modules/home/components/widget/button_event.dart';
import 'package:checkin_app/route/route_name.dart';
import 'package:checkin_app/route/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image/flutter_image.dart';

class EventItems extends StatefulWidget {
  const EventItems({
    Key? key,
    required this.event,
    required this.tenNhomSK,
    required this.isAdmin,
  }) : super(key: key);
  final String tenNhomSK;
  final bool isAdmin;
  final Event event;

  @override
  State<EventItems> createState() => _EventItemsState();
}

class _EventItemsState extends State<EventItems> {
  var img;

  @override
  void initState() {
    img =
        // image: NetworkImageWithRetry(
        //     AppUrl.baseUrl + '/' + widget.event.anhChinh!),
        Image.network(
      "abc",
      fit: BoxFit.cover,
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) {
        return Image.asset('assets/images/no_image.png');
      },
    );

    super.initState();
  }

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
                        text: widget.event.tieuDe,
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
                              arguments: DetailHistoryCheckinAr(
                                  widget.event.iD!,
                                  widget.event.tieuDe!,
                                  widget.isAdmin));
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
                              context, RouteName.informationEventPage,
                              arguments: InfomationEventPageAr(widget.tenNhomSK,
                                  widget.event, widget.isAdmin));
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
            Expanded(child: img)
          ],
        ),
      ),
    );
  }
}
