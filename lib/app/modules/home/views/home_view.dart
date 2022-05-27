import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:speedtest/app/components/parashow_dialog.dart';
import 'package:speedtest/app/components/progressbar.dart';
import 'package:speedtest/app/components/sfradial.dart';
import 'package:speedtest/app/components/showdialog.dart';
import 'package:speedtest/app/constants/color_plate.dart';
import 'package:speedtest/app/modules/history/views/history_view.dart';
import 'package:speedtest/app/routes/app_pages.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  final Progressbar progressBar = Progressbar();
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Para Internet Speed Test',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        elevation: 4.0,
        backgroundColor: Theme.of(context).primaryColorDark,
        //centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 4.0, left: 8.0),
            child: GestureDetector(
              onTap: () {
                Get.toNamed(Routes.HISTORY);
                // parashowDialog(0.5, 0.8, 'Mb/s', 'LK', 'LK', 'W', context);
                /* showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext contexy) {
                      return ParaShowDialoWindow(
                          downloadrate: 0.5,
                          uploadrate: 0.8,
                          unittest: 'Mb/s',
                          country: 'LK',
                          isp: 'LK',
                          mode: 'W');
                    });*/
              },
              child: Icon(
                Icons.history,
                size: 30.0,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () {
                Get.toNamed(Routes.SETTINGS);
              },
              child: Icon(
                Icons.settings,
                size: 30.0,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40.0,
                    child: Obx(() =>
                        controller.displayPer.value.toStringAsFixed(1) ==
                                '100.0'
                            ? progressBar.showbar(
                                100,
                                !controller.isDartkTheme.value
                                    ? Colors.white
                                    : backgroundColor,
                                !controller.isDartkTheme.value
                                    ? Colors.grey.withOpacity(0.6)
                                    : Color(0xffE45826),
                                !controller.isDartkTheme.value
                                    ? Colors.black
                                    : Color(0xffE45826),
                                !controller.isDartkTheme.value
                                    ? Colors.black
                                    : Colors.white)
                            : progressBar.showbar(
                                controller.displayPer.value,
                                !controller.isDartkTheme.value
                                    ? Colors.white
                                    : backgroundColor,
                                !controller.isDartkTheme.value
                                    ? Colors.grey.withOpacity(0.6)
                                    : Color(0xffE45826),
                                !controller.isDartkTheme.value
                                    ? Colors.black.withOpacity(0.2)
                                    : Color(0xffE45826),
                                !controller.isDartkTheme.value
                                    ? Colors.black
                                    : Colors.white)),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 30.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => Text(
                    "Download Speed: " +
                        controller.downloadRate1.value.toStringAsFixed(2) +
                        controller.unitText.value,
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: controller.isDartkTheme.value
                            ? Colors.white
                            : Colors.black),
                  ))
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => Text(
                    "Upload Speed: " +
                        controller.uploadRate1.value.toStringAsFixed(2) +
                        controller.unitText.value,
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: controller.isDartkTheme.value
                            ? Colors.white
                            : Colors.black),
                  ))
            ],
          ),
          SizedBox(
            height: 30.0,
          ),
          Obx(() => SfRadialGauge(
                title: GaugeTitle(
                  text: '',
                  textStyle: TextStyle(
                      color: controller.isDartkTheme.value
                          ? Colors.white
                          : Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                axes: <RadialAxis>[
                  RadialAxis(
                    minimum: 0,
                    maximum: 50,
                    axisLabelStyle: GaugeTextStyle(
                      color: !controller.isDartkTheme.value
                          ? Colors.black
                          : txtCol,
                    ),
                    ranges: [
                      GaugeRange(
                          startValue: 0,
                          endValue: 5,
                          color: Colors.green,
                          startWidth: 5,
                          endWidth: 5),
                      GaugeRange(
                          startValue: 5,
                          endValue: 10,
                          color: Colors.orange,
                          startWidth: 5,
                          endWidth: 5),
                      GaugeRange(
                          startValue: 10,
                          endValue: 15,
                          color: controller.isDartkTheme.value
                              ? Colors.grey
                              : Colors.white,
                          startWidth: 5,
                          endWidth: 5),
                      GaugeRange(
                          startValue: 15,
                          endValue: 20,
                          color: Colors.blue,
                          startWidth: 5,
                          endWidth: 5),
                      GaugeRange(
                          startValue: 20,
                          endValue: 25,
                          color: Colors.redAccent,
                          startWidth: 5,
                          endWidth: 5),
                      GaugeRange(
                          startValue: 25,
                          endValue: 30,
                          color: Colors.redAccent,
                          startWidth: 5,
                          endWidth: 5),
                      GaugeRange(
                          startValue: 30,
                          endValue: 35,
                          color: Colors.redAccent,
                          startWidth: 5,
                          endWidth: 5),
                      GaugeRange(
                          startValue: 35,
                          endValue: 40,
                          color: Colors.redAccent,
                          startWidth: 5,
                          endWidth: 5),
                      GaugeRange(
                          startValue: 40,
                          endValue: 45,
                          color: Colors.redAccent,
                          startWidth: 5,
                          endWidth: 5),
                      GaugeRange(
                          startValue: 45,
                          endValue: 50,
                          color: Colors.redAccent,
                          startWidth: 5,
                          endWidth: 5),
                    ],
                    annotations: [
                      controller.isDownloading.value
                          ? GaugeAnnotation(
                              widget: Container(
                                child: Text(
                                  controller.downloadRate1.value
                                          .toStringAsFixed(2) +
                                      ' ' +
                                      controller.unitText.value,
                                  style: TextStyle(
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold,
                                      color: !controller.isDartkTheme.value
                                          ? Colors.black
                                          : txtCol),
                                ),
                              ),
                              angle: 90.0,
                              positionFactor: 0.6,
                            )
                          : controller.isUploading.value
                              ? GaugeAnnotation(
                                  widget: Container(
                                    child: Text(
                                      controller.uploadRate1.value
                                              .toStringAsFixed(2) +
                                          ' ' +
                                          controller.unitText.value,
                                      style: TextStyle(
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.bold,
                                          color: !controller.isDartkTheme.value
                                              ? Colors.black
                                              : txtCol),
                                    ),
                                  ),
                                  angle: 90.0,
                                  positionFactor: 0.6,
                                )
                              : GaugeAnnotation(
                                  widget: Container(
                                    child: Text(
                                      controller.downloadRate.value
                                              .toStringAsFixed(2) +
                                          ' ' +
                                          controller.unitText.value,
                                      style: TextStyle(
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.bold,
                                          color: !controller.isDartkTheme.value
                                              ? Colors.black
                                              : txtCol),
                                    ),
                                  ),
                                  angle: 90.0,
                                  positionFactor: 0.6,
                                )
                    ],
                    pointers: [
                      controller.isDownloading.value
                          ? NeedlePointer(
                              knobStyle: KnobStyle(color: knopColor),
                              value: controller.displayPer.value
                                          .toStringAsFixed(1) ==
                                      '100.0'
                                  ? controller.downloadRate.value
                                  : controller.downloadRate1.value,
                              enableAnimation: true,
                              needleColor: needleColor,
                            )
                          : NeedlePointer(
                              knobStyle: KnobStyle(color: knopColor),
                              value: controller.displayPer.value
                                          .toStringAsFixed(1) ==
                                      '100.0'
                                  ? controller.uploadRate.value
                                  : controller.uploadRate1.value,
                              enableAnimation: true,
                              needleColor: needleColor,
                            )
                    ],
                  )
                ],
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(
                () => controller.isp.value.isEmpty
                    ? Text('No internet access',
                        style: TextStyle(
                            color: controller.isDartkTheme.value
                                ? Colors.white
                                : Colors.black))
                    : Text(
                        "ISP : " + controller.isp.value,
                        style: TextStyle(
                            color: controller.isDartkTheme.value
                                ? Colors.white
                                : Colors.black),
                      ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Obx(
                () => controller.isp.value.isEmpty
                    ? Container()
                    : Image.asset(
                        'assets/images/flags/${controller.countrycode}.png',
                        fit: BoxFit.cover,
                        scale: 3.5,
                      ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Obx(() => controller.netWorkType.value == 'W'
                  ? Icon(
                      FontAwesomeIcons.wifi,
                      size: 16.0,
                      color: controller.isDartkTheme.value
                          ? Colors.white
                          : Colors.black,
                    )
                  : controller.netWorkType.value == 'M'
                      ? Icon(
                          FontAwesomeIcons.signal,
                          size: 16.0,
                          color: controller.isDartkTheme.value
                              ? Colors.white
                              : Colors.black,
                        )
                      : controller.netWorkType.value == 'C'
                          ? Icon(
                              FontAwesomeIcons.networkWired,
                              size: 16.0,
                              color: controller.isDartkTheme.value
                                  ? Colors.white
                                  : Colors.black,
                            )
                          : Icon(
                              Icons.wifi_off_outlined,
                              size: 16.0,
                              color: controller.isDartkTheme.value
                                  ? Colors.white
                                  : Colors.black,
                            ))
            ],
          ),
          SizedBox(
            height: 40.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => controller.isDownloading.value ||
                      controller.isUploading.value
                  ? CircularProgressIndicator(
                      color: !controller.isDartkTheme.value
                          ? Colors.grey
                          : progressBg,
                    )
                  : ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all<double>(4.0),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              !controller.isDartkTheme.value
                                  ? Colors.white.withOpacity(0.6)
                                  : downloadButton),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(
                                          color: !controller.isDartkTheme.value
                                              ? Colors.white.withOpacity(0.6)
                                              : downloadButton)))),
                      onPressed: () {
                        !controller.isUploadStart.value
                            ? controller.netWorkType.value == 'N'
                                ? null
                                : controller.startDownloadTest()
                            : controller.netWorkType.value == 'N'
                                ? null
                                : controller.startUploadTest(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                            !controller.isUploadStart.value
                                ? 'Download Speed Test'
                                : 'Upload Speed Test',
                            style: TextStyle(
                                color: backgroundColor, fontSize: 16.0),
                          ),
                        ),
                      ),
                    ))
            ],
          ),
        ],
      )),
    );
  }
}
