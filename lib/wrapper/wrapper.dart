
import 'package:cardio_ai/authentication/login.dart';
import 'package:cardio_ai/home/home.dart';
import 'package:cardio_ai/models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class wrapper extends StatefulWidget {

  @override
  _wrapperState createState() => _wrapperState();
}

class _wrapperState extends State<wrapper> {
  @override
  Widget build(BuildContext context){
    final user = Provider.of<UserModel>(context);
    if(user == null){
      return Login();
    }
    else{
      return Home();
    }
  }
}