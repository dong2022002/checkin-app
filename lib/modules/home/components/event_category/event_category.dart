import 'package:checkin_app/models/nhomSuKien.dart';
import 'package:checkin_app/modules/home/components/event_category/event_category_item.dart';
import 'package:flutter/material.dart';

class EventCategory extends StatelessWidget {
  const EventCategory(
      {Key? key,
      required this.dsNhomSK,
      required this.idChiDoan,
      required this.isAdmin})
      : super(key: key);
  final List<NhomSuKien> dsNhomSK;
  final int idChiDoan;
  final bool isAdmin;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: List.generate(
          dsNhomSK.length,
          (index) => EventCategoryItem(
                tenNhomSK: dsNhomSK[index].ten!,
                idChiDoan: idChiDoan,
                idNhomSuKien: dsNhomSK[index].iD!,
                isAdmin: isAdmin,
              )),
    ));
  }
}
