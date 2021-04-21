import 'package:cardio_ai/models/quickInfoModel.dart';
import 'package:flutter/material.dart';
import 'package:cardio_ai/HomeWidgets/QuickInfo/quick_info.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

DateTime date = DateTime.now();

class _HomePageState extends State<HomePage> {
  List<QuickInfoModel> model = <QuickInfoModel>[
    QuickInfoModel(
        title: "AI Prediction",
        lastdate: date,
        value: 50,
        prev: 49,
        colorValue: Color(0xFF1BB2ED),
        imageLoc:"assets/images/AI.png" ,
        remark: "Good"),
    QuickInfoModel(
        title: "Heart Rate",
        lastdate: date,
        value: 50,
        prev: 49,
        colorValue: Color(0xFFed1b24),
        imageLoc:"assets/images/heartRate.png" ,
        remark: "Good"),
    QuickInfoModel(
        title: "Blood pressure",
        lastdate: date,
        value: 50,
        prev: 49,
        colorValue: Color(0xFFd8453e),
        imageLoc:"assets/images/bloodPressure.png" ,
        remark: "Good"),
    QuickInfoModel(
        title: "Fasting Blood Sugar",
        lastdate: date,
        value: 50,
        prev: 49,
        colorValue: Color(0xFF319997),
        imageLoc:"assets/images/bloodSugar.png" ,
        remark: "Good"),
    QuickInfoModel(
        title: "Cholesterol",
        lastdate: date,
        value: 50,
        prev: 49,
        colorValue: Color(0xFFff7f27),
        imageLoc:"assets/images/cholesterol.png" ,
        remark: "Good"),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 5,
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) {
              return QuickInfo(
                info: model[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
