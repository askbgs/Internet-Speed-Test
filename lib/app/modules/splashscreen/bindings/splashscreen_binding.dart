import 'package:get/get.dart';
import 'package:speedtest/app/modules/home/controllers/home_controller.dart';

import '../controllers/splashscreen_controller.dart';

class SplashscreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashscreenController());
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
