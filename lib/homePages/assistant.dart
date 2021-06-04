import 'package:cardio_ai/shared/ColorApp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Assistant extends StatefulWidget {
  Expansionpanelstate createState() => Expansionpanelstate();
}

class NewItem {
  bool isExpanded;
  final String header;
  final Widget body;
  final Icon iconpic;
  int notifications;
  NewItem(this.isExpanded, this.header, this.body, this.iconpic,
      this.notifications);
}

class Expansionpanelstate extends State<Assistant> {
  List<NewItem> items = <NewItem>[
    NewItem(
        true,
        'Reminders',
        Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
              Text(
                'Doctors appointment at 10:30 am',
                style: whitePopSmall,
              ),
            ])),
        Icon(
          Icons.notifications,
          color: Colors.white,
        ),
        1),
    NewItem(
        false,
        'News',
        Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(children: <Widget>[
              Text(
                'Nothing new',
                style: whitePopSmall,
              ),
            ])),
        Icon(
          Icons.article,
          color: Colors.white,
        ),
        0),
    NewItem(
        false,
        'Tips',
        Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(children: <Widget>[
              Text(
                'Nothing new',
                style: whitePopSmall,
              ),
            ])),
        Icon(
          Icons.info_outline,
          color: Colors.white,
        ),
        0),
    NewItem(
        false,
        'Test',
        Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(children: <Widget>[
              Text(
                'Nothing new',
                style: whitePopSmall,
              ),
            ])),
        Icon(
          Icons.analytics_outlined,
          color: Colors.white,
        ),
        0),
  ];
  ListView List_Criteria;
  Widget build(BuildContext context) {
    List_Criteria = ListView(
      children: [
        Padding(
          padding: EdgeInsets.all(10.0),
          child: ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                items[index].isExpanded = !items[index].isExpanded;
              });
            },
            children: items.map((NewItem item) {
              return ExpansionPanel(
                backgroundColor: darkCard,
                canTapOnHeader: true,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                height: 10,
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
                isExpanded: item.isExpanded,
                body: item.body,
              );
            }).toList(),
          ),
        ),
      ],
    );
    return List_Criteria;
  }
}
