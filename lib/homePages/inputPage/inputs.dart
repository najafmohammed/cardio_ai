import 'package:animate_icons/animate_icons.dart';
import 'package:cardio_ai/homePages/inputPage/InputPrompt_data.dart';
import 'package:cardio_ai/homePages/inputPage/modalSection/bottomModal.dart';
import 'package:cardio_ai/models/inputPromptDataModel.dart';
import 'package:cardio_ai/shared/ColorApp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Inputs extends StatefulWidget {
  const Inputs({Key key}) : super(key: key);

  @override
  _InputsState createState() => _InputsState();
}

double dragTargetWidth = 50;
Color dragTargetColor = darkCard;

class _InputsState extends State<Inputs> with TickerProviderStateMixin {
  int qCount = 0;

  int qCount1=0;
  int qCount2=0;

  List<inputPromptDataModel> _prompt = prompt;
  bool leftDropActive = true;
  bool rightDropActive = true;
  bool active1=true;
  bool showInfo = true;

  AnimateIconController _floatIconController;
CrossFadeState _crossFadeState=CrossFadeState.showFirst;


void crossFadeController(){

  setState(() {
    if(active1==true){
    // qCount1=qCount2;
    qCount2=qCount;
    _crossFadeState=CrossFadeState.showSecond;
    active1=!active1;
    print("active 1 output qcount1=$qCount1 qcount2=$qCount2 qcount=$qCount activ1=$active1 crossfadeStatee=$_crossFadeState");
    }
    else{
      // qCount2=qCount1;
      qCount1=qCount;
      _crossFadeState=CrossFadeState.showFirst;
      active1=!active1;
      print("active 2 output qcount1=$qCount1 qcount2=$qCount2 qcount=$qCount activ1=$active1 crossfadeStatee=$_crossFadeState");
    }
  });
}

void swipeManager(i){
  print(i);
  if (i<0){
    setState(() {
      if (qCount == 4) qCount = 3;
      qCount += 1;

      crossFadeController();
    });
  }
  else
    if(i==0){}
  else{
    setState(() {
      if (qCount <= 0) qCount = 1;
      qCount -= 1;
      crossFadeController();
    });
  }

}
  @override
  void initState() {
    _floatIconController = AnimateIconController();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final AnimationController _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    final Animation<Offset> _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1.5, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticIn,
    ));

    @override
    void dispose() {
      super.dispose();
      _controller.dispose();
    }

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
                              crossFadeController();
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
                  //input
                  AnimatedCrossFade(
                      firstChild: SlideTransition(
                          position: _offsetAnimation,
                        child: GestureDetector(
                          onHorizontalDragEnd: (i) {
                            swipeManager(i.primaryVelocity);
                          },
                          onTap: (){},
                          child: InputCard(
                            prompt: _prompt[qCount1],
                          ),
                        ),
                      ),
                      secondChild: GestureDetector(
                        onHorizontalDragEnd: (i) {
                          swipeManager(i.primaryVelocity);
                        },
                        child: InputCard(
                          prompt: _prompt[qCount2],
                        ),
                      ),
                      crossFadeState: _crossFadeState,

                      duration: Duration(milliseconds: 400)),

                  (rightDropActive)
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              if (qCount > 4) qCount = 4;
                              qCount += 1;
                              crossFadeController();
                            });
                          },
                          child: Container(
                            color: dragTargetColor,
                            height: dragTargetWidth * 5,
                            width: dragTargetWidth,
                            child: Center(
                              child: Icon(
                                Icons.arrow_right,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        child:
        AnimateIcons(
          startIcon: Icons.edit,
          endIcon: Icons.keyboard_arrow_right,
          size: 30.0,
          controller: _floatIconController,
          // add this tooltip for the start icon
          startTooltip: 'View all data',
          // add this tooltip for the end icon
          endTooltip: 'Complete ',
          onStartIconPress: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return BottomModal();
                }
                ).then((value) => {
              if (_floatIconController.isStart())
              {
                _floatIconController.animateToEnd()
              } else if (_floatIconController.isEnd())
              {
                _floatIconController.animateToStart()
              }
                }
                  );

            print("Clicked on Add Icon");
            return true;
          },
          onEndIconPress: () {

            // if (_floatIconController.isStart()) {
            //   _floatIconController.animateToEnd();
            // } else if (_floatIconController.isEnd()) {
            //   _floatIconController.animateToStart();
            // }

            print("Clicked on Close Icon");
            return true;
          },
          duration: Duration(milliseconds: 900),
          startIconColor: Colors.white,
          endIconColor: Colors.blue,
          clockwise: false,
    ),
        backgroundColor: Colors.deepPurple,
      )
    );
  }
}

class InputCard extends StatelessWidget {
  const InputCard({Key key, this.prompt}) : super(key: key);
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
                              text: "   " + prompt.info, style: whitePopSmall),
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
