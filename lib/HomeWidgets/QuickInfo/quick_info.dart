import 'package:cardio_ai/history/historyList.dart';
import 'package:cardio_ai/homePages/inputPage/inputs.dart';
import 'package:cardio_ai/models/historyModel.dart';
import 'package:cardio_ai/models/quickInfoModel.dart';
import 'package:cardio_ai/shared/ColorApp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:countup/countup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class QuickInfo extends StatefulWidget {
  final QuickInfoModel info;

  QuickInfo({Key key, this.info}) : super(key: key);

  @override
  _QuickInfoState createState() => _QuickInfoState();
}

class _QuickInfoState extends State<QuickInfo> with TickerProviderStateMixin {
  bool top = false;
  bool newUser = true;
  @override
  void initState() {
    _initialiseData();
    if (widget.info.title == "AI Prediction") top = true;
    super.initState();
  }

  var entry;
  double prediction=0.0;
  double value=0.0;
  bool sugarLevel = false;
  Timestamp date;
  void _initialiseData() async {
    final CollectionReference record =
    FirebaseFirestore.instance.collection('Patient Record');
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;
    final uid = user.uid;

    var _userData = await record.doc(uid).get();
    setState(() {
      entry = _userData.get("entry");
      date = _userData.get("date");
      prediction = _userData.get("prediction");
      newUser = _userData.get("new");
      print(newUser);

    if (!newUser) {
      if (widget.info.title == "AT Prediction") value = prediction;
      if (widget.info.title == "Heart Rate") value =(entry[7].toDouble());
      if (widget.info.title == "Blood pressure") value = (entry[3].toDouble());
      if (widget.info.title == "Fasting Blood Sugar") {
        value = 120;
        if (entry[5] == 0) {
          value = 120;
          sugarLevel = false;
        } else {
          sugarLevel = true;
        }
      }
      if (widget.info.title == "Cholesterol") value = (entry[4].toDouble());
    }
    });
  }

  @override
  Widget build(BuildContext context) {

    print(widget.info.title);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
      child: Card(
          color: darkCard,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(90),
                bottomRight: Radius.circular(20),
                topLeft: Radius.circular(90),
                topRight: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Stack(alignment: Alignment.center, children: [
                    CircleAvatar(
                      backgroundColor: darkBg,
                      child: Image.asset(widget.info.imageLoc),
                      radius: 30,
                    ),
                  ]),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 145,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 5),
                              child: Text(
                                widget.info.title,
                                style: whitePop(widget.info.colorValue),
                              ),
                            ),
                            subtitle: SizedBox(
                              width: 50,
                              child: Column(
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
                                      (!newUser)
                                          ? Text(
                                              DateFormat('dd-MM-yyyy')
                                                  .format(date.toDate())
                                                  .toString(),
                                              style: whitePopSmall,
                                            )
                                          : Text(
                                              "n/a",
                                              style: whitePopSmall,
                                            ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  (top == true)
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            Inputs(
                                                              index: 0,
                                                            )));
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  primary: darkBg, // background
                                                  onPrimary: Colors
                                                      .white, // foreground
                                                  padding: const EdgeInsets.all(
                                                      1.0)),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.favorite_border),
                                                  Text(
                                                    " Predict",
                                                    style: whitePopSmall,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 0,
                                                      horizontal: 8),
                                              child: ElevatedButton(
                                                onPressed: () async{
                                                  List<HistoryModel> _feedlistSnapshot(QuerySnapshot snapshot) {
                                                    return snapshot.docs.map((doc) {
                                                      return HistoryModel(entry: doc.get("entry"),
                                                          prediction: doc.get("prediction"), date: doc.get("date").toDate(),uid: doc.id);
                                                    }).toList();
                                                  }

                                                  final FirebaseAuth auth = FirebaseAuth.instance;
                                                  final User user = auth.currentUser;
                                                  final uid = user.uid;
                                                  QuerySnapshot a = await FirebaseFirestore.instance
                                                      .collection('Patient Record')
                                                      .doc(uid)
                                                      .collection("history").orderBy("date",descending:true)
                                                      .get();
                                                  var b = _feedlistSnapshot(a);

                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (BuildContext
                                                          context) =>
                                                              HistoryList(
                                                                  list: b,
                                                              )));
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  padding:
                                                      const EdgeInsets.all(1.0),
                                                  primary: darkBg, // background
                                                  onPrimary: Colors
                                                      .white, // foreground
                                                ),
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.history),
                                                    Text(
                                                      " History",
                                                      style: whitePopSmall,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      : Container()
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              (widget.info.title=="Fasting Blood Sugar")?
                              (sugarLevel)
                                  ? Text(
                                      ">",
                                      style: whitePopSmall,
                                    )
                                  : Text(
                                "<",
                                style: whitePopSmall,
                              ):Container(),
                              (top)?
                              Countup(
                                begin: (0),
                                end: prediction*100,
                                style: whitePopLarge(widget.info.colorValue),
                                duration: Duration(seconds: 2),
                              ):Countup(
                                begin: (0),
                                end: value.toDouble(),
                                style: whitePopLarge(widget.info.colorValue),
                                duration: Duration(seconds: 2),
                              ),
                            ],
                          ),
                          Text(
                            widget.info.unit,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // child: Text("89",style: whitePop,)),
                ],
              ),
            ],
          )),
    );
  }
}
