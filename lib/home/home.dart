import 'package:cardio_ai/authentication/auth.dart';
import 'package:cardio_ai/authentication/login.dart';
import 'package:cardio_ai/shared/ColorApp.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:cardio_ai/homePages/home_page.dart';
import 'package:cardio_ai/homePages/Settings.dart';
import 'package:cardio_ai/homePages/Assistant.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int PageIndex = 1;

  GlobalKey _bottomNavigationKey = GlobalKey();

  final Assistant _assistant = new Assistant();
  final HomePage _home = new HomePage();
  final Settings _settings = new Settings();

  Widget _showpage = new HomePage();
  Widget _page(int page) {
    switch (page) {
      case 0:
        return _assistant;
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
            _showpage = _page(tappedIndex);
          });
        },
      ),
      backgroundColor: darkBg,
      body: _showpage,
    );
  }
}
