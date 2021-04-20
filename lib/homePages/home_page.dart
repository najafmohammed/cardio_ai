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
    QuickInfoModel(title: "Heart Rate", lastdate: date, value: 50, prev: 49,remark: "Good"),
    QuickInfoModel(title: "Blood pressure", lastdate: date, value: 50, prev: 49,remark: "Good"),
    QuickInfoModel(title: "Fasting Blood Sugar", lastdate: date, value: 50, prev: 49,remark: "Good"),
    QuickInfoModel(title: "Cholesterol", lastdate: date, value: 50, prev: 49,remark: "Good"),
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
                      child: Icon(
                        Icons.headset,
                        size: 30,
                      ),
                      radius: 40,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 100,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: ListTile(
                          title: Text(
                            "info.title.toString()",
                            style: whitePop,
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
                                    "ssdf",
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
                                    "info.",
                                    style: whitePopSmall,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: CircleAvatar(child: Text("89")),
                        ),
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
