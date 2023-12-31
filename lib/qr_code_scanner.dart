// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

//Function: Thực hiện quyét QR cho ra kết quả result
class QRScan extends StatefulWidget {
  const QRScan({super.key});

  @override
  State<QRScan> createState() => _QRScanState();
}

class _QRScanState extends State<QRScan> {
  late QRViewController controller;
  Barcode? result;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        QRView(key: qrKey, onQRViewCreated: _onQRViewCreated),
        Align(
          alignment: Alignment.center,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2.0)),
          ),
        )
      ],
    ));
  }

  //Function: Đọc mã QR trả về result
  //Sau khi đọc xong, màn hình sẽ đóng lại chuyển về màn hình chính HomePage
  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((scanData) {
      result = scanData;
      dispose();

      Navigator.pop(context, result!.code.toString());
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }
}
