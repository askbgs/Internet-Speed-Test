import 'package:flutter/material.dart';
import 'package:speedtest/app/constants/color_plate.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class SfRadialGraph extends StatefulWidget {
  const SfRadialGraph(
      {Key? key,
      required this.displayRate,
      required this.unitText,
      required this.title})
      : super(key: key);

  final double displayRate;
  final String unitText;
  final String title;

  @override
  State<SfRadialGraph> createState() => _SfRadialGraphState();
}

class _SfRadialGraphState extends State<SfRadialGraph> {
  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
        title: GaugeTitle(
            text: widget.title,
            textStyle: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,)),
        axes: <RadialAxis>[
          RadialAxis(
              minimum: 0,
              maximum: 50,
              axisLabelStyle: GaugeTextStyle(
                color: txtCol,
              ),
              ranges: <GaugeRange>[
                GaugeRange(
                    startValue: 0,
                    endValue: 5,
                    color: Colors.green,
                    startWidth: 5,
                    endWidth: 5),
                GaugeRange(
                    startValue: 5,
                    endValue: 10,
                    color: Colors.orange,
                    startWidth: 5,
                    endWidth: 5),
                GaugeRange(
                    startValue: 10,
                    endValue: 15,
                    color: Colors.white,
                    startWidth: 5,
                    endWidth: 5),
                GaugeRange(
                    startValue: 15,
                    endValue: 20,
                    color: Colors.blue,
                    startWidth: 5,
                    endWidth: 5),
                GaugeRange(
                    startValue: 20,
                    endValue: 25,
                    color: Colors.redAccent,
                    startWidth: 5,
                    endWidth: 5),
                GaugeRange(
                    startValue: 25,
                    endValue: 30,
                    color: Colors.redAccent,
                    startWidth: 5,
                    endWidth: 5),
                GaugeRange(
                    startValue: 30,
                    endValue: 35,
                    color: Colors.redAccent,
                    startWidth: 5,
                    endWidth: 5),
                GaugeRange(
                    startValue: 35,
                    endValue: 40,
                    color: Colors.redAccent,
                    startWidth: 5,
                    endWidth: 5),
                GaugeRange(
                    startValue: 40,
                    endValue: 45,
                    color: Colors.redAccent,
                    startWidth: 5,
                    endWidth: 5),
                GaugeRange(
                    startValue: 45,
                    endValue: 50,
                    color: Colors.redAccent,
                    startWidth: 5,
                    endWidth: 5),
              ],
              pointers: <GaugePointer>[
                NeedlePointer(
                  value: widget.displayRate,
                  enableAnimation: true,
                  needleColor: needleColor,
                )
              ],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                    widget: Container(
                      child: Text(
                        widget.displayRate.toStringAsFixed(2) +
                            ' ' +
                            widget.unitText,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: txtCol,
                        ),
                      ),
                    ),
                    angle: 90,
                    positionFactor: 1.1)
              ])
        ]);
  }
}
