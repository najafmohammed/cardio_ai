import 'package:cardio_ai/models/quickInfoModel.dart';
import 'package:cardio_ai/shared/ColorApp.dart';
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
        colorValue: Color(0xFFed1b24),
        imageLoc:"assets/images/heartRate.png" ,
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 3),
          child: Card(
            color: darkCard,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(20),
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(20)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      child: Image.asset("assets/images/AI.png"),
                      backgroundColor: darkBg,
                      radius: 40,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 150,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: ListTile(
                          title: Text(
                            "AI Prediction",
                            style: TextStyle(
                                color: Color(0xFF02aeed),
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w700,
                                fontSize: 22),
                          ),
                          subtitle: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "last Reading",
                                    style: whitePopSmall,
                                  ),
                                  Text(
                                    "20-04-2021",
                                    style: whitePopSmall,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Previous value",
                                    style: whitePopSmall,
                                  ),
                                  Text(
                                    "89",
                                    style: whitePopSmall,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Remarks",
                                    style: whitePopSmall,
                                  ),
                                  Text(
                                    "Optimal",
                                    style: whitePopSmall,
                                  ),
                                ],
                              ),
                            ],
                          ),

                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        children: [
                          Text("78",style: whitePop(Colors.white) ),
                          Icon(Icons.arrow_upward,color: Colors.green,)
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 4,
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
