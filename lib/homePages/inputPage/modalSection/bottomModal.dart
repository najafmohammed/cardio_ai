
import 'package:auto_animated/auto_animated.dart';
import 'package:cardio_ai/Core/Prediction.dart';
import 'package:cardio_ai/homePages/inputPage/InputPrompt_data.dart';
import 'package:cardio_ai/homePages/inputPage/modalSection/modal_tile.dart';
import 'package:cardio_ai/models/inputPromptDataModel.dart';
import 'package:cardio_ai/services/Processing.dart';
import 'package:cardio_ai/shared/ColorApp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BottomModal extends StatefulWidget {
  const BottomModal({Key key, this.prompt}) : super(key: key);
  final List<inputPromptDataModel> prompt;
  @override
  _BottomModalState createState() => _BottomModalState(prompt);
}

final options = LiveOptions(
  showItemInterval: Duration(milliseconds: 200),
  showItemDuration: Duration(milliseconds: 200),
  visibleFraction: 0.05,
  reAnimateOnVisibility: false,
);

Widget buildAnimatedItem(
  BuildContext context,
  int index,
  Animation<double> animation,
) =>
    FadeTransition(
      opacity: Tween<double>(
        begin: 0,
        end: 1,
      ).animate(animation),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0, -0.1),
          end: Offset.zero,
        ).animate(animation),
        child: ModalTile(
          input: prompt[index],
          index: index,
        ),
      ),
    );

class _BottomModalState extends State<BottomModal>
    with TickerProviderStateMixin {
  final List<inputPromptDataModel> prompt;

  _BottomModalState(this.prompt);
  String patientName="";
  String opNumber="";
  @override
  Widget build(BuildContext context) {
    AnimationController controller;

    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
      reverseDuration: Duration(milliseconds: 500),
    );
    controller.repeat(reverse: true);

    @override
    dispose() {
      controller.dispose(); // you need this
      super.dispose();
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                Text(
                  "Input Data",
                  style: whitePopLarge(
                    Colors.white,
                  ),
                ),
                InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.red,
                    )),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width-50,
            child: TextFormField(
              style: TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.white,
                ),
                hintStyle: TextStyle(color: Colors.white38),
                labelStyle: TextStyle(color: Colors.white),
                hintText: "Enter patient name",
                labelText: "Patient Name",
              ),
              validator: (value) {
                return (value != null && value.contains('@'))
                    ? 'Do not use the @ char.'
                    : null;
              },
              onChanged: (val1) {
                patientName=val1;
                setState(() {
                  patientName=val1;
                });
              },
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width-50,
            child: TextFormField(
              style: TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.white,
                ),
                hintStyle: TextStyle(color: Colors.white38),
                labelStyle: TextStyle(color: Colors.white),
                hintText: "Enter patient OP Number",
                labelText: "OP Number",
              ),
              validator: (value) {
                return (value != null && value.contains('@'))
                    ? 'Do not use the @ char.'
                    : null;
              },
              onChanged: (val1) {
                print("hello"+val1);
                  opNumber=val1;
                setState(() {
                  opNumber=val1;
                });
              },
            ),
          ),
          Expanded(
              child: LiveList.options(
            options: options,
            itemBuilder: buildAnimatedItem,
            scrollDirection: Axis.vertical,
            itemCount: prompt.length,
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                final CollectionReference record =
                    FirebaseFirestore.instance.collection('Patient Record');
                prompt.forEach((element) {
                  print(element.val);
                });
                print(opNumber);
                print(patientName);
                var list = Processing.processPatientRecord(widget.prompt);
                print(list);
                await record.add({"entry": list,
                "patient name":patientName,
                "op number":opNumber,
                "prediction":score(list)[0]});
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                  primary: darkAccent, // background
                  onPrimary: Colors.white, // foreground
                  padding: const EdgeInsets.all(1.0)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Confirm new entry  ",
                      style: whitePopLarge(Colors.white),
                    ),
                    AnimatedIcon(
                      icon: AnimatedIcons.add_event,
                      progress: controller,
                      semanticLabel: 'Show menu',
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
