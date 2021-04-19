import 'dart:async';

import 'package:cardio_ai/authentication/auth.dart';
import 'package:cardio_ai/authentication/login.dart';
import 'package:cardio_ai/models/UserModel.dart';
import 'package:cardio_ai/wrapper/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: Splash()));
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}


class _SplashState extends State<Splash> with TickerProviderStateMixin {
  Animation _heartAnimation,_titleReveal;
  AnimationController _heartAnimationController,_titleRevealController;
  @override
  void initState() {
    super.initState();
    _heartAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 900));
    _titleRevealController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 900));
    _heartAnimation = Tween(begin: 160.0, end: 200.0).animate(CurvedAnimation(
        curve: Curves.bounceOut, parent: _heartAnimationController));
    _titleReveal=ColorTween(begin: Colors.black ,end: Colors.red).animate(CurvedAnimation(curve: Curves.easeIn,parent: _titleRevealController));

    _heartAnimationController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _heartAnimationController.repeat(reverse: true);
      }
    });
    _heartAnimationController.forward();
    _titleRevealController.forward();
    Navigation();

  }
  @override
  void dispose() {

    _heartAnimationController?.dispose();
    _titleRevealController?.dispose();
    super.dispose();
  }
  Widget secondChild() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Expanded(
          child: AnimatedBuilder(
            animation: _heartAnimationController,
            builder: (context, child) {
              return Center(
                child: Stack(
                  children: [
                  Container(
                    alignment: Alignment.topCenter,
                      child: Center(
                        child: Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: _heartAnimation.value,
                        ),
                      ),
                    ),

                  ],
                )

              );
            },
          ),
        ),
      ],
    );
  }
  void Navigation()async{

    Timer(Duration(seconds:2),()=> Navigator.of(context).push(
        MaterialPageRoute(
            builder: (BuildContext context)=>StreamProvider<UserModel>.value(
          value: AuthService().user,
          initialData: null,
          child: MaterialApp(
            theme: ThemeData(
                visualDensity: VisualDensity.adaptivePlatformDensity,
                primaryColor: Colors.black),
            home: wrapper(),
          ),
        )
        )
    ) // Navigator.pushNamed(context, lL)
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: (
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
          children: [
          SizedBox(
            child:
            Column(
                children:[
                  secondChild(),
                ]
            ),
            height: 210,
          ),
            AnimatedBuilder(animation: _titleReveal, builder: (context, child){
              return   Text("Cardio AI",style: TextStyle(color:_titleReveal.value,fontSize: 30,fontFamily: "Poppins-Bold"),);
            }),

            
          ],
        )),
      ),
    );
  }
}
