import 'package:animate_icons/animate_icons.dart';
import 'package:cardio_ai/home/home.dart';
import 'package:cardio_ai/homePages/inputPage/InputPrompt_data.dart';
import 'package:cardio_ai/homePages/inputPage/modalSection/bottomModal.dart';
import 'package:cardio_ai/models/inputPromptDataModel.dart';
import 'package:cardio_ai/shared/ColorApp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';



class Inputs extends StatefulWidget {
  const Inputs({Key key, this.index}) : super(key: key);
  final int index;

  @override
  _InputsState createState() => _InputsState();
}
Color editColor=Colors.deepPurple;
double dragTargetWidth = 50;
Color dragTargetColor = darkCard;
AnimateIconController _floatIconController;
String textVal;

TextEditingController _textEditingController;
List<inputPromptDataModel> _prompt = prompt;

class _InputsState extends State<Inputs> with TickerProviderStateMixin {
  int qCount;

  bool showInfo = true;
  @override
  void initState() {
    _floatIconController = AnimateIconController();
    setState(() {
      qCount = widget.index;
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (BuildContext context) => Home())),
          ),
          centerTitle: true,
          title: Text(
            (qCount + 1).toString() + "of" + _prompt.length.toString(),
            style: whitePop(Colors.white),
          ),
        ),
        backgroundColor: darkBg,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 400,
                  child: new Swiper(
                      layout: SwiperLayout.CUSTOM,
                      customLayoutOption:
                          new CustomLayoutOption(startIndex: -1, stateCount: 3)
                              .addRotate(
                                  [-45.0 / 180, 0.0, 45.0 / 180]).addTranslate([
                        new Offset(-370.0, -40.0),
                        new Offset(0.0, 0.0),
                        new Offset(370.0, -40.0)
                      ]),
                      itemWidth: 300.0,
                      itemHeight: 400.0,
                      itemBuilder: (BuildContext context, int index) {
                        return InputCard(
                          index: qCount,
                          prompt: _prompt[qCount],
                        );
                      },
                      onIndexChanged: (index) {

                        setState(() {
                          if(index==_prompt.length-1 ){

                            editColor=Colors.green;
                          }
                          else{
                            editColor=Colors.deepPurple;
                          }
                          qCount = index;
                          _textEditingController.text =
                              (_prompt[qCount].val) ?? 0.toString();
                          print(_prompt[qCount].val);
                          // _textEditingController.text="";
                        });
                      },
                      pagination: new SwiperPagination(),
                      control: new SwiperControl(),
                      duration: 1,
                      viewportFraction: 0.8,
                      scale: 0.8,
                      scrollDirection: Axis.horizontal,
                      itemCount: _prompt.length),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: AnimateIcons(
            startIcon: Icons.edit,
            endIcon: Icons.keyboard_arrow_right,
            size: 30.0,
            controller: _floatIconController,
            startTooltip: 'View all data',
            endTooltip: 'Complete ',
            onStartIconPress: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return BottomModal(prompt: prompt);
                  },isScrollControlled: true).then((value) => {_floatIconController.animateToStart()});

              print("Clicked on Add Icon");
              return true;
            },
            onEndIconPress: () {
              print("Clicked on Close Icon");
              return true;
            },
            duration: Duration(milliseconds: 900),
            startIconColor: Colors.white,
            endIconColor: Colors.blue,
            clockwise: false,
          ),
          backgroundColor: editColor,
        ));
  }
}

class InputCard extends StatefulWidget {
  const InputCard({Key key, this.prompt, this.index}) : super(key: key);
  final inputPromptDataModel prompt;
  final int index;

  @override
  _InputCardState createState() => _InputCardState();
}

class _InputCardState extends State<InputCard> {
  @override
  void initState() {
    _textEditingController = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.purple,
            ),
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: (Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(
                widget.prompt.questionTitle,
                style: whitePop(Colors.white),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(3.0),
                child: SizedBox(
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
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
                              text: "   " + widget.prompt.info,
                              style: whitePopSmall),
                        ]),
                      ),
                    ),
                  ),
                )),
            (widget.prompt.isDouble)
                ? TextFormField(
                    controller: _textEditingController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    style: TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.white,
                      ),
                      hintStyle: TextStyle(color: Colors.white38),
                      labelStyle: TextStyle(color: Colors.white),
                      hintText: "Make sure value is in accurate",
                      labelText: "Input",
                    ),
                    validator: (value) {
                      return (value != null && value.contains('@'))
                          ? 'Do not use the @ char.'
                          : null;
                    },
                    onChanged: (val1) {
                      textVal = val1;
                      print("valchanged");
                      _prompt[widget.index].val = val1;
                    },
                  )
                : DropDownList(
                    prompt: widget.prompt,
                    index: widget.index,
                  ),
          ],
        )),
      ),
    );
  }
}

class DropDownList extends StatefulWidget {
  const DropDownList({Key key, this.prompt, this.index}) : super(key: key);
  final inputPromptDataModel prompt;
  final int index;
  @override
  _DropDownListState createState() => _DropDownListState();
}

class _DropDownListState extends State<DropDownList> {
  @override
  Widget build(BuildContext context) {
    String dropdownValue = _prompt[widget.index].val??_prompt[widget.index].options[0];
    return DropdownButton<String>(
      value: dropdownValue,
      onChanged: (String newValue) {
        setState(() {
          _prompt[widget.index].val=newValue;
          dropdownValue = newValue;
        });
      },
      dropdownColor: darkAccent,
      items: _prompt[widget.index]
          .options
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: TextStyle(color: Colors.white)),
        );
      }).toList(),
    );
  }
}
