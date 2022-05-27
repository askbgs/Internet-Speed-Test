import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:internet_speed_test/callbacks_enum.dart';
import 'package:internet_speed_test/internet_speed_test.dart';
import 'package:intl/intl.dart';
import 'package:ipapico_flutter/ipapico_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speedtest/app/components/parashow_dialog.dart';
import 'package:speedtest/app/components/showdialog.dart';
import 'package:speedtest/app/constants/color_plate.dart';
import 'package:speedtest/app/data/data_model.dart';
import 'package:speedtest/app/data/dbHelper.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  var downloadRate = 0.0.obs;
  var downloadRate1 = 0.0.obs;
  var uploadRate = 0.0.obs;
  var uploadRate1 = 0.0.obs;
  var dowloadProgress = '0'.obs;
  var uploadProgress = '0'.obs;
  Rx<double> displayPer = 0.0.obs;
  var unitText = 'Mb/s'.obs;
  var isDownloading = false.obs;
  var isDownloadStart = true.obs;

  var isUploading = false.obs;
  var isUploadStart = false.obs;
  var isAutoSave = false.obs;

  final internetSpeedTest = InternetSpeedTest();
  final ipApiData = IpApiData();
  var isp = ''.obs;
  var countrycode = ''.obs;
  var netWorkType = ''.obs;
  RxBool isDartkTheme = true.obs;

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() async {
    isDownloading.value = false;
    // _getThemeStatus();
    super.onInit();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    print("theme value is :" + isDartkTheme.value.toString());
  }

  _getThemeStatus() async {
    var _darkTheme = prefs.then((SharedPreferences prefs) {
      return prefs.getBool('theme') ?? true;
    }).obs;
    isDartkTheme.value = await _darkTheme.value;
    Get.changeThemeMode(isDartkTheme.value ? ThemeMode.dark : ThemeMode.light);
  }

  _getAutoSaveStatus() async {
    var _savemode = prefs.then((SharedPreferences prefs) {
      return prefs.getBool('save') ?? false;
    }).obs;
    isAutoSave.value = await _savemode.value;
    //Get.changeThemeMode(isDartkTheme.value ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
      print(result);
    } on PlatformException catch (e) {
      print('Couldn\'t check connectivity status' + e.toString());
      return;
    }
    _updateConnectionStatus(result);
  }

  Future<void> getIspInfo() async {
    IpApiResponse? response = await ipApiData.getIpApiData();
    isp.value = (response == null ? '' : response.org)!;
    countrycode.value =
        (response == null ? '' : response.countryCode?.toLowerCase())!;
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _connectionStatus = result;
    if (_connectionStatus == ConnectivityResult.wifi) {
      netWorkType.value = 'W';
      getIspInfo();
    } else if (_connectionStatus == ConnectivityResult.mobile) {
      netWorkType.value = 'M';
      getIspInfo();
    } else if (_connectionStatus == ConnectivityResult.ethernet) {
      netWorkType.value = 'C';
      getIspInfo();
    } else if (_connectionStatus == ConnectivityResult.none) {
      netWorkType.value = 'N';
      isp.value = '';
    } else {
      netWorkType.value = 'N';
    }

    //print(netWorkType.value);
  }

  @override
  void onReady() async {
    super.onReady();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _getThemeStatus();
    _getAutoSaveStatus();
  }

  void startDownloadTest() {
    downloadRate1.value = 0;
    uploadRate1.value = 0;
    internetSpeedTest.startDownloadTesting(
      onDone: (double transferRate, SpeedUnit unit) {
        downloadRate.value = 0;
        dowloadProgress.value = '100';
        unitText.value = unit == SpeedUnit.Kbps ? 'Kb/s' : 'Mb/s';
        displayPer.value = 100;
        isUploading.value = false;
        isDownloading.value = false;
        isUploadStart.value = true;
      },
      onProgress: (double percent, double transferRate, SpeedUnit unit) {
        //print("Speed unit "+ unit.toString());
        downloadRate1.value = transferRate;
        dowloadProgress.value = percent.toStringAsFixed(2);
        unitText.value = unit == SpeedUnit.Kbps ? 'Kb/s' : 'Mb/s';
        displayPer.value = percent;
        isDownloading.value = true;
        print("percent - " + percent.toString());
      },
      onError: (String errorMessage, String speedTestError) {
        isDownloading.value = false;
      },
      testServer: 'http://hgd-speedtest-1.tele2.net/1MB.zip',
      fileSize: 20000000,
    );
  }

  void startUploadTest(BuildContext context) {
    internetSpeedTest.startUploadTesting(
      onDone: (double transferRate, SpeedUnit unit) {
        uploadRate.value = 0;
        uploadProgress.value = '100';
        unitText.value = unit == SpeedUnit.Kbps ? 'Kb/s' : 'Mb/s';
        displayPer.value = 100;
        isDownloading.value = false;
        isUploading.value = false;
        isUploadStart.value = false;
        //check save mode on or not
        if (isAutoSave.value) {
          //Auto Save
          DateTime now = DateTime.now();
          String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(now);
          Datamodel dataModel = Datamodel(
              isp: isp.value,
              mode: netWorkType.value,
              downloadSpeed: downloadRate1.value.toStringAsFixed(2),
              uploadSpeed: uploadRate1.value.toStringAsFixed(2),
              createddate: formattedDate,
              updateddate: formattedDate,
              isChecked: 0);
          DBHelper.insertData(dataModel);
        }
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext contexy) {
              return ParaShowDialoWindow(
                  downloadrate: downloadRate1.value,
                  uploadrate: uploadRate1.value,
                  unittest: 'Mb/s',
                  country: countrycode.value,
                  isp: isp.value,
                  mode: netWorkType.value == 'W'
                      ? 'Wifi'
                      : netWorkType.value == 'M'
                          ? 'Mobile Data'
                          : netWorkType.value == 'C'
                              ? 'Ethernet'
                              : 'None');
            });
      },
      onProgress: (double percent, double transferRate, SpeedUnit unit) {
        uploadRate1.value = transferRate;
        uploadProgress.value = percent.toStringAsExponential(2);
        unitText.value = unit == SpeedUnit.Kbps ? 'Kb/s' : 'Mb/s';
        displayPer.value = percent;
        isUploading.value = true;
        print("percent - " + percent.toString());
      },
      onError: (String errorMessage, String speedTestError) {
        isUploading.value = false;
      },
      testServer: 'http://hgd-speedtest-1.tele2.net/upload.php',
      fileSize: 20000000,
    );
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
