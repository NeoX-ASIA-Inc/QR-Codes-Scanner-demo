// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_codes_scanner_sample/models/icon_state_info.dart';
import 'package:qr_codes_scanner_sample/qr_code_scanner.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:path_provider/path_provider.dart';

import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

//HomePage: Giao diện màn hình chính của ứng dụng
//Bao gồm: Button Scan QR, các Icon 1. Icon 2, Button Youtube
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _IconState createState() => _IconState();
}

class _IconState extends State<HomePage> {
  late AppState appState;
  bool isIcon1Red = false;
  bool isIcon2Blue = false;

  //Hàm khởi tạo trạng thái của ứng dụng và được gọi duy nhất 1 lần
  //Sau này muốn thay đổi, cập nhập trạng thái của ứng dụng thì dùng hàm setState()
  //Action: Thực hiện load dữ liệu từ file json -> class appState
  @override
  void initState() {
    super.initState();

    loadAppStateFromJsonFile();
  }

  //Hàm đọc dữ liệu từ file json
  //Output: Đối tượng appState, trạng thái của icon 1, icon 2
  Future<void> loadAppStateFromJsonFile() async {
    try {
      // Đọc dữ liệu từ tệp JSON
      String jsonString =
          await rootBundle.loadString('assets/images/files/app_state.json');

      Map<String, dynamic> jsonData = jsonDecode(jsonString);

      // Tạo một đối tượng AppState từ dữ liệu JSON
      setState(() {
        appState = AppState.fromJson(jsonData);
        isIcon1Red = appState.isIcon1Red;
        isIcon2Blue = appState.isIcon2Blue;
      });
    } catch (e) {
      // Nếu có lỗi, sử dụng giá trị mặc định
      setState(() {
        appState = AppState(
          isIcon1Red: false,
          isIcon2Blue: false,
          isButtonEnabled: false,
        );
      });
      print('Error reading JSON file: $e');
    }
  }

//Xây dựng giao diện ứng dụng
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('QR Code Scanner Example')),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          //Thực hiện chuyển màn hình qua màn hình scan code
          //Nhận giá trị trả về returedValue khi mà màn hình QRScan pop()
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QRScan(),
                    )).then((returedValue) {
                  setState(() {
                    if (returedValue.toString() == 'red') {
                      isIcon1Red = true;
                    }
                    if (returedValue.toString() == 'blue') {
                      isIcon2Blue = true;
                    }
                  });
                });
                print("Scan button Pressed!");
              },
              child: Text('Scan QR')),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isIcon1Red == true
                  ? Icon(Icons.check_circle, color: Colors.red, size: 50.0)
                  : Icon(Icons.check_circle_outline,
                      color: Colors.grey, size: 50.0),
              SizedBox(
                height: 20.0,
              ),
              isIcon2Blue == true
                  ? Icon(Icons.check_circle, color: Colors.blue, size: 50.0)
                  : Icon(Icons.check_circle_outline,
                      color: Colors.grey, size: 50.0),
            ],
          ),
          ElevatedButton(
              onPressed: () {
                if (isIcon1Red && isIcon2Blue) {
                  _launchYouTubeLink();
                } else {
                  print('Khi 2 icon chuyen mau thi moi vao duoc link');
                }
              },
              child: Text("Youtube Link!"))
        ])));
  }

  _launchYouTubeLink() async {
    const url =
        'https://www.youtube.com'; // Đổi URL này thành đường link YouTube bạn muốn mở
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
