import 'package:auto_animated/auto_animated.dart';
import 'package:cardio_ai/models/quickInfoModel.dart';
import 'package:flutter/material.dart';
import 'package:cardio_ai/HomeWidgets/QuickInfo/quick_info.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

DateTime date = DateTime.now();
List<QuickInfoModel> model = <QuickInfoModel>[
  QuickInfoModel(
      title: "AI Prediction",
      lastDate: date,
      value: 50,
      prev: 49,
      unit:"%",
      colorValue: Color(0xFF1BB2ED),
      imageLoc: "assets/images/AI.png",
      remark: "Good"),
  QuickInfoModel(
      title: "Heart Rate",
      lastDate: date,
      value: 50,
      prev: 49,
      unit:"bpm",
      colorValue: Color(0xFFed1b24),
      imageLoc: "assets/images/heartRate.png",
      remark: "Good"),
  QuickInfoModel(
      title: "Blood pressure",
      lastDate: date,
      value: 50,
      prev: 49,
      unit:"mmHg",
      colorValue: Color(0xFFd8453e),
      imageLoc: "assets/images/bloodPressure.png",
      remark: "Good"),
  QuickInfoModel(
      title: "Fasting Blood Sugar",
      lastDate: date,
      value: 50,
      prev: 49,
      unit:"mg/dL",
      colorValue: Color(0xFF319997),
      imageLoc: "assets/images/bloodSugar.png",
      remark: "Good"),
  QuickInfoModel(
      title: "Cholesterol",
      lastDate: date,
      value: 50,
      prev: 49,
      unit: "mg/dL",
      colorValue: Color(0xFFff7f27),
      imageLoc: "assets/images/cholesterol.png",
      remark: "Good"),
];
final options = LiveOptions(
  showItemInterval: Duration(milliseconds: 200),
  showItemDuration: Duration(milliseconds: 200),
  visibleFraction: 0.05,
  reAnimateOnVisibility: false,
);
Widget buildAnimatedItem(
  BuildContext context,
  int index,
  Animation<double> animation,
) =>
    FadeTransition(
      opacity: Tween<double>(
        begin: 0,
        end: 1,
      ).animate(animation),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0, -0.1),
          end: Offset.zero,
        ).animate(animation),
        child: QuickInfo(
          info: model[index],
        ),
      ),
    );

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: LiveList.options(
          options: options,
          itemBuilder: buildAnimatedItem,
          scrollDirection: Axis.vertical,
          itemCount: model.length,
        )),
      ],
    );
  }
}
