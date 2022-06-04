import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'Scan BarCode & QRCode'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String scanresult = "";
  bool checkLineURL = false;
  bool checkFacebookURL = false;
  bool checkYoutubeURL = false;

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: SizedBox(
              height: 300,
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ผลการสแกน",
                        style: TextStyle(fontSize: 25),
                      ),
                      Text(
                        scanresult,
                        style: TextStyle(fontSize: 25),
                      ),
                      Spacer(), //เว้นระยะ
                      checkLineURL // เช็ค ถ้าจริง trueเขียนต่อท้าย ? แต่ถ้าเป็น false เขียนต่อท้าย :
                          ? SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                onPressed: () async{
                                  if(await canLaunchUrlString(scanresult)){
                                    await launchUrlString(scanresult);
                                  }

                                },
                                child: Text(
                                  "ติดตามผ่าน Line",
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: TextButton.styleFrom(
                                    backgroundColor:
                                        Color.fromARGB(255, 4, 92, 7)),
                              ),
                            )
                          : Container(),
                      Spacer(), //เว้นระยะ
                      checkFacebookURL // เช็ค ถ้าจริง trueเขียนต่อท้าย ? แต่ถ้าเป็น false เขียนต่อท้าย :
                          ? SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                 onPressed: () async{
                                  if(await canLaunchUrlString(scanresult)){
                                    await launchUrlString(scanresult);
                                  }

                                },
                                child: Text(
                                  "ติดตามผ่าน Facebook",
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: TextButton.styleFrom(
                                    backgroundColor:
                                        Color.fromARGB(255, 11, 13, 150)),
                              ),
                            )
                          : Container(),
                      Spacer(), //เว้นระยะ
                      checkYoutubeURL // เช็ค ถ้าจริง trueเขียนต่อท้าย ? แต่ถ้าเป็น false เขียนต่อท้าย :
                          ? SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                 onPressed: () async{
                                  if(await canLaunchUrlString(scanresult)){
                                    await launchUrlString(scanresult);
                                  }

                                },
                                child: Text(
                                  "ติดตามผ่านช่อง Youtube",
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: TextButton.styleFrom(
                                    backgroundColor:
                                        Color.fromARGB(255, 150, 11, 41)),
                              ),
                            )
                          : Container()
                    ],
                  ),
                ),
              )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: startScan,
        child: const Icon(Icons.qr_code_scanner_sharp),
      ),
    );
  }

  startScan() async {
    //อ่านข้อมูลจาก barcode และ qrcode
    String? cameraScanResult = await scanner.scan();
    setState(() {
      scanresult = cameraScanResult!;
    });
    if (scanresult.contains("line.me")) {
      checkLineURL = true;
    }else if(scanresult.contains("facebook.com")){
      checkFacebookURL = true;
    }else if(scanresult.contains("youtube.com")){
      checkYoutubeURL = true;
    }
  }
}
