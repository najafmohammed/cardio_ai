
import 'package:cardio_ai/models/historyModel.dart';
import 'package:cardio_ai/shared/ColorApp.dart';
import 'package:flutter/material.dart';

import 'historyTile.dart';

class HistoryList extends StatefulWidget {

 final List<HistoryModel> list;

  const HistoryList({Key key, this.list}) : super(key: key);

  @override
  _HistoryListState createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
      ),
      backgroundColor: darkBg,
      body: ListView.builder(
        itemCount: widget.list.length,
        shrinkWrap: true,
        primary: false,
        itemBuilder: (context, index) {
          return HistoryTile(input: widget.list[index],);
        },
      ),
    );
  }
}