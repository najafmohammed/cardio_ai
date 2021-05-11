import 'package:auto_animated/auto_animated.dart';
import 'package:cardio_ai/homePages/inputPage/InputPrompt_data.dart';
import 'package:cardio_ai/homePages/inputPage/modalSection/modal_tile.dart';
import 'package:cardio_ai/models/inputPromptDataModel.dart';
import 'package:cardio_ai/shared/ColorApp.dart';
import 'package:flutter/material.dart';

class BottomModal extends StatefulWidget {
  const BottomModal({Key key, this.prompt}) : super(key: key);
  final List<inputPromptDataModel> prompt ;
  @override
  _BottomModalState createState() => _BottomModalState();
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
        child: ModalTile(input: prompt[index],index: index,),
      ),
    );

class _BottomModalState extends State<BottomModal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
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
                    onTap: () {},
                    child: Icon(
                      Icons.close,
                      color: Colors.red,
                    )),
              ],
            ),
          ),
          Expanded(
              child: LiveList.options(
            options: options,
            itemBuilder: buildAnimatedItem,
            scrollDirection: Axis.vertical,
            itemCount: prompt.length,
          )),
        ],
      ),
    );
  }
}
