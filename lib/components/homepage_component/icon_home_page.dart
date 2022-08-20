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
        IconButton(iconSize: 32, onPressed: (() {}), icon: Icon(icon)),
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
