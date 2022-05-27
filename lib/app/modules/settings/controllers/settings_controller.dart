import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController extends GetxController {
  //TODO: Implement SettingsController

  final count = 0.obs;
  RxBool isDartkTheme = true.obs;
  RxBool isAutoSave = false.obs;
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  @override
  void onInit() {
    super.onInit();
    // isDartkTheme.value = true;
    print(isDartkTheme.value);
  }

  _saveAutoSaveMode() async {
    SharedPreferences pref = await prefs;
    pref.setBool('save', isAutoSave.value);
  }

  _ssveThemeStatus() async {
    SharedPreferences pref = await prefs;
    pref.setBool('theme', isDartkTheme.value);
  }

  _getThemeStatus() async {
    var _darkTheme = prefs.then((SharedPreferences prefs) {
      return prefs.getBool('theme') ?? true;
    }).obs;
    isDartkTheme.value = await _darkTheme.value;
    Get.changeThemeMode(isDartkTheme.value ? ThemeMode.dark : ThemeMode.light);
  }

  @override
  void onReady() {
    super.onReady();
    // Get.changeThemeMode(isDartkTheme.value ? ThemeMode.dark : ThemeMode.light);
    //_ssveThemeStatus();
    _getThemeStatus();
    _getAutoSaveStatus();
  }

  void onChanged(val) async {
    isDartkTheme.value = val;
    print(val);
    Get.changeThemeMode(isDartkTheme.value ? ThemeMode.dark : ThemeMode.light);
    _ssveThemeStatus();
  }

  void onAutoSaveChanged(val) async {
    isAutoSave.value = val;
    print(val);
    //Get.changeThemeMode(isDartkTheme.value ? ThemeMode.dark : ThemeMode.light);
    _saveAutoSaveMode();
  }

  _getAutoSaveStatus() async {
    var _savemode = prefs.then((SharedPreferences prefs) {
      return prefs.getBool('save') ?? false;
    }).obs;
    isAutoSave.value = await _savemode.value;
    //Get.changeThemeMode(isDartkTheme.value ? ThemeMode.dark : ThemeMode.light);
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
