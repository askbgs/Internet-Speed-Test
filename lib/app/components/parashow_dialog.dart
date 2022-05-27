import 'dart:io';
import 'dart:typed_data';
import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:speedtest/app/components/sfradial.dart';
import 'package:speedtest/app/constants/color_plate.dart';
import 'dart:async';

class ParaShowDialoWindow extends StatefulWidget {
  ParaShowDialoWindow(
      {Key? key,
      required this.downloadrate,
      required this.uploadrate,
      this.unittest,
      this.isp,
      this.mode,
      this.country})
      : super(key: key);
  final double downloadrate;
  final double uploadrate;
  final dynamic unittest;
  final dynamic isp;
  final dynamic country;
  final dynamic mode;

  @override
  State<ParaShowDialoWindow> createState() => _ParaShowDialoWindowState();
}

class _ParaShowDialoWindowState extends State<ParaShowDialoWindow> {
  ScreenshotController screenshotController = ScreenshotController();
  late Uint8List _imageFile;

  _takeScreenshotandShare() async {
    screenshotController
        .capture(delay: const Duration(milliseconds: 10), pixelRatio: 2.0)
        .then((Uint8List? image) async {
      setState(() {
        _imageFile = image!;
      });
      Directory appDocDir = await getApplicationSupportDirectory();
      final directory = appDocDir.path;
      print(directory);
      File imgFile = new File('$directory/screenshot.png');
      imgFile.writeAsBytes(_imageFile);
      print("File Saved to Gallery");
      await Share.file('ParaSpeedTest', 'screenshot.png', _imageFile, 'image/png', text: 'ParaInternetSpeedtest');
    }).catchError((onError) {
      print(onError);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: backgroundColor,
      content: Screenshot(
        controller: screenshotController,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            width: 380,
            height: 345,
            color: backgroundColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Center(
                      child: Text(
                    'Test Results',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //download
                      Expanded(
                        child: Container(
                          width: 150,
                          height: 150,
                          child: SfRadialGraph(
                              title: 'Downlaod',
                              displayRate: widget.downloadrate,
                              unitText: 'Mb/s'),
                        ),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        child: Container(
                          width: 150,
                          height: 150,
                          child: SfRadialGraph(
                              title: 'Upload',
                              displayRate: widget.uploadrate,
                              unitText: 'Mb/s'),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 32.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'ISP Provider : ' + widget.isp,
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Text(
                            'Country : ' + widget.country,
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Text(
                            'Connection Mode : ' + widget.mode,
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 45,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all<double>(4.0),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(downloadButton),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: backgroundColor),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Close',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 45,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all<double>(4.0),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(shareButton),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: shareButton),
                        ),
                      ),
                    ),
                    onPressed: () {
                      _takeScreenshotandShare();
                    },
                    child: Text(
                      'Share',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
            ],
          ),
        )
      ],
    );
  }
}
