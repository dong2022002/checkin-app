import 'package:flutter/material.dart';

class QrScanner extends StatelessWidget {
  final String qrCode;
  const QrScanner({Key? key, required this.qrCode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff313131),
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: const Text(
          "QR code",
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Scan Result',
            style: TextStyle(
                fontSize: 16,
                color: Colors.white54,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            '$qrCode',
            style: const TextStyle(
                fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 50),
        ],
      )),
    );
  }
}
