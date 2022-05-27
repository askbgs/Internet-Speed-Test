import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:speedtest/app/constants/color_plate.dart';

import 'app/routes/app_pages.dart';

void main() {
  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    GetMaterialApp(
      title: "PARA SPEED TEST",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      theme: MyThemes.lightTheme,
      darkTheme:MyThemes.darkTheme ,
      themeMode: ThemeMode.dark,
      getPages: AppPages.routes

    ),
  );
}
