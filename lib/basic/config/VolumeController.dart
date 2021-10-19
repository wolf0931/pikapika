/// 音量键翻页

import 'dart:io';

import 'package:flutter/material.dart';

import '../Common.dart';
import '../Method.dart';

const propertyName = "volumeController";

late bool volumeController;

Future<void> initVolumeController() async {
  volumeController =
      (await method.loadProperty(propertyName, "false")) == "true";
}

String volumeControllerName() {
  return volumeController ? "是" : "否";
}

Future<void> chooseVolumeController(BuildContext context) async {
  String? result =
      await chooseListDialog<String>(context, "音量键控制翻页", ["是", "否"]);
  if (result != null) {
    var target = result == "是";
    await method.saveProperty(propertyName, "$target");
    volumeController = target;
  }
}

Widget volumeControllerSetting() {
  if (Platform.isAndroid) {
    return StatefulBuilder(builder:
        (BuildContext context, void Function(void Function()) setState) {
      return ListTile(
          title: Text("阅读器音量键翻页(仅安卓)"),
          subtitle: Text(volumeControllerName()),
          onTap: () async {
            await chooseVolumeController(context);
            setState(() {});
          });
    });
  }
  return Container();
}