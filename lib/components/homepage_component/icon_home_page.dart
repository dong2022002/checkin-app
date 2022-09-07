import 'package:checkin_app/route/route_name.dart';
import 'package:flutter/material.dart';

class IconHomePage extends StatelessWidget {
  const IconHomePage({
    required this.icon,
    required this.text,
    Key? key,
  }) : super(key: key);
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
            iconSize: 32,
            onPressed: (() {
              Navigator.pushNamed(context, RouteName.historyCheckin);
            }),
            icon: Icon(icon)),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        )
      ],
    );
  }
}
