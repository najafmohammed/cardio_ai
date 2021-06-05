import 'package:cardio_ai/shared/ColorApp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HistoryInfoTile extends StatefulWidget {
  HistoryInfoTile({Key key, this.entry, this.index}) : super(key: key);
  final List<dynamic> entry;
  final int index;

  @override
  _HistoryInfoTileState createState() => _HistoryInfoTileState();
}

class _HistoryInfoTileState extends State<HistoryInfoTile> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String title;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListTile(
      leading: Icon(
        Icons.circle,
        color: Colors.white,
      ),
      title: Text(
        (widget.index == 0)
            ? "Age"
            : (widget.index == 1)
                ? "Sex"
                : (widget.index == 2)
                    ? "Chest Pain"
                    : (widget.index == 3)
                        ? "Resting Blood Pressure"
                        : (widget.index == 4)
                            ? "Serum Cholesterol"
                            : (widget.index == 5)
                                ? "Fasting Blood Sugar"
                                : (widget.index == 6)
                                    ? "Resting ECG"
                                    : (widget.index == 7)
                                        ? "Max Heart Rate"
                                        : (widget.index == 8)
                                            ? "Exercise induced angina"
                                            : (widget.index == 9)
                                                ? "ST depression"
                                                : (widget.index == 10)
                                                    ? "Peak exercise ST"
                                                    : (widget.index == 11)
                                                        ? "Number of major vessels"
                                                        : (widget.index == 12)
                                                            ? "Thalassemia"
                                                            : "",
        style: whitePopSmall,
      ),
      trailing: Text(
        (widget.index == 1)
            ? (widget.entry[widget.index] == 0)
                ? "Female"
                : "Male"
            : (widget.index == 2)
                ? (widget.entry[widget.index] == 0)
                    ? "Typical Angina"
                    : (widget.entry[widget.index] == 1)
                        ? "Atypical Angina"
                        : (widget.entry[widget.index] == 2)
                            ? "Non-Anginal pain"
                            : "Asymptomatic"
                : (widget.index == 5)
                    ? (widget.entry[widget.index] == 0)
                        ? "> 120 mg/dl"
                        : "< 120 mg/dl"
                    : (widget.index == 8)
                        ? (widget.entry[widget.index] == 0)
                            ? "No"
                            : "Yes"
                        : (widget.index == 10)
                            ? (widget.entry[widget.index] == 0)
                                ? "Up Sloping"
                                : (widget.entry[widget.index] == 1)
                                    ? "Flat"
                                        : "Down Sloping"
                            : widget.entry[widget.index].toString(),
        style: whitePopSmall,
      ),
    ));
  }
}
