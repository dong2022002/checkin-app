import 'dart:io';

import 'package:checkin_app/modules/auth/auth_provider/user_provider.dart';
import 'package:checkin_app/modules/checkin/checkin_provider/checkin_provider.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanPage extends StatefulWidget {
  const QRScanPage({Key? key}) : super(key: key);

  @override
  State<QRScanPage> createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  final CheckinProvider _checkinProvider = CheckinProvider();
  final UserProvider _userProvider = UserProvider();
  int eventID = 0;
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;
  get codeQR => barcode;
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text("Quét mã QR Demo"),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            buildQrView(context),
            Positioned(bottom: 100, child: buildResult()),
          ],
        ),
      ),
    );
  }

  // Widget hiển thị phần gợi ý và kết quả QR
  Widget buildResult() => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white24,
        ),
        child: Text(
          barcode != null
              ? 'Mã: ${barcode!.code}'
              : 'Di chuyển camera đến mã QR để quét!',
          maxLines: 1,
          style: const TextStyle(fontSize: 14, color: Colors.white),
        ),
      );

  // Widget khung quét QR
  Widget buildQrView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
            borderColor: Theme.of(context).cardColor,
            borderRadius: 10,
            borderLength: 20,
            borderWidth: 10,
            cutOutSize: MediaQuery.of(context).size.width * 0.8),
      );

  // State quét QR và lưu value
  void onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((barcode) {
      setState(() {
        this.barcode = barcode;
      });
      if (eventID == 0) {
        _checkinProvider.postCheckinUser(barcode.code, _userProvider.user.iD);
        eventID++;
        // } else {
        //   if (eventID.compareTo(barcode.code!) != 0) {
        //     _checkinProvider.postCheckinUser(
        //         barcode.code, _userProvider.user.iD);
        //   }
      }
    });
  }
}
