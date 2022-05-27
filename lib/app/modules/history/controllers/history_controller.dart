import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speedtest/app/data/data_model.dart';
import 'package:speedtest/app/data/dbHelper.dart';

class HistoryController extends GetxController {
  //TODO: Implement HistoryController

  final count = 0.obs;
  RxBool isDartkTheme = true.obs;
  var isLoading = false.obs;
  var isChecked = false.obs;
  var isDelete = false.obs;
  var updated = 0.obs;
  var deleted = 0.obs;
  var selectedId = 0.obs;
  // var isCheckedList = [].obs;
  // List<bool> isCheckedList =[];
  final recordsList = <Datamodel>[].obs;
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  @override
  void onInit() {
    super.onInit();
    _getThemeStatus();
    listAllRecords();
    ever(updated, (_) => listAllRecords());
    ever(deleted, (_) => listAllRecords());
    print(recordsList.length);
    if (recordsList.isEmpty) {
      isDelete.value = false;
    }
    //isCheckedList.value = List<bool>.filled(recordsList.length, false);
  }

  @override
  void onReady() {
    super.onReady();
    isLoading.value = true;
    //listAllRecords();
    ever(updated, (_) => listAllRecords());
    ever(deleted, (_) => listAllRecords());
    isLoading.value = false;
    _getThemeStatus();
    if (recordsList.length == 0) {
      isDelete.value = false;
    }
  }

  _getThemeStatus() async {
    var _darkTheme = prefs.then((SharedPreferences prefs) {
      return prefs.getBool('theme') ?? true;
    }).obs;
    isDartkTheme.value = await _darkTheme.value;
    Get.changeThemeMode(isDartkTheme.value ? ThemeMode.dark : ThemeMode.light);
  }

  void listAllRecords() async {
    List<Map<String, dynamic>> records = await DBHelper.getAll();
    recordsList.clear();
    recordsList
        .assignAll(records.map((data) => Datamodel.fromJson(data)).toList());
   // update();
  }

  void updateRecord(int? id, int checked) async {
    await DBHelper.updateRecords(id, checked);
    //listAllRecords();
    updated++;
  }

  void deleteRecord(int? id) async {
    await DBHelper.deleteRecord(id);
   // listAllRecords();
    print("Recordlist : " + recordsList.length.toString());
    if (recordsList.length == 0) {
      isDelete.value = false;
    }
    deleted++;
  }

  void onCheck(val) async {
    isChecked.value = val;
    print(val);
    //Get.changeThemeMode(isDartkTheme.value ? ThemeMode.dark : ThemeMode.light);
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
