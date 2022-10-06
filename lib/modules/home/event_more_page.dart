import 'package:checkin_app/core/values/app_color.dart';
import 'package:checkin_app/core/values/app_style.dart';
import 'package:checkin_app/modules/auth/auth_provider/user_provider.dart';
import 'package:checkin_app/modules/history_checkin/history_checkin_provider.dart/DataHistoryCheckinProvider.dart';
import 'package:checkin_app/modules/history_checkin/history_checkin_provider.dart/HistoryChekinProvider.dart';
import 'package:checkin_app/modules/home/components/event_items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventMorePage extends StatelessWidget {
  const EventMorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer2<DataHistoryCheckinProvider, UserProvider>(
      builder: ((context, dataEvent, user, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Các sự kiện đã điểm danh'),
          ),
          body: SingleChildScrollView(
            child: FutureBuilder(
              future: HistoryChekinProvider()
                  .getcacSuKienDoanVienThamGia(user.user.iD),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (dataEvent.dsSuKienTheoDoanVien.isNotEmpty) {
                    //View
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      child: Column(
                        children: List.generate(
                            dataEvent.dsSuKienTheoDoanVien.length, (index) {
                          if (dataEvent.dsSuKienTheoDoanVien[index].chiDoanId !=
                              user.user.chiDoanId) {
                            //get ten Nhom
                            return FutureBuilder(
                              future: HistoryChekinProvider().getTenNhomSK(
                                  dataEvent.dsSuKienTheoDoanVien[index].nhomId),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return EventItems(
                                      tenNhomSK: dataEvent.tenNhom!.ten!,
                                      event: dataEvent
                                          .dsSuKienTheoDoanVien[index]);
                                } else {
                                  return const CircularProgressIndicator();
                                }
                              },
                            );
                          } else {
                            return Container();
                          }
                        }),
                      ),
                    );
                  } else {
                    return Container(
                      width: double.infinity,
                      height: size.height * 0.13,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(color: Colors.black26, blurRadius: 1)
                        ],
                        // border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text(
                          'Hiện không có sự kiện điểm danh khác chi đoàn',
                          style: AppStyles.h5.copyWith(
                            fontSize: 16,
                            color: AppColors.kGreyText,
                          ),
                        ),
                      ),
                    );
                  }
                } else {
                  return SizedBox(
                      width: double.infinity,
                      height: size.height * 0.2,
                      child: const Center(child: CircularProgressIndicator()));
                }
              }),
            ),
          ),
        );
      }),
    );
  }
}
