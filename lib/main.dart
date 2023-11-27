// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_codes_scanner_sample/models/icon_state_info.dart';
import 'package:qr_codes_scanner_sample/qr_code_scanner.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Code Scan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       appBar: AppBar(
  //         title: Text('QR Code scan'),
  //       ),
  //       body: Center(
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             ElevatedButton(
  //                 onPressed: () {
  //                   Navigator.push(context,
  //                       MaterialPageRoute(builder: (context) => QRScan(arguments: null,)));
  //                   print("Scan button Pressed!");
  //                 },
  //                 child: Text('Scan QR')),
  //             Row(mainAxisAlignment: MainAxisAlignment.center, children: [
  //               SvgPicture.asset(
  //                 'assets/icons/check-circle-regular.svg',
  //                 height: 100,
  //                 width: 100,
  //               ),
  //               SizedBox(
  //                 width: 20,
  //               ),
  //               SvgPicture.asset('assets/icons/check-circle-regular.svg',
  //                   height: 100, width: 100),
  //             ]),
  //             SizedBox(
  //               height: 20,
  //             ),
  //             ElevatedButton(
  //                 onPressed: () {
  //                   print("Button Press");
  //                 },
  //                 child: Text("Press Me!"))
  //           ],
  //         ),
  //       ));
  // }

  @override
  State<StatefulWidget> createState() => _IconState();
}

class _IconState extends State<HomePage> {
  IconStateInfo? iconStateInfo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('QR Code Scanner Example')),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(
                      builder: (context) => QRScan( 
                      arguments: IconStateInfo( 
                        isIcon1Red: iconStateInfo!.isIcon1Red,
                        isIcon2Blue: iconStateInfo!.isIcon2Blue,
                        isButtonEnabled: iconStateInfo!.isButtonEnabled
                      ),
                    )));
                print("Scan button Pressed!");
              },
              child: Text('Scan QR')),
          Row(
            children: [
              iconStateInfo!.isIcon1Red
                  ? Icon(Icons.check_circle, color: Colors.red, size: 50.0)
                  : Icon(Icons.check_circle_outline,
                      color: Colors.grey, size: 50.0),
              SizedBox(
                height: 20.0,
              ),
              iconStateInfo!.isIcon2Blue
                  ? Icon(Icons.check_circle, color: Colors.blue, size: 50.0)
                  : Icon(Icons.check_circle_outline,
                      color: Colors.grey, size: 50.0),
            ],
          ),
          ElevatedButton(
              onPressed: () {
                print("Button Press");
              },
              child: Text("Youtube Link!"))
        ])));
  }
}
