import 'package:cardio_ai/shared/ColorApp.dart';
import 'package:flutter/material.dart';

class ModalTile extends StatefulWidget {
  ModalTile({Key key}) : super(key: key);

  @override
  _ModalTileState createState() => _ModalTileState();
}

class _ModalTileState extends State<ModalTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
        color: darkCard,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(90),
    bottomRight: Radius.circular(90),
    topLeft: Radius.circular(90),
    topRight: Radius.circular(90)),
    ),
    child: ListTile(
    leading: Icon(Icons.circle,color: Colors.white,),
    title: Text("hello",style: whitePop(Colors.white),),
      trailing: Icon(Icons.edit,color: Colors.white),
    )
    );
  }
}