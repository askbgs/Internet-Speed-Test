import 'package:flutter/material.dart';

Color backgroundColor = const Color(0xff1B1A17);
Color progressBg = const Color(0xffE45826);
Color appBarColor = const Color(0xffF0A500);
Color txtCol = Colors.white;
Color needleColor = Color(0xffF0A500);
Color knopColor = Color(0xffF0A500);
Color downloadButton = Color(0xffE6D5B8);
Color uploadButton = Color(0xffF0A500);
Color shareButton = const Color(0xffE45826);
Color closebutton = Colors.red;

class MyThemes {
  static final darkTheme = ThemeData().copyWith(
    scaffoldBackgroundColor: backgroundColor,
    bottomAppBarColor: backgroundColor,
    primaryColor: Colors.white,
    primaryColorDark: const Color(0xffF0A500)
  );

  static final lightTheme = ThemeData().copyWith(
    scaffoldBackgroundColor: Colors.white,
    bottomAppBarColor: Colors.white,
    primaryColor: Colors.white,
    primaryColorDark: Colors.white
  );
}
