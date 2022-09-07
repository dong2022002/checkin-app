import 'package:checkin_app/modules/auth/auth_provider/user_provider.dart';
import 'package:checkin_app/modules/checkin/checkin_provider/data_checkin.dart';
import 'package:checkin_app/modules/history_checkin/components/event_item.dart';
import 'package:checkin_app/modules/history_checkin/history_checkin_provider.dart/DataHistoryCheckinProvider.dart';
import 'package:checkin_app/modules/history_checkin/history_checkin_provider.dart/HistoryChekinProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryCheckin extends StatefulWidget {
  const HistoryCheckin({Key? key}) : super(key: key);

  @override
  State<HistoryCheckin> createState() => _HistoryCheckinState();
}

class _HistoryCheckinState extends State<HistoryCheckin> {
  bool _isLoading = false;
  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    Provider.of<HistoryChekinProvider>(context, listen: false)
        .getDanhSachSK(UserProvider().user.chiDoanId)
        .then((_) {
      setState(() {
        _isLoading = false;
        if (!mounted) return;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(title: const Text("Lịch sử checkin")),
        body: Consumer<DataHistoryCheckinProvider>(
          builder: (context, historyCheckin, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.9,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: historyCheckin.tongSoSuKien,
                            itemBuilder: (context, index) {
                              return EventItem(
                                idSuKien: historyCheckin.dsSuKien[index].iD,
                                pathImage:
                                    historyCheckin.dsSuKien[index].anhChinh ??
                                        "assets/images/image_demo.jpeg",
                                headerText:
                                    historyCheckin.dsSuKien[index].tieuDe,
                                time: '10 phút trước',
                              );
                            },
                          ),
                        )
                      ],
                    ),
            );
          },
        ));
  }
}
