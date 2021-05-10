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
      lastdate: date,
      value: 50,
      prev: 49,
      colorValue: Color(0xFF1BB2ED),
      imageLoc: "assets/images/AI.png",
      remark: "Good"),
  QuickInfoModel(
      title: "Heart Rate",
      lastdate: date,
      value: 50,
      prev: 49,
      colorValue: Color(0xFFed1b24),
      imageLoc: "assets/images/heartRate.png",
      remark: "Good"),
  QuickInfoModel(
      title: "Blood pressure",
      lastdate: date,
      value: 50,
      prev: 49,
      colorValue: Color(0xFFd8453e),
      imageLoc: "assets/images/bloodPressure.png",
      remark: "Good"),
  QuickInfoModel(
      title: "Fasting Blood Sugar",
      lastdate: date,
      value: 50,
      prev: 49,
      colorValue: Color(0xFF319997),
      imageLoc: "assets/images/bloodSugar.png",
      remark: "Good"),
  QuickInfoModel(
      title: "Cholesterol",
      lastdate: date,
      value: 50,
      prev: 49,
      colorValue: Color(0xFFff7f27),
      imageLoc: "assets/images/cholesterol.png",
      remark: "Good"),
];
final options = LiveOptions(
  // Start animation after (default zero)
  delay: Duration(milliseconds: 10),

  // Show each item through (default 250)
  showItemInterval: Duration(milliseconds: 200),

  // Animation duration (default 250)
  showItemDuration: Duration(milliseconds: 200),

  // Animations starts at 0.05 visible
  // item fraction in sight (default 0.025)
  visibleFraction: 0.05,

  // Repeat the animation of the appearance
  // when scrolling in the opposite direction (default false)
  // To get the effect as in a showcase for ListView, set true
  reAnimateOnVisibility: false,
);
// Build animated item (helper for all examples)
Widget buildAnimatedItem(
  BuildContext context,
  int index,
  Animation<double> animation,
) =>
    // For example wrap with fade transition
    FadeTransition(
      opacity: Tween<double>(
        begin: 0,
        end: 1,
      ).animate(animation),
      // And slide transition
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0, -0.1),
          end: Offset.zero,
        ).animate(animation),
        // Paste you Widget
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

            // Like ListView.builder, but also includes animation property
            itemBuilder: buildAnimatedItem,

            // Other properties correspond to the
            // `ListView.builder` / `ListView.separated` widget
            scrollDirection: Axis.vertical,
            itemCount: model.length,
          )
        ),
      ],
    );
  }
}
