// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:qr_codes_scanner_sample/models/icon_state_info.dart';
import 'package:qr_codes_scanner_sample/qr_code_scanner.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
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
  late Icon_State_Info icon1State;
  late Icon_State_Info icon2State;
  late bool isButtonEnable;

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
          await rootBundle.loadString('assets/json/app_state.json');

      Map<String, dynamic> jsonData = jsonDecode(jsonString);

      // Tạo một đối tượng AppState từ dữ liệu JSON
      setState(() {
        icon1State = Icon_State_Info.fromJson(jsonData[1]);
        icon2State = Icon_State_Info.fromJson(jsonData[2]);
        isButtonEnable = false;
      });
    } catch (e) {
      // Nếu có lỗi, sử dụng giá trị mặc định
      setState(() {
        icon1State = Icon_State_Info(id: 1, name: '', scanned_status: false);
        icon2State = Icon_State_Info(id: 2, name: '', scanned_status: false);
        isButtonEnable = false;
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
              style: ElevatedButton.styleFrom(primary: Colors.cyan),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QRScan(),
                    )).then((returedValue) {
                  //Ham khoi tao lai trang thai ung dung
                  setState(() {
                    if (returedValue.toString() == 'red') {
                      icon1State.scanned_status = true;
                    }
                    if (returedValue.toString() == 'blue') {
                      icon2State.scanned_status = true;
                    }

                    if (icon1State.scanned_status &&
                        icon2State.scanned_status) {
                      isButtonEnable = true;
                    }
                  });
                });
                print("Scan button Pressed!");
              },
              child: Text('Scan QR')),
          SizedBox(
            height: 50.0,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon1State.scanned_status == true
                  ? Icon(Icons.check_circle, color: Colors.red, size: 150.0)
                  : Icon(Icons.check_circle_outline,
                      color: Colors.grey, size: 150.0),
              SizedBox(
                height: 100.0,
              ),
              icon2State.scanned_status == true
                  ? Icon(Icons.check_circle, color: Colors.blue, size: 150.0)
                  : Icon(Icons.check_circle_outline,
                      color: Colors.grey, size: 150.0),
            ],
          ),

          SizedBox(
            height: 50.0,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.green),
              onPressed: isButtonEnable
                  ? () {
                      _launchYouTubeLink();
                    }
                  : null,
              child: Text("Youtube Link!"))
        ])));
  }

  _launchYouTubeLink() async {
    const url =
        'https://youtu.be/pvGNVqu2Lwg?si=NaNgC0-oHK8ORAOk'; // Đổi URL này thành đường link YouTube
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
