import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:speedtest/app/constants/color_plate.dart';
import 'package:speedtest/app/routes/app_pages.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
            leading: GestureDetector(
              onTap: () => Get.offAllNamed(Routes.HOME),
              child: Icon(
                FontAwesomeIcons.arrowLeft,
                color: Colors.black,
              ),
            ),
            title: Text(
              'Settings',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Theme.of(context).primaryColorDark),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ListTile(
                trailing: Obx(() => Switch(
                      value: controller.isDartkTheme.value,
                      onChanged: (v) => controller.onChanged(v),
                      activeColor: Colors.orange,
                      inactiveThumbColor: Colors.white,
                    )),
                title: Obx(() => Text(
                      controller.isDartkTheme.value
                          ? 'Switch Off Dark Theme'
                          : 'Switch on Dark Theme',
                      style: TextStyle(
                          color: controller.isDartkTheme.value
                              ? Colors.white
                              : Colors.black),
                    )),
                subtitle: Obx(() => Text(
                      'You can change your theme in here',
                      style: TextStyle(
                          color: controller.isDartkTheme.value
                              ? Colors.white.withOpacity(0.4)
                              : Colors.black.withOpacity(0.4),
                          fontSize: 13.0),
                    )),
              ),
            ),
            ListTile(
              trailing: Obx(() => Switch(
                    value: controller.isAutoSave.value,
                    onChanged: (v) => controller.onAutoSaveChanged(v),
                    activeColor: Colors.orange,
                    inactiveThumbColor: Colors.white.withOpacity(0.6),
                    inactiveTrackColor: Colors.grey,
                  )),
              title: Obx(() => Text(
                    controller.isAutoSave.value
                        ? 'Auto Save On'
                        : 'Auto Save Off',
                    style: TextStyle(
                        color: controller.isDartkTheme.value
                            ? Colors.white
                            : Colors.black),
                  )),
              subtitle: Obx(() => Text(
                    'Auto save your spped test results ',
                    style: TextStyle(
                        color: controller.isDartkTheme.value
                            ? Colors.white.withOpacity(0.4)
                            : Colors.black.withOpacity(0.4),
                        fontSize: 13.0),
                  )),
            ),
          ],
        ));
  }
}
