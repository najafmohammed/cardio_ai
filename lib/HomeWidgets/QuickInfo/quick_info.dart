import 'package:cardio_ai/homePages/inputPage/inputs.dart';
import 'package:cardio_ai/models/quickInfoModel.dart';
import 'package:cardio_ai/shared/ColorApp.dart';
import 'package:countup/countup.dart';
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
  @override
  void initState() {
    if (widget.info.title == "AI Prediction") top = true;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                                      Text(
                                        DateFormat('dd-MM-yyyy')
                                            .format(widget.info.lastDate)
                                            .toString(),
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
                                        widget.info.prev.toString(),
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
                                        widget.info.remark,
                                        style: whitePopSmall,
                                      ),
                                    ],
                                  ),
                                  (top == true)
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Test Accuracy",
                                              style: whitePopSmall,
                                            ),
                                            Text(
                                              widget.info.remark,
                                              style: whitePopSmall,
                                            ),
                                          ],
                                        )
                                      : Container(),
                                  (top == true)
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                                onPressed: () {},
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
                          Countup(
                            begin: (0),
                            end: widget.info.value.toDouble(),
                            style: whitePopLarge(widget.info.colorValue),
                            duration: Duration(seconds: 2),
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
