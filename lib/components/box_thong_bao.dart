import 'package:checkin_app/core/values/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BoxThongBao extends StatelessWidget {
  final String tittle;
  final IconData icon;
  final String textArlert;
  final VoidCallback onPress;
  const BoxThongBao({
    Key? key,
    required this.tittle,
    required this.icon,
    required this.textArlert,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(tittle, style: AppStyles.h4.copyWith(fontSize: 22)),
      content: Icon(
        icon,
        size: 42,
        color: Colors.blue,
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: onPress,
          child: Text(
            textArlert,
            style: AppStyles.h5.copyWith(fontSize: 22),
          ),
        )
      ],
    );
  }
}
