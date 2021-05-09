import 'package:cardio_ai/homePages/inputPage/InputPrompt_data.dart';
import 'package:cardio_ai/models/inputPromptDataModel.dart';
import 'package:cardio_ai/shared/ColorApp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Inputs extends StatefulWidget {
  const Inputs({Key key}) : super(key: key);

  @override
  _InputsState createState() => _InputsState();
}

class _InputsState extends State<Inputs> with TickerProviderStateMixin{
  int qCount = 0;

  List<inputPromptDataModel> _prompt = prompt;
  bool leftDropActive = true;
  bool rightDropActive = true;
  double dragTargetWidth = 50;
  Color dragTargetColor = darkCard;

  bool showInfo = true;

  Animation _reveal;
  AnimationController _revealController;
@override
  void initState() {
  _revealController = AnimationController(
      vsync: this, duration: Duration(milliseconds: 500));
  _reveal = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      curve: Curves.easeInCirc, parent: _revealController));
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    (qCount == 0) ? leftDropActive = false : leftDropActive = true;
    (qCount == 4) ? rightDropActive = false : rightDropActive = true;
    print(qCount);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            (qCount + 1).toString() + "of 12",
            style: whitePop(Colors.white),
          ),
        ),
        // bottomNavigationBar: BottomNavigationBar(
        //   items: [
        //    BottomNavigationBarItem(icon: Icon(Icons.keyboard_arrow_up),label: "up"),
        //     BottomNavigationBarItem(icon: Icon(Icons.keyboard_arrow_up),label: "up"),
        //     BottomNavigationBarItem(icon: Icon(Icons.keyboard_arrow_up),label: "up")
        //   ],
        // ),
        backgroundColor: darkBg,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                        (leftDropActive)
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (qCount < 0) qCount = 1;
                                    qCount -= 1;
                                  });
                                },
                                child: Container(
                                  color: dragTargetColor,
                                  height: dragTargetWidth * 5,
                                  width: dragTargetWidth,
                                  child: Center(
                                    child: Icon(
                                      Icons.arrow_left,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                    GestureDetector(
                      onHorizontalDragEnd: (i){
                        print(i.primaryVelocity);
                      },
                      child: InputCard(
                        prompt: _prompt[qCount],
                      ),
                    ),
                    (rightDropActive)
                        ? GestureDetector(
                      onTap: () {
                        setState(() {
                          if (qCount > 4) qCount = 4;
                          qCount += 1;
                        });
                      },
                      child: Container(
                        color: dragTargetColor,
                        height: dragTargetWidth * 5,
                        width: dragTargetWidth,
                        child: Center(
                          child: Icon(
                            Icons.arrow_left,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                        : Container(),
                  ],
                ),

              ],
            ),
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //
        //   },
        //   child: Icon(Icons.edit, color: Colors.white),
        //   backgroundColor: Colors.deepPurple,
        // )
    );
  }
}


class InputCard extends StatelessWidget {
  const InputCard({Key key, this.prompt}) : super(key: key);
  final inputPromptDataModel prompt;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width-100,
      child: Card(
        color: darkCard,
        child: (Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(
                prompt.questionTitle,
                style: whitePop(Colors.white),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(3.0),
                child: SizedBox(
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: new RichText(
                        text: new TextSpan(children: [
                          WidgetSpan(
                            child: new Icon(
                              Icons.info,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          TextSpan(
                              text: "   " + prompt.info,
                              style: whitePopSmall),
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

class SwipeArea extends StatelessWidget {
  const SwipeArea({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

