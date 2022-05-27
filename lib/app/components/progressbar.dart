import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:speedtest/app/constants/color_plate.dart';

class Progressbar {
  LiquidLinearProgressIndicator showbar(
      double disvalue, Color? backColor, Color? vColor, Color? borderColor, Color? txtColor) {
    return LiquidLinearProgressIndicator(
      value: disvalue < 100 ? disvalue / 100.0 : 100,
      backgroundColor: backColor!,
      valueColor: AlwaysStoppedAnimation<Color>(vColor!),
      direction: Axis.horizontal,
      borderWidth: 1.0,
      borderColor: borderColor!,
      borderRadius: 12.0,
      center: Text(disvalue.toStringAsFixed(0) + "%",
          style: TextStyle(color: txtColor)),
    );
  }
}
