import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_codes_scanner_sample/models/icon_state_info.dart';


class QRScan extends StatefulWidget {
  const QRScan({super.key, required IconStateInfo arguments});

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
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child:QRView(
              key: qrKey, 
              onQRViewCreated: _onQRViewCreated),
            ),
          Expanded(child: Center( 
            child: (result != null) ? Text('Data: ${result!.code}'): Text('Scan code'),
          ),)
          
          ],
      )
    );
  }

  void _onQRViewCreated(QRViewController controller){
    IconStateInfo? iconStateInfo;
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        if (result!.code == "red") {
          iconStateInfo?.isIcon1Red = true;
          dispose();
          
        }
        else if (result!.code == "blue") {
          iconStateInfo?.isIcon2Blue = true;
          dispose();
        }
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }
}
