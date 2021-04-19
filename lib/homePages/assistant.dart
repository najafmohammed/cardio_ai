import 'package:flutter/material.dart';

class Assistant extends StatefulWidget {
  Assistant({Key key}) : super(key: key);

  @override
  _AssistantState createState() => _AssistantState();
}

class _AssistantState extends State<Assistant> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('assistant',style: TextStyle(color: Colors.white),),
    );
  }
}