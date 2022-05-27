import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:speedtest/app/components/shimmer.dart';
import 'package:speedtest/app/constants/color_plate.dart';
import 'package:speedtest/app/data/data_model.dart';
import 'package:speedtest/app/routes/app_pages.dart';

import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColorDark,
          leading: GestureDetector(
            onTap: () => Get.offAllNamed(Routes.HOME),
            child: Icon(
              FontAwesomeIcons.arrowLeft,
              color: Colors.black,
            ),
          ),
          title: Text(
            'Records',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: GestureDetector(
                onTap: () {
                  //Get.toNamed(Routes.HISTORY);
                  Get.defaultDialog(
                    title: 'Confirm?',
                    titlePadding: EdgeInsets.symmetric(vertical: 10.0),
                    titleStyle: TextStyle(
                        color: controller.isDartkTheme.value
                            ? Colors.white
                            : Colors.black),
                    backgroundColor: controller.isDartkTheme.value
                        ? backgroundColor
                        : Colors.white,
                    buttonColor: Colors.orange,
                    contentPadding: EdgeInsets.all(8.0),
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            'Are you want to delete select or selected records?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: controller.isDartkTheme.value
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                      ],
                    ),
                    confirm: TextButton(
                      onPressed: () {
                        controller.deleteRecord(controller.selectedId.value);
                        Get.back();
                      },
                      child: Text(
                        'Yes',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.orange),
                          elevation: MaterialStateProperty.all(3.0)),
                    ),
                    cancel: TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        'No',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    confirmTextColor: Colors.white,
                    cancelTextColor: controller.isDartkTheme.value
                        ? Colors.white
                        : Colors.black,
                    barrierDismissible: false,
                  );
                },
                child: Obx(() => Visibility(
                      visible: controller.isDelete.value,
                      child: Icon(
                        Icons.delete,
                        size: 30.0,
                        color: Colors.black,
                      ),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12.0, left: 8.0),
              child: GestureDetector(
                onTap: () {
                  //Get.toNamed(Routes.HISTORY);
                },
                child: Checkbox(
                  value: false,
                  onChanged: (v) {},
                ),
              ),
            ),
          ],
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Obx(() => controller.recordsList.isEmpty
                            ? Center(
                                child: Text(
                                  'No records',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            : ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount: controller.recordsList.length,
                                itemBuilder: (context, index) {
                                  if (controller.isLoading.value) {
                                    return builTeamShimmerWidget();
                                  } else {
                                    Datamodel data =
                                        controller.recordsList[index];
                                    return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 10.0),
                                        child: Slidable(
                                          endActionPane: const ActionPane(
                                              motion: ScrollMotion(),
                                              children: [
                                                SlidableAction(
                                                  // An action can be bigger than the others.
                                                  onPressed: doNothing,
                                                  backgroundColor: Colors.red,
                                                  foregroundColor: Colors.white,
                                                  icon: Icons.delete,
                                                  label: 'Delete',
                                                ),
                                                SlidableAction(
                                                  onPressed: doNothing,
                                                  backgroundColor: Colors.green,
                                                  foregroundColor: Colors.white,
                                                  icon: Icons.share,
                                                  label: 'Share',
                                                )
                                              ]),
                                          child: Material(
                                            color: controller.isDartkTheme.value
                                                ? Colors.black38
                                                : Colors.grey.shade300,
                                            elevation: 4,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(0.0)),
                                            child: Container(
                                              width: double.infinity,
                                              height: 100.0,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 6,
                                                    decoration: BoxDecoration(
                                                        color: data.mode == 'W'
                                                            ? Colors.deepOrange
                                                            : data.mode == 'M'
                                                                ? Colors.green
                                                                : data.mode ==
                                                                        'C'
                                                                    ? Colors.red
                                                                    : Colors
                                                                        .grey,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        15.0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        15.0))),
                                                    height: double.infinity,
                                                  ),
                                                  SizedBox(
                                                    width: 24.0,
                                                  ),
                                                  Material(
                                                    color: controller
                                                            .isDartkTheme.value
                                                        ? backgroundColor
                                                        : Colors.white38,
                                                    elevation: 4.0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15.0)),
                                                    child: Container(
                                                      width: 70,
                                                      height: 70,
                                                      decoration: BoxDecoration(
                                                        color: controller
                                                                .isDartkTheme
                                                                .value
                                                            ? backgroundColor
                                                            : Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ),
                                                      child: Center(
                                                          child: data.mode ==
                                                                  'W'
                                                              ? Icon(
                                                                  FontAwesomeIcons
                                                                      .wifi,
                                                                  size: 28.0,
                                                                  color:
                                                                      appBarColor,
                                                                )
                                                              : Icon(
                                                                  FontAwesomeIcons
                                                                      .signal,
                                                                  size: 28.0,
                                                                  color:
                                                                      appBarColor,
                                                                )),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 24.0,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical:
                                                                      4.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'D : ' +
                                                                    data.downloadSpeed +
                                                                    'Mb/s',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: controller
                                                                            .isDartkTheme
                                                                            .value
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .black),
                                                              ),
                                                              SizedBox(
                                                                width: 8.0,
                                                              ),
                                                              Text(
                                                                'U :' +
                                                                    data.uploadSpeed +
                                                                    'Mb/s',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: controller
                                                                            .isDartkTheme
                                                                            .value
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .black),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Text(
                                                          "Date : " +
                                                              data.createddate,
                                                          style: TextStyle(
                                                              color: controller
                                                                      .isDartkTheme
                                                                      .value
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(
                                                          height: 2.0,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              'ISP : ' +
                                                                  data.isp,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  color: controller
                                                                          .isDartkTheme
                                                                          .value
                                                                      ? appBarColor
                                                                      : Colors
                                                                          .deepOrange),
                                                            ),
                                                            Obx(() => Checkbox(
                                                                fillColor: controller
                                                                        .isDartkTheme
                                                                        .value
                                                                    ? MaterialStateProperty
                                                                        .all(
                                                                            appBarColor)
                                                                    : MaterialStateProperty
                                                                        .all(Colors
                                                                            .black),
                                                                activeColor: Colors
                                                                    .transparent,
                                                                checkColor: controller
                                                                        .isDartkTheme
                                                                        .value
                                                                    ? Colors
                                                                        .black
                                                                    : Colors
                                                                        .black,
                                                                value:
                                                                    data.isChecked ==
                                                                            1
                                                                        ? true
                                                                        : false,
                                                                onChanged: (v) {
                                                                  print(v);
                                                                  controller
                                                                      .isDelete
                                                                      .value = v!;
                                                                  controller
                                                                          .selectedId
                                                                          .value =
                                                                      data.id!;
                                                                  controller.updateRecord(
                                                                      data.id,
                                                                      v == true
                                                                          ? 1
                                                                          : 0);
                                                                }))
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ));
                                  }
                                },
                              )),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget builTeamShimmerWidget() => ListTile(
        leading: ShimmerWidget.circular(
          width: 64,
          height: 64,
          shapeBorder:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        title: ShimmerWidget.rectangular(height: 16),
        subtitle: ShimmerWidget.rectangular(height: 13),
      );
}

void doNothing(BuildContext context) {}
