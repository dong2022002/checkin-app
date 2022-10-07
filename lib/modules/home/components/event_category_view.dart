import 'package:checkin_app/core/values/app_style.dart';
import 'package:checkin_app/modules/auth/auth_provider/user_provider.dart';
import 'package:checkin_app/modules/history_checkin/history_checkin_provider.dart/DataHistoryCheckinProvider.dart';
import 'package:checkin_app/modules/history_checkin/history_checkin_provider.dart/HistoryChekinProvider.dart';
import 'package:checkin_app/modules/home/components/event_category.dart';
import 'package:flutter/material.dart';

class EventCategoryView extends StatelessWidget {
  const EventCategoryView({
    Key? key,
    required this.user,
    required this.dataEvent,
    required this.isAdmin,
  }) : super(key: key);
  final bool isAdmin;
  final UserProvider user;
  final DataHistoryCheckinProvider dataEvent;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.575,
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              FutureBuilder(
                future: HistoryChekinProvider()
                    .getDanhSachNhomSK(user.chiDoan.parentId),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (dataEvent.dsNhomSuKien.isEmpty) {
                      return Center(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Hiện không có sự kiện điểm danh',
                          style: AppStyles.h5,
                        ),
                      ));
                    } else {
                      return EventCategory(
                        dsNhomSK: dataEvent.dsNhomSuKien,
                        idChiDoan: user.chiDoan.iD!,
                        isAdmin: isAdmin,
                      );
                    }
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
