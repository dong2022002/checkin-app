import 'package:flutter/material.dart';

class MessageBox extends StatelessWidget {
  const MessageBox({
    required this.action,
    required this.title,
    required this.content,
    required this.button,
    Key? key,
  }) : super(key: key);
  final VoidCallback action;
  final String title;
  final String content;
  final String button;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        ElevatedButton(
          onPressed: action,
          child: Text(button),
        )
      ],
    );
  }
}
