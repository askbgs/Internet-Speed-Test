import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import 'package:speedtest/app/components/sfradial.dart';
import 'package:speedtest/app/constants/color_plate.dart';
import 'dart:io';

Future<dynamic> parashowDialog(
    double downloadrate,
    double uploadrate,
    String unittest,
    String isp,
    String country,
    String mode,
    BuildContext context) {
  ScreenshotController screenshotController = ScreenshotController();

  return Get.defaultDialog(
    title: 'Test Results',
    barrierDismissible: false,
    titleStyle: TextStyle(color: Colors.white),
    backgroundColor: backgroundColor,
    content: Screenshot(
      controller: screenshotController,
      child: Container(
        width: 400,
        height: 350,
        color: backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //download
                  Container(
                    width: 150,
                    height: 150,
                    child: SfRadialGraph(
                        title: 'Downlaod',
                        displayRate: downloadrate,
                        unitText: 'Mb/s'),
                  ),
                  Container(
                    width: 150,
                    height: 150,
                    child: SfRadialGraph(
                        title: 'Upload',
                        displayRate: uploadrate,
                        unitText: 'Mb/s'),
                  )
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'ISP Provider : ' + isp,
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
                        'Country : ' + country,
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
                        'Connection Mode : ' + mode,
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: backgroundColor),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Get.back();
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
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: shareButton),
                            ),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Share',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
