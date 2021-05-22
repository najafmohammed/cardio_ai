import 'package:cardio_ai/Core/Prediction.dart';
import 'package:cardio_ai/shared/ColorApp.dart';
import 'package:countup/countup.dart';
import 'package:flutter/material.dart';

class Assistant extends StatefulWidget {
  Assistant({Key key}) : super(key: key);

  @override
  _AssistantState createState() => _AssistantState();
}

class _AssistantState extends State<Assistant> {
  var prediction=0.0;
  List<double> test =[ 57,0,0,140,241,0,1,123,1,0.2,1,0,3];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
       children: [
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Text(test.toString(),style: whitePopSmall,),
         ),
         Countup(
           begin: (0),
           end: prediction,
           style: whitePopLarge(Colors.white),
           duration: Duration(seconds: 2),
         ),
         ElevatedButton(onPressed: (){

           var a =score(test);
           setState(() {
             prediction=(a[0]*100).toDouble();
           });
           print(a[0]);
         }, child: Text("predict"))
       ],

      ),
    );
  }
}