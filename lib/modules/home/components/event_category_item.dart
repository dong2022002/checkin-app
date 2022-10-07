import 'package:checkin_app/core/values/app_color.dart';
import 'package:checkin_app/core/values/app_style.dart';
import 'package:checkin_app/modules/history_checkin/history_checkin_provider.dart/DataHistoryCheckinProvider.dart';
import 'package:checkin_app/modules/history_checkin/history_checkin_provider.dart/HistoryChekinProvider.dart';
import 'package:checkin_app/modules/home/components/event_items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventCategoryItem extends StatefulWidget {
  const EventCategoryItem(
      {Key? key,
      required this.tenNhomSK,
      required this.idChiDoan,
      required this.idNhomSuKien,
      required this.isAdmin})
      : super(key: key);
  final bool isAdmin;
  final String tenNhomSK;
  final int idChiDoan;
  final int idNhomSuKien;
  @override
  State<EventCategoryItem> createState() => _EventCategoryItemState();
}

class _EventCategoryItemState extends State<EventCategoryItem> {
  late bool _isActive;
  late double _height;
  late int _idChiDoan;
  late int _idNhomSk;
  @override
  void initState() {
    _idChiDoan = widget.idChiDoan;
    _idNhomSk = widget.idNhomSuKien;
    _isActive = false;
    _height = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<DataHistoryCheckinProvider>(
      builder: ((context, dataEvent, child) {
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
            child: SafeArea(
              child: Column(children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.kPrimaryColor),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4),
                    ),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(2, 3))
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: size.width * 0.55,
                            child: RichText(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              text: TextSpan(
                                text: widget.tenNhomSK,
                                style: AppStyles.h5.copyWith(
                                  fontSize: 18,
                                  color: AppColors.kTextColor.withOpacity(.8),
                                ),
                              ),
                            )),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _isActive = !_isActive;
                              _isActive
                                  ? _height = size.height * 0.16
                                  : _height = 0;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                                color: AppColors.kPrimaryColor.withOpacity(.9),
                                borderRadius: BorderRadius.circular(0)),
                            child: Text(
                              'Chi tiết',
                              style: AppStyles.h5.copyWith(fontSize: 14),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    AnimatedContainer(
                      height: _height,
                      curve: Curves.linearToEaseOut,
                      duration: const Duration(seconds: 1),
                      child: SingleChildScrollView(
                        child: Container(
                            decoration: const BoxDecoration(
                              gradient: AppColors.kPrimaryLightGradient,
                            ),
                            child: FutureBuilder(
                              future: HistoryChekinProvider()
                                  .getDanhSachSK(_idChiDoan),
                              builder: ((context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  bool _coSuKien = false;
                                  for (var sk in dataEvent.dsSuKien) {
                                    if (_idNhomSk == sk.nhomId) {
                                      _coSuKien = true;
                                      break;
                                    }
                                  }
                                  if (_coSuKien) {
                                    return Column(
                                      children: List.generate(
                                          dataEvent.dsSuKien.length, (index) {
                                        if (dataEvent.dsSuKien[index].nhomId ==
                                            _idNhomSk) {
                                          ///
                                          return EventItems(
                                            tenNhomSK: widget.tenNhomSK,
                                            event: dataEvent.dsSuKien[index],
                                            isAdmin: widget.isAdmin,
                                          );
                                        } else {
                                          return Container();
                                        }
                                      }),
                                    );
                                  } else {
                                    return Container(
                                      width: double.infinity,
                                      height: size.height * 0.13,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: 1)
                                        ],
                                        // border: Border.all(color: Colors.blue),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Hiện không có sự kiện điểm danh',
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
                                      child: const Center(
                                          child: CircularProgressIndicator()));
                                }
                              }),
                            )),
                      ),
                    ),
                    _isActive
                        ? Divider(
                            height: 20,
                            thickness: 1.5,
                            color: AppColors.kGreyText.withOpacity(.5))
                        : Container()
                  ],
                )
              ]),
            ));
      }),
    );
  }
}
