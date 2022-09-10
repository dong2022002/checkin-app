import 'package:checkin_app/core/values/app_style.dart';
import 'package:flutter/material.dart';

class ButtonEvent extends StatelessWidget {
  const ButtonEvent({
    Key? key,
    required this.text,
    required this.onPress,
    required this.boxDecoration,
  }) : super(key: key);

  final String text;
  final VoidCallback onPress;
  final BoxDecoration boxDecoration;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecoration,
      child: InkWell(
        onTap: onPress,
        child: SizedBox(
            child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            text,
            style: AppStyles.h6.copyWith(fontSize: 14),
          ),
        )),
      ),
    );
  }
}
