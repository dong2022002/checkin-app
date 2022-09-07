import 'package:checkin_app/modules/history_checkin/components/event_item.dart';
import 'package:checkin_app/components/notifycation_component/header_text.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            'Thông báo'.toUpperCase(),
            style: const TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: 30,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: SizedBox(
            width: size.width,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const HeaderText(text: 'Mới nhất'),
                  const EventItem(
                    pathImage: 'assets/images/image_demo.jpeg',
                    headerText:
                        'Đăng ký tình nguyện viên tham gia show truyền hình thực tế "chuyến đi thanh xuân" của đài truyền hình HTV thành phố Hồ Chí Minh',
                    time: '10 phút trước',
                  ),
                  const HeaderText(text: 'Trước đó'),
                  SizedBox(
                    height: size.height * 0.62,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return EventItem(
                          pathImage: 'assets/images/image_demo.jpeg',
                          headerText:
                              '$index. Đăng ký tình nguyện viên tham gia show truyền hình thực tế "chuyến đi thanh xuân" của đài truyền hình HTV thành phố Hồ Chí Minh',
                          time: '10 phút trước',
                        );
                      },
                    ),
                  )
                ]),
          ),
        ));
  }
}
