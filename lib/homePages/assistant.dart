import 'package:cardio_ai/models/globalMessagingModel.dart';
import 'package:cardio_ai/models/reminderModel.dart';
import 'package:cardio_ai/shared/ColorApp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Assistant extends StatefulWidget {
  final int newsCount;
  final int reminderCount;
  final int tipsCount;
  final int testCount;

  final List<reminderModel> reminders;
  final List<globalMessagingModel> news;
  final List<globalMessagingModel> tips;
  final List<globalMessagingModel> test;

  const Assistant(
      {Key key,
      this.newsCount,
      this.reminderCount,
      this.tipsCount,
      this.testCount,
      this.reminders,
      this.test,
      this.news,
      this.tips})
      : super(key: key);

  Expansionpanelstate createState() => Expansionpanelstate();
}

class NewItem {
  bool isExpanded;
  final String header;
  final Widget body;
  final Icon iconpic;
  int notifications;
  int index;
  NewItem(this.isExpanded, this.header, this.body, this.iconpic,
      this.notifications,this.index);
}

CollectionReference globalMessageCollection =
    FirebaseFirestore.instance.collection('Global');

class Expansionpanelstate extends State<Assistant> {
  int globalIndex=0;
  var newsDataWidgets = <Widget>[];
  var tipsDataWidgets = <Widget>[];
  var testDataWidgets = <Widget>[];
  var reminderDataWidgets = <Widget>[];
  initState() {
    getData();
    super.initState();
  }

  void getData() {

    setState(() {
      widget.tips.forEach((element) {
        tipsDataWidgets.add(ListTile(
          title: Text(element.tittle, style:  whitePopLarge(Colors.white)),
          subtitle: Text(element.text, style: whitePopSmall),
        ));
      });
      widget.test.forEach((element) {
        testDataWidgets.add(ListTile(
          title: Text(element.tittle, style:  whitePopLarge(Colors.white)),
          subtitle: Text(element.text, style: whitePopSmall),
        ));
      });
      widget.news.forEach((element) {
        newsDataWidgets.add(ListTile(
          title: Text(element.tittle, style: whitePopLarge(Colors.white)),
          subtitle: Text(element.text, style: whitePopSmall),
        ));
      });
      widget.reminders.forEach((element) {
        reminderDataWidgets.add(ListTile(title:Text(element.text, style: whitePopLarge(Colors.white))));
      });
    });
  }

  List boolKeeper=[true,false,false,false];

  ListView listCriteria;
  Widget build(BuildContext context) {


    List<NewItem> items = <NewItem>[
      NewItem(
          true,
          'Reminders',
          Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                  children: reminderDataWidgets)),
          Icon(
            Icons.notifications,
            color: Colors.white,
          ),
          widget.reminderCount,0),
      NewItem(
          true,
          'News',
          Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(children: newsDataWidgets)),
          Icon(
            Icons.article,
            color: Colors.white,
          ),
          widget.newsCount,1),
      NewItem(
          true,
          'Tips',
          Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                  children: tipsDataWidgets
              ),
          ),
          Icon(
            Icons.info_outline,
            color: Colors.white,
          ),
          widget.tipsCount,2),
      NewItem(
          true,
          'Test',
          Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(children: testDataWidgets)),
          Icon(
            Icons.analytics_outlined,
            color: Colors.white,
          ),
          widget.testCount,3),
    ];
    listCriteria = ListView(
      children: [
        Padding(
          padding: EdgeInsets.all(10.0),
          child: ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                boolKeeper[index]=!boolKeeper[index];
                items[index].isExpanded = !items[index].isExpanded;
              });
            },
            children: items.map((NewItem item) {
              return ExpansionPanel(
                backgroundColor: darkCard,
                canTapOnHeader: true,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ListTile(
                        tileColor: darkCard,
                        leading: item.iconpic,
                        trailing: (item.notifications != 0)
                            ? Text(
                                item.notifications.toString(),
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              )
                            : SizedBox(
                                height: 5,
                              ),
                        // trailing: Icon(Icons.add_to_drive,color: Colors.white,),
                        title: Text(
                          item.header,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400,
                          ),
                        )),
                  );
                },
                isExpanded: boolKeeper[item.index],
                body: item.body,
              );
            }).toList(),
          ),
        ),
      ],
    );
    return listCriteria;
  }
}
