import 'package:cardio_ai/models/historyModel.dart';
import 'package:cardio_ai/shared/ColorApp.dart';
import 'package:flutter/material.dart';

class HistoryTile extends StatefulWidget {
  HistoryTile({Key key, this.input}) : super(key: key);
  final HistoryModel input;
  @override
  _HistoryTileState createState() => _HistoryTileState();
}

class _HistoryTileState extends State<HistoryTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(widget.input.prediction);
      },
      child: Card(
          color: darkCard,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(90),
                bottomRight: Radius.circular(90),
                topLeft: Radius.circular(90),
                topRight: Radius.circular(90)),
          ),
          child: ListTile(
              leading: Icon(
                Icons.circle,
                color: Colors.white,
              ),
              title: Text(
                widget.input.date.toString(),
                style: whitePopSmall,
              ),
              trailing: GestureDetector(
                child: Text(
                  widget.input.prediction.toString(),
                  style: whitePopSmall,
                ),
              ))),
    );
  }
}

class HistoryInfo extends StatefulWidget {
  const HistoryInfo({Key key}) : super(key: key);

  @override
  _HistoryInfoState createState() => _HistoryInfoState();
}

class _HistoryInfoState extends State<HistoryInfo> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

