import 'package:cardio_ai/authentication/auth.dart';
import 'package:cardio_ai/authentication/login.dart';
import 'package:cardio_ai/home/home.dart';
import 'package:cardio_ai/shared/ColorApp.dart';
import 'package:cardio_ai/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration>  with TickerProviderStateMixin{

  Animation _heartAnimation1;
  AnimationController _heartAnimationController1;
  @override
  void initState() {
    super.initState();
    _heartAnimationController1 = AnimationController(
        vsync: this, duration: Duration(milliseconds: 900));
    _heartAnimation1 = Tween(begin: 160.0, end: 200.0).animate(CurvedAnimation(
        curve: Curves.bounceOut, parent: _heartAnimationController1));
    _heartAnimationController1.forward();

  }


  @override
  void dispose() {

    _heartAnimationController1?.dispose();
    super.dispose();
  }

  final AuthService _auth = AuthService();
  String email;
  String name;
  bool loading = false;
  String password;
  bool hasError=false;
  bool _showPassword = false;
  String error="enter username and password";

  @override
  Widget build(BuildContext context) {
    return loading ? Loading():Scaffold(
      backgroundColor: darkBg,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 90,),
            InkWell(
              splashColor: Colors.red,
              onTap: (){
                _heartAnimationController1.reset();
                _heartAnimationController1.forward();},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Icon(
                  //   Icons.favorite,
                  //   color: Colors.red,
                  //   size: 180,
                  // ),
                  SizedBox(
                    height: 200,
                    child: AnimatedBuilder(
                      animation: _heartAnimationController1,
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
                                      size: _heartAnimation1.value,
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
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                new Text(
                  "Cardio AI",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Poppins",fontWeight: FontWeight.w700,
                    fontSize: 35,
                    color:Colors.red,
                  ),
                )
              ],
            ),
            SizedBox(height: 20,),
            Center(
              child: new Container(
                height: 80,
                width: 340,
                child: new TextFormField(
                  onChanged:(val){
                    _heartAnimationController1.reset();
                    _heartAnimationController1.forward();
                    setState(()=>name=val);
                  },
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: new InputDecoration(
                    hintText: 'Name',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    labelText: 'Name',
                    suffixIcon: Icon(
                      Icons.check_circle,
                      color: Colors.white,
                    ),
                    labelStyle: new TextStyle(color: Colors.white),
                  ),
                  cursorColor: Colors.white,

                ),
              ),
            ),
            Center(
              child: new Container(
                height: 80,
                width: 340,
                child: new TextFormField(
                  onChanged:(val){
                    _heartAnimationController1.reset();
                    _heartAnimationController1.forward();
                    setState(()=>email=val);
                  },
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: new InputDecoration(
                    hintText: 'Email',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    labelText: 'Email',
                    suffixIcon: Icon(
                      Icons.check_circle,
                      color: Colors.white,
                    ),
                    labelStyle: new TextStyle(color: Colors.white),
                  ),
                  cursorColor: Colors.white,

                ),
              ),
            ),

            Center(
              child: Container(
                height: 70,
                width: 340,
                child: TextFormField(
                  onChanged:(val){
                    _heartAnimationController1.reset();
                    _heartAnimationController1.forward();
                    setState(()=>password=val);
                  },
                  style:TextStyle(
                      fontFamily: "Poppins",fontWeight: FontWeight.w500,
                      color:  Colors.white
                  ),
                  //controller: widget.controller,
                  cursorColor:  Colors.white,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    labelText: 'Password',
                    labelStyle: new TextStyle(
                        color:  Colors.white
                    ),
                    hintText: 'Enter Your Password',
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                      child: Icon(
                          _showPassword ? Icons.visibility : Icons
                              .visibility_off, color:  Colors.white
                      ),
                    ),
                  ),
                  obscureText: !_showPassword,

                ),
              ),
            ),
            SizedBox(
              child: Text(error,style: TextStyle(color:(hasError)?Colors.red:Colors.green),),
              height: 50,
            ),
            Center(
              child: Container(
                height: 45,
                width: 340,
                child: ElevatedButton(
                  onPressed: ()async {

                    setState(() => loading = true);
                    dynamic result = await _auth.regWithEmailAndPassword(email, password,name);
                    if (result == null) {
                      setState(() {
                        error = 'could not register';
                        loading = false;
                      });
                    }
                    else{
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => Home()));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.redAccent,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                  ),


                  child: Text(
                    "Register",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Poppins",fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color:Color(0xffffffff),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,),
            Center(
              child: InkWell(
                onTap: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => Login()));
                },
                child: Container(
                  child: Text(
                    "Login",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Poppins",fontWeight: FontWeight.w300,
                      fontSize: 15,
                      color:Colors.red,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}