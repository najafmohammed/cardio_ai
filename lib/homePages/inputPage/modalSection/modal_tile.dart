import 'package:cardio_ai/homePages/inputPage/inputs.dart';
import 'package:cardio_ai/models/inputPromptDataModel.dart';
import 'package:cardio_ai/shared/ColorApp.dart';
import 'package:flutter/material.dart';

class ModalTile extends StatefulWidget {
  ModalTile({Key key, this.input, this.index}) : super(key: key);
  final inputPromptDataModel input;
  final int index;
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
          leading: Icon(
            Icons.circle,
            color: Colors.white,
          ),
          title: Text(
            widget.input.questionTitle,
            style: whitePopSmall,
          ),
          subtitle: Text(
            widget.input.val.toString() + " " + widget.input.unit,
            style: whitePopSmall,
          ),
          trailing: GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        Inputs(index: widget.index)));
              },
              child: Icon(Icons.edit, color: Colors.white)),
        ));
  }
}
