import 'package:cardio_ai/homePages/inputPage/InputPrompt_data.dart';
import 'package:cardio_ai/models/inputPromptDataModel.dart';
import 'package:cardio_ai/shared/ColorApp.dart';
import 'package:flutter/material.dart';

class Inputs extends StatefulWidget {
  const Inputs({Key key}) : super(key: key);

  @override
  _InputsState createState() => _InputsState();
}

class _InputsState extends State<Inputs> {
  int qCount = 0;

  List<inputPromptDataModel> _prompt = prompt;
  bool leftDropActive = true;
  bool rightDropActive = true;
  double dragTargetWidth=50;
  Color dragTargetColor=darkCard;

  @override
  Widget build(BuildContext context) {
    (qCount == 0) ? leftDropActive = false : leftDropActive = true;
    (qCount == 4) ? rightDropActive = false : rightDropActive = true;
    print(qCount);
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: darkBg,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                (qCount + 1).toString() + "of 12",
                style: whitePop(Colors.white),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DragTarget<int>(
                  onMove: (data){
                    dragTargetColor=dropOntarget;
                  },
                  onLeave: (data){
                    dragTargetColor=darkCard;
                  },
                  builder: (
                    BuildContext context,
                    List<dynamic> accepted,
                    List<dynamic> rejected,
                  ) {
                    return (leftDropActive)
                        ? GestureDetector(
                        onTap: (){setState(() {
                          if (qCount < 0) qCount = 1;
                          qCount -= 1;
                        });},
                          child: Container(
                              color: dragTargetColor,
                              height: dragTargetWidth*5,
                              width: dragTargetWidth,
                              child: Center(
                                child: Icon(
                                  Icons.arrow_left,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                        )
                        : Container();
                  },
                  onWillAccept: (data) => data != 0,
                  onAccept: (int data) {
                    setState(() {
                      if (qCount < 0) qCount = 1;
                      qCount -= 1;
                    });
                  },
                ),
                // ClipRect(
                //   child: Align(
                //     alignment: Alignment.topCenter,
                //     heightFactor: 0.5,
                //    child: ,
                //   ),
                // ),
                Draggable<int>(
                  onDragStarted: (){
                    setState(() {
                      print("hola");
                      dragTargetWidth=70;
                      dragTargetColor=dropHighlight;
                    });
                  },
                  onDragCompleted: (){
                    setState(() {
                      dragTargetWidth=50;
                      dragTargetColor=darkCard;
                    });
                  },
                  onDraggableCanceled: (v,o){
                  setState(() {
                    dragTargetWidth=50;
                    dragTargetColor=darkCard;
                   });
                  },
                  data: qCount,
                  feedback: InputCard(
                    qCount: qCount,
                    prompt: _prompt[qCount],
                  ),
                  childWhenDragging: Card(
                    color: darkCard,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 160,
                      height: 100,
                    ),
                  ),
                  child: InputCard(
                    qCount: qCount,
                    prompt: _prompt[qCount],
                  ),
                ),
                DragTarget<int>(
                    onMove: (data){
                      dragTargetColor=dropOntarget;
                    },
                    onLeave: (data){
                      dragTargetColor=darkCard;
                    },
                  builder: (
                    BuildContext context,
                    List<dynamic> accepted,
                    List<dynamic> rejected,
                  ) {
                    return (rightDropActive)
                        ? GestureDetector(
                      onTap: (){
                        setState(() {
                          if (qCount > 4) qCount = 4;
                          qCount += 1;
                        });
                      },
                          child: Container(
                              color: dragTargetColor,
                              height: dragTargetWidth*5,
                              width: dragTargetWidth,
                              child: Center(
                                child: Icon(
                                  Icons.arrow_right,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                        )
                        : Container();
                  },
                  onWillAccept: (data) => data != 4,
                  onAccept: (int data) {
                    setState(() {
                      if (qCount > 4) qCount = 4;
                      qCount += 1;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class InputCard extends StatelessWidget {
  const InputCard({Key key, this.qCount, this.prompt}) : super(key: key);
  final int qCount;
  final inputPromptDataModel prompt;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 100,
      child: Card(
        color: darkCard,
        child: (Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                prompt.questionTitle,
                style: whitePop(Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:
              SizedBox(
                height: 250,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: new RichText(
                      text: new TextSpan(children: [
                        WidgetSpan(
                          child: new Icon(Icons.info, color: Colors.white,size:20 ,),
                        ),
                        TextSpan(text: "   "+prompt.info, style: whitePopSmall),
                      ]),
                    ),
                  ),
                ),
              )

              // Text(
              //   prompt.info,
              //   style: whitePopSmall,
              // ),
            ),
            TextFormField(
              style: TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.white,
                ),
                hintStyle: TextStyle(color: Colors.white38),
                labelStyle: TextStyle(color: Colors.white),
                hintText: 'What do people call you?',
                labelText: 'Name ',
              ),
              validator: (String value) {
                return (value != null && value.contains('@'))
                    ? 'Do not use the @ char.'
                    : null;
              },
            )
          ],
        )),
      ),
    );
  }
}
