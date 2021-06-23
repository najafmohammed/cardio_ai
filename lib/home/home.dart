import 'package:cardio_ai/authentication/auth.dart';
import 'package:cardio_ai/authentication/login.dart';
import 'package:cardio_ai/homePages/assistant.dart';
import 'package:cardio_ai/homePages/PhoneSettings.dart';
import 'package:cardio_ai/models/globalMessagingModel.dart';
import 'package:cardio_ai/models/reminderModel.dart';
import 'package:cardio_ai/shared/ColorApp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cardio_ai/homePages/home_page.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  initState() {
    getData();
    super.initState();
  }

  int newsCount;
  int reminderCount;
  int tipsCount;
  int testCount;

  List<reminderModel> reminders;
  List<globalMessagingModel> news;
  List<globalMessagingModel> tips;
  List<globalMessagingModel> test;

  Future getData() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;
    final uid = user.uid;

    //Reminders
    await FirebaseFirestore.instance
        .collection('Patient Record')
        .doc(uid)
        .collection("Reminders")
        .get()
        .then((value) {
      setState(() {
        reminders = value.docs.map((e) {
          return reminderModel(e.get("msg"));
        }).toList();
        reminderCount = value.docs.length;
        print(value.docs.length);
      });
    });

    //News
    await globalMessageCollection
        .doc("Messaging")
        .collection("News")
        .get()
        .then((value) {
      setState(() {
        news = value.docs.map((e) {
          return globalMessagingModel(e.id.toString(), e.get("text"));
        }).toList();
        newsCount = value.docs.length;
      });
    });

    //Tests
    await globalMessageCollection
        .doc("Messaging")
        .collection("Test")
        .get()
        .then((value) {
      setState(() {
        test = value.docs.map((e) {
          return globalMessagingModel(e.id.toString(), e.get("text"));
        }).toList();
        testCount = value.docs.length;
      });
    });

    //Tips
    await globalMessageCollection
        .doc("Messaging")
        .collection("Tips")
        .get()
        .then((value) {
      setState(() {
        tips = value.docs.map((e) {
          return globalMessagingModel(e.id.toString(), e.get("text"));
        }).toList();
        tipsCount = value.docs.length;
      });
    });
    return "done";
  }

  int PageIndex = 1;

  GlobalKey _bottomNavigationKey = GlobalKey();

  // final Assistant _assistant = new Assistant();
  final HomePage _home = new HomePage();
  final PhoneSettings _settings = new PhoneSettings();

  Widget _showpage = new HomePage();
  Widget _page(int page, BuildContext context) {
    switch (page) {
      case 0:
        {
          getData();
          return new Assistant(
              news: news,
              newsCount: newsCount,
              testCount: testCount,
              test: test,
              reminderCount: reminderCount,
              reminders: reminders,
              tipsCount: tipsCount,
              tips: tips);
        }
        break;
      case 1:
        return _home;
        break;
      case 2:
        return _settings;
        break;

      default:
        return new Container(
          child: new Center(
            child: new Text('Home'),
          ),
        );
    }
  }

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CircleAvatar(
            radius: 18, backgroundColor: darkAccent, child: Icon(Icons.person)),
        actions: [
          GestureDetector(
            onTap: () async {
              await _auth.signout();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => Login()));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.logout),
            ),
          )
        ],
        backgroundColor: darkAccent,
        centerTitle: true,
        title: Text(
          "Cardio AI",
          style: TextStyle(color: Colors.white),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: PageIndex,
        height: 50.0,
        items: <Widget>[
          Icon(
            Icons.assistant,
            size: 30,
            color: Colors.white,
          ),
          Icon(Icons.favorite_border_rounded, size: 30, color: Colors.white),
          Icon(
            Icons.info_rounded,
            size: 30,
            color: Colors.white,
          ),
        ],
        color: darkAccent,
        buttonBackgroundColor: darkAccent,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (int tappedIndex) {
          setState(() {
            /// _page = index;
            _showpage = _page(tappedIndex, context);
          });
        },
      ),
      backgroundColor: darkBg,
      body: _showpage,
    );
  }
}
