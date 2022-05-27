import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:speedtest/app/constants/color_plate.dart';
import 'package:speedtest/app/modules/home/views/home_view.dart';

import '../controllers/splashscreen_controller.dart';

class SplashscreenView extends GetView<SplashscreenController> {
  @override
  Widget build(BuildContext context) {
    /* return EasySplashScreen(
       logoSize: 150,
       loaderColor: progressBg,
       durationInSeconds: 3,
       navigator: HomeView(),
       backgroundColor: backgroundColor,
        logo: Image.asset(
      'assets/images/PARA.png',
      fit: BoxFit.cover,
    ));*/
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Image.asset('assets/images/PARA.png'),
                    radius: 150,
                  ),
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(bottom: 25.0),
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color?>(progressBg)),
            ),
          )
        ],
      ),
    );
  }
}
